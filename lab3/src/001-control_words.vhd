library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.alu_type.all;
use work.myTypes.all;

package control_words is

    -----------------------------------------------------------------------------
    -- Pipeline control signals type definitions
    -----------------------------------------------------------------------------

    -- Symbols to distinguish diffent immediate modes in control words.
    type imm_t is (u_imm, uj_imm, i_imm, s_imm, sb_imm, zero);

    type decode_cw_t is record
        RF_RESET   : std_logic; -- register file reset signal
        RF_ENABLE  : std_logic; -- register file enable signal
        RF_RD1     : std_logic; -- register file read port one signal
        RF_RD2     : std_logic; -- register file read port two signal
        cmp_sel    : std_logic; -- Select how to extend operands in branch comparator (1: signed, 0: unsigned)
        imm_sel    : imm_t;     -- Select the second operand used to compute the target address 
        is_jalr    : std_logic;
        MUX_COND_SEL : std_logic_vector(1 downto 0); -- used to distinguish bge, blt, jal
        MUX_SIGNED : std_logic; -- MUX_SIGNED selection signal
        MUX_J_SEL  : std_logic; -- MUX_J_SEL selection signal TODO: useless
        MUX_R_SEL  : std_logic_vector(1 downto 0); -- selects between RD, RS and LR
    end record decode_cw_t;

    type execute_cw_t is record
        ALU_OP         : alu_op_t;
        MUX_A_SEL      : std_logic; -- MUX_A selection signal
        MUX_B_SEL      : std_logic; -- MUX_B selection signal
    end record execute_cw_t;

    type memory_cw_t is record
        LMD_EN            : std_logic; -- Loaded memory data latch enable
        DRAM_ENABLE       : std_logic; -- data memory enable signal
        DRAM_READNOTWRITE : std_logic; -- data memory r/w signal
    end record memory_cw_t;

    type wb_cw_t is record
        RF_WR       : std_logic; -- register file write port signal
        MUX_LMD_SEL : std_logic_vector(1 downto 0); -- MUX_LMD selection signal
    end record wb_cw_t;

    type cw_t is record
        decode  : decode_cw_t;
        execute : execute_cw_t;
        memory  : memory_cw_t;
        wb      : wb_cw_t;
    end record cw_t;

    type cw_from_mem is record
        IRAM_DATA_READY : std_logic; -- instruction ram data ready signal
        DRAM_DATA_READY : std_logic;
    end record cw_from_mem;

    -----------------------------------------------------------------------------
    -- Control word signal definition
    -----------------------------------------------------------------------------


    ---------------------------- I TYPE

    -- ADDI
    constant ADDI_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => i_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "01"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "01"
        )
    );

    -- auipc: pc + {imm, 12'b0}
    constant AUIPC_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => u_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "01"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "01"
        )
    );

    -- SW
    constant SW_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => s_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "01"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '1',
            DRAM_READNOTWRITE => '0'
        ),
        wb      => (
            RF_WR       => '0',
            MUX_LMD_SEL => "01"
        )
    );

    -- LW
    constant LW_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => i_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "01"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '1',
            DRAM_ENABLE       => '1',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "00"
        )
    );

    -- NOP
    constant NOP_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '1',
            cmp_sel      => '0',
            imm_sel      => zero,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "01"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '0',
            MUX_LMD_SEL => "01"
        )
    );

    -- R TYPE
    constant RTYPE_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '1',
            cmp_sel      => '0',
            imm_sel      => zero,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '0'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "01"
        )
    );

    -- JAL
    constant JAL_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '0',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => uj_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "11",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '1',
            MUX_R_SEL    => "10"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '0',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "10"
        )
    );

    -- JALR
    constant JALR_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => i_imm,
            is_jalr      => '1',
            MUX_COND_SEL => "11",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '1',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '1',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "01"
        )
    );

    -- BGE
    constant BGE_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '1',
            cmp_sel      => '1',
            imm_sel      => sb_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "01",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '0',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '0',
            MUX_LMD_SEL => "01"
        )
    );

    -- BLTU
    constant BLTU_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '1',
            cmp_sel      => '0',
            imm_sel      => sb_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "01",
            MUX_SIGNED   => '0',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '0',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '0',
            MUX_LMD_SEL => "01"
        )
    );

    -- LUI
    constant LUI_CW : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '0',
            RF_RD2       => '0',
            cmp_sel      => '0',
            imm_sel      => u_imm,
            is_jalr      => '0',
            MUX_COND_SEL => "01",
            MUX_SIGNED   => '0',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '0',
            MUX_B_SEL => '1'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '1',
            MUX_LMD_SEL => "01"
        )
    );

    ---------------------------- RESET

    -- Reset Init
    signal init_cw : cw_t := (
        decode  => (
            RF_RESET     => '0',
            RF_ENABLE    => '1',
            RF_RD1       => '1',
            RF_RD2       => '1',
            cmp_sel      => '0',
            imm_sel      => zero,
            is_jalr      => '0',
            MUX_COND_SEL => "00",
            MUX_SIGNED   => '1',
            MUX_J_SEL    => '0',
            MUX_R_SEL    => "00"
        ),
        execute => (
            ALU_OP    => alu_add,
            MUX_A_SEL => '0',
            MUX_B_SEL => '0'
        ),
        memory  => (
            LMD_EN            => '0',
            DRAM_ENABLE       => '0',
            DRAM_READNOTWRITE => '1'
        ),
        wb      => (
            RF_WR       => '0',
            MUX_LMD_SEL => "00"
        )
    );

    -----------------------------------------------------------------------------
    -- Stalls control
    -----------------------------------------------------------------------------

    ---------------------------- Definition

    type stage_enable_t is record
        FLUSH_IF : std_logic;
        PREFETCH : std_logic;
        FETCH    : std_logic;
        DECODE   : std_logic;
        EXECUTE  : std_logic;
        MEMORY   : std_logic;
        WB       : std_logic;
    end record stage_enable_t;

    ---------------------------- Constants

    constant STALL_CLEAR : stage_enable_t := (
        FLUSH_IF => '0',
        PREFETCH => '1',
        FETCH    => '1',
        DECODE   => '1',
        EXECUTE  => '1',
        MEMORY   => '1',
        WB       => '1'
    );

    -----------------------------------------------------------------------------
    -- Functions
    -----------------------------------------------------------------------------
    -- insert_stall: insert a new stall without overriding the target SECW
    pure function insert_stall(secw : stage_enable_t; stall_to_insert : stage_enable_t) return stage_enable_t;

end package control_words;

package body control_words is
    pure function insert_stall(secw : stage_enable_t; stall_to_insert : stage_enable_t) return stage_enable_t is
    variable result : stage_enable_t;
begin
    -- Perform the AND operation for each field
    result.PREFETCH := secw.PREFETCH and stall_to_insert.PREFETCH;
    result.FETCH    := secw.FETCH and stall_to_insert.FETCH;
    result.DECODE   := secw.DECODE and stall_to_insert.DECODE;
    result.EXECUTE  := secw.EXECUTE and stall_to_insert.EXECUTE;
    result.MEMORY   := secw.MEMORY and stall_to_insert.MEMORY;
    result.WB       := secw.WB and stall_to_insert.WB;

    -- Return the result
    return result;
end function insert_stall;

end control_words;
