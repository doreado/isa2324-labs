library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.myTypes.all;
use work.ALU_TYPE.all;
use work.control_words.all;

--------------------------------------------------------------------
-- Entity Declaration
--------------------------------------------------------------------

entity CU is
    port (
        CLK : in std_logic;
        RST : in std_logic; -- Active High
        Imm : out std_logic_vector( 2 downto 0);
        -- Control
        CW       : out cw_t; -- control word for datapath and memories
        cu_to_fu : out cu_to_fu_t;
        cu_to_hu : out cu_to_hu_t;
        STALL    : in stage_enable_t;
        -- Inputs
        IN_CW  : in cw_from_mem;
        OPCODE : in opcode_t;
        FUNC7  : in func7_t;
        FUNC3  : in func3_t;
        -- RAM
        IRAM_ENABLE       : out std_logic;
        DRAM_ENABLE       : out std_logic;
        DRAM_READNOTWRITE : out std_logic
    );
end CU;

architecture RTL of CU is

    ----------------------------------------------------------------
    -- Signals Declaration
    ----------------------------------------------------------------

    signal FUNC7_OP : func7_t;
    signal FUNC3_OP : func3_t;

    ---------------------------- CW Pipeline
    signal cw_s, cw2, cw3, cw4 : cw_t;

    -- These signals are needed to avoid conflicts on the cw registers.
    signal ALU_OPCODE, ALU_OPCODE_UPDATED : alu_op_t; -- OPCODE updated after ID stage

begin

    ----------------------------------------------------------------
    -- Signals Assignment
    ----------------------------------------------------------------

    ---------------------------- CW Pipeline
    -- Convert the func field into enum type func_t
    FUNC7_OP <= FUNC7;
    FUNC3_OP <= FUNC3;

    -- Assign the control signals to the outputs
    CW <= (
        cw_s.decode,
        (
        ALU_OPCODE_UPDATED,
        cw2.execute.MUX_A_SEL,
        cw2.execute.MUX_B_SEL
        ),
        cw3.memory,
        cw4.wb
        );

    ---------------------------- Forwarding unit
    cu_to_fu <= (
        DRAM_READNOTWRITE => cw3.memory.DRAM_READNOTWRITE,
        DRAM_ENABLE_MEM   => cw3.memory.DRAM_ENABLE,
        DRAM_ENABLE_EX    => cw2.memory.DRAM_ENABLE,
        RF_WR_EX          => cw3.wb.RF_WR,
        RF_WR_MEM         => cw4.wb.RF_WR,
        MUX_A_CU          => cw2.execute.MUX_A_SEL,
        MUX_B_CU          => cw2.execute.MUX_B_SEL,
        IS_JUMP_EX        => cw2.decode.MUX_J_SEL,
        MUX_COND_SEL      => cw2.decode.MUX_COND_SEL
        );

    ---------------------------- Hazard detectino unit
    cu_to_hu <= (
        LMD_EN     => cw2.memory.LMD_EN,
        IS_JUMP_ID => cw_s.decode.MUX_J_SEL,
        IS_JUMP_EX => cw2.decode.MUX_J_SEL,
        IS_B_ID    => cw_s.decode.MUX_COND_SEL,
        IS_B_EX    => cw2.decode.MUX_COND_SEL
        );

    ---------------------------- RAM
    IRAM_ENABLE       <= '1';
    DRAM_ENABLE       <= cw3.memory.DRAM_ENABLE;
    DRAM_READNOTWRITE <= cw3.memory.DRAM_READNOTWRITE;

    ----------------------------------------------------------------
    -- Processes
    ----------------------------------------------------------------

    ---------------------------- CW Pipeline
    -- OPCODE is used as index of cw_mem.
    -- get the complete control word of the current instruction
    CW_S_UP : process (OPCODE,FUNC3_OP,STALL.FETCH)
    begin
        -- if stalling
        if STALL.FETCH = '0' then
            cw_s <= NOP_CW;
        else
            case OPCODE is
                when UTYPE_AUIPC => 
                    cw_s <= AUIPC_CW;
                    imm <= "001";
                --when UTYPE_LUI => 
                  --  cw_s <= LUI_CW;
                when ITYPE_ADDI => -- ITYPE
                    cw_s <= ADDI_CW;
                    imm <= "000";
                --when NTYPE_NOP => -- NTYPE
                    --cw_s <= NOP_CW;
                when STYPE_SW =>
                    cw_s <= SW_CW;
                    imm <= "100";
                when ITYPE_LW =>
                    cw_s <= LW_CW;
                    imm <= "000";
                when ITYPE_JALR =>
                    cw_s <= JALR_CW;
                    imm <= "000";
                --when JTYPE_J => -- JTYPE
                   -- cw_s <= J_CW;
                when UJTYPE_JAL =>
                    cw_s <= JAL_CW;
                    imm <= "010";
                when SBTYPE =>
                    imm <= "101";
                    if(FUNC3_OP = FUNC3_BGE ) then
                        cw_s <= BGE_CW;
                    end if;
                    if(FUNC3_OP = FUNC3_BLTU ) then
                        cw_s <= BLTU_CW;
                    end if; 
                when others => -- RTYPE
                    cw_s <= RTYPE_CW;
            end case;
        end if;
    end process;

    -- process to pipeline control words
    CW_PIPE : process (clk, rst)
    begin -- process clk
        if rst = '1' then
            cw2 <= init_cw;
            cw3 <= init_cw;
            cw4 <= init_cw;
        elsif falling_edge(clk) then
            ALU_OPCODE_UPDATED <= ALU_OPCODE;
            -- shift the slice of the control word to the correct control register
            -- update CW pipeline if not stalling
            if STALL.DECODE = '1' then
                cw2 <= cw_s;
            end if;
            if STALL.EXECUTE = '1' then
                cw3 <= cw2;
            end if;
            if STALL.MEMORY = '1' then
                cw4 <= cw3;
            end if;

            -- if right-most stage when stalling, insert NOP in CW
            if STALL.MEMORY = '0' then
                cw4 <= NOP_CW;
            elsif STALL.EXECUTE = '0' then
                cw3 <= NOP_CW;
            elsif STALL.DECODE = '0' then
                cw2 <= NOP_CW;
            end if;
        end if;
    end process CW_PIPE;

    -- ALU_OPCODE Generation (from FUNC for R-Type Instructions)
    ALU_OPCODE_P : process (OPCODE, FUNC7_OP, cw_s)
    begin

        ALU_OPCODE <= cw_s.execute.ALU_OP;

        -- Because all RTYPE instructions index the same element in cw_mem, we
        -- use the FUNC field to select correctly their ALU_OPCODE.
        -- Updating directly CW(6) and CW(5) would gerenare a conflict
        if (OPCODE = RTYPE) then
            case FUNC7_OP is
                when func7_add =>
                    ALU_OPCODE <= alu_add;
                when func7_sub =>
                    ALU_OPCODE <= alu_sub;
                when others =>
                    ALU_OPCODE <= alu_add;
            end case;
        end if;
    end process ALU_OPCODE_P;
end RTL;

----------------------------------------------------------------
-- Configurations
----------------------------------------------------------------

configuration CFG_CU_BEH of CU is
    for RTL
    end for;
end configuration;
