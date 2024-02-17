library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

package myTypes is

    ---- CONSTANTS -----

    -- Data
    constant numBit : integer := 32;
    subtype data_t is std_logic_vector(numBit - 1 downto 0);
    subtype double_data_t is std_logic_vector(2 * numBit - 1 downto 0);

    -- Instructions Size
    constant INS_SIZE : integer := 32;
    subtype ins_t is std_logic_vector(INS_SIZE - 1 downto 0);
    constant INS_OP_CODE_SIZE : integer := 7;  -- OPCODE field size
    constant INS_R1_SIZE      : integer := 5;  -- R1 field size
    constant INS_R2_SIZE      : integer := 5;  -- R2 field size
    constant INS_R3_SIZE      : integer := 5;  -- R3 field size
    constant INS_FUNCT7_SIZE  : integer := 7;  -- FUNCT7 size
    constant INS_FUNCT3_SIZE  : integer := 3;  -- FUNCT3 size
    constant INS_IMM_SIZE     : integer := 12; -- IMM field size

    constant INS_U_IMM_SIZE     : integer := 20; -- IMM field size
    constant INS_UJ_IMM_SIZE     : integer := 20;
    constant INS_S_IMM_SIZE     : integer := 12; -- IMM field size
    constant INS_SB_IMM_SIZE     : integer := 12; -- IMM field size
    --constant INS_FUNC_SIZE    : integer := 11; -- FUNC field size

    -- Instrucions Left and Right bit
    constant INS_OP_CODE_L : integer := 6;
    constant INS_OP_CODE_R : integer := 0;
    constant INS_R1_L      : integer := 19;
    constant INS_R1_R      : integer := 15;
    constant INS_R2_L      : integer := 24;
    constant INS_R2_R      : integer := 20;
    constant INS_R3_L      : integer := 11;
    constant INS_R3_R      : integer := 7;
    constant INS_IMM_L     : integer := 31;
    constant INS_IMM_R     : integer := 20;

    constant INS_U_IMM_L    : integer := 31;
    constant INS_U_IMM_R    : integer := 12;
    constant INS_S_IMM_UP_L  : integer := 31;  
    constant INS_S_IMM_UP_R  : integer := 25;  
    constant INS_S_IMM_DOWN_L : integer := 11;  
    constant INS_S_IMM_DOWN_R  : integer := 7; 
    
    constant INS_SB_IMM_UP  : integer := 31;
    constant INS_SB_IMM_UP_L   : integer := 30;  
    constant INS_SB_IMM_UP_R   : integer := 25;  
    constant INS_SB_IMM_DOWN_L   : integer := 11;  
    constant INS_SB_IMM_DOWN_R  : integer := 8; 
    constant INS_SB_IMM_DOWN : integer :=7; 

    constant INS_UJ_IMM_UP  : integer := 31;
    constant INS_UJ_IMM_UP_L   : integer := 30;  
    constant INS_UJ_IMM_UP_R   : integer := 21;  
    constant INS_UJ_IMM_DOWN_L   : integer := 19;  
    constant INS_UJ_IMM_DOWN_R  : integer := 12; 
    constant INS_UJ_IMM_DOWN : integer :=20; 


    constant INS_J_IMM_L   : integer := 25;
    constant INS_J_IMM_R   : integer := 0;

    constant INS_FUNC7_L    : integer := 31;
    constant INS_FUNC7_R    : integer := 25;
    constant INS_FUNC3_L    : integer := 14;
    constant INS_FUNC3_R    : integer := 12;

    -- Mux
    constant IVDELAY     : time := 0 ns; --0.1 ns;
    constant NDDELAY     : time := 0 ns; -- 0.2 ns;
    constant NDDELAYRISE : time := 0 ns; -- 0.6 ns;
    constant NDDELAYFALL : time := 0 ns; -- 0.4 ns;
    constant NRDELAY     : time := 0 ns; -- 0.2 ns;
    constant DRCAS       : time := 0 ns; -- 1
    constant DRCAC       : time := 0 ns; -- 2
    constant TP_MUX      : time := 0 ns;

    -- Adder
    constant CARRY_SELECT_NBIT     : integer := 4;                        -- how many bits generate a carry
    constant SUM_GENERATOR_NBLOCKS : integer := numBit/CARRY_SELECT_NBIT; -- numBit / CARRY_SELECT_NBIT

    -- Register File
    constant R_NUM       : integer := 32;
    constant RF_WORD_LEN : integer := 32;
    constant RF_REG_NUM  : integer := 8;
    constant RF_ADDR_LEN : integer := integer(ceil(log2(real(R_NUM))));
    constant LR_INDEX    : integer := 31; -- link register, or last register in RF

    -- TestBench
    constant C_TB_STAGES : integer := 3; -- Number of Clock Cycles between two instructions

    -- xRAM
    constant DRAM_DEPTH     : integer := 256;
    constant IRAM_DEPTH     : integer := 1024;
    constant PC_SIZE        : integer := numBit;
    constant IRAM_ADDR_SIZE : integer := PC_SIZE;
    subtype pc_t is unsigned(PC_SIZE - 1 downto 0);
    subtype addr_t is unsigned(PC_SIZE - 1 downto 0);

    -- RAM Delays
    constant DRAM_DELAY : integer := 0;
    constant IRAM_DELAY : integer := 0;

    -- Control Unit Input Sizes
    constant C_OP_CODE_SIZE : integer := 7;        -- OPCODE field size
    constant C_FUNC3_SIZE    : integer := 3;       -- FUNC field size
    constant C_FUNC7_SIZE    : integer := 7;
    constant C_IR_SIZE      : integer := INS_SIZE; -- Instruction Register Size
    constant C_CW_SIZE      : integer := 30;       -- Control Word Size
    constant ALU_OP_SIZE    : integer := 2;

    -- Number of Available Instructions
    constant C_NUM_OF_R_INSTRUCTION : integer := 5;
    constant C_NUM_OF_I_INSTRUCTION : integer := 14;
    constant C_NUM_OF_INSTRUCTION   : integer := C_NUM_OF_R_INSTRUCTION + C_NUM_OF_I_INSTRUCTION;

    -- Micro Programmed CU Constants
    constant C_INSTRUCTION_CC : integer := 3;                            -- Instructions Execution Clock Cycles (#n of stages)
    constant C_RELOC_MEM_SIZE : integer := (C_NUM_OF_I_INSTRUCTION + 1); -- Microcode Relocation Memory Size
    constant C_UCODE_MEM_SIZE : integer := (C_RELOC_MEM_SIZE * 3 + 1);   -- Microcode Memory Size

    ---- INSTRUCTIONS -----
    subtype funct3_t is std_logic_vector(C_FUNC3_SIZE - 1 downto 0);
    subtype funct7_t is std_logic_vector(C_FUNC7_SIZE - 1 downto 0);
    subtype opcode_t is std_logic_vector(C_OP_CODE_SIZE -1 downto 0);

    -- R-Type instruction -> FUNC field
    constant FUNC3_ADD  : funct3_t := "000";
    constant FUNC7_ADD  : funct7_t := "0000000";
    constant FUNC3_SUB  : funct3_t := "000";
    constant FUNC7_SUB  : funct7_t := "0100000";
   

    -- I-Type instruction -> FUNC field
    constant FUNC3_ADDI : funct3_t := "000";
    constant FUNC3_SW   : funct3_t := "010";
    constant FUNC3_LW   : funct3_t := "010";
    constant FUNC3_JALR : funct3_t := "000";

    -- SB-Type instruction -> FUNC field
    constant FUNC3_BGE  : funct3_t := "101";
    constant FUNC3_BLTU : funct3_t := "110";

    -- R-Type instruction -> OPCODE field
    constant RTYPE : opcode_t := "0110011";
    --constant RTYPE_SUB : opcode_t := "0110011";

    -- I-Type instruction -> OPCODE field
    constant ITYPE_ADDI  : opcode_t := "0010011";
    
    constant ITYPE_LW    : opcode_t := "0000011";
    constant ITYPE_JALR  : opcode_t := "1100111";
    
    -- SB-Type instruction -> OPCODE field
     --constant SBTYPE_BGE  : opcode_t := "1100011";   --for ble
    -- constant SBTYPE_BLTU : opcode_t := "1100011";
    constant SBTYPE       : opcode_t := "1100011";
    constant STYPE_SW    : opcode_t := "0100011";
    -- UJ-Type instruction -> OPCODE field
    --constant JTYPE_J   : opcode_t := "000010";
    constant UJTYPE_JAL : opcode_t := "1101111";
    

     -- U-Type instruction -> OPCODE field
     constant UTYPE_AUIPC : opcode_t := "0010111";
     constant UTYPE_LUI   : opcode_t := "0110111";


    -- N-Type instruction -> OPCODE field
    --constant NTYPE_NOP : opcode_t := "010101";

    -- Only for simulation purpose
    constant RO_HEX      : string := "./memories/ro/hex.txt";
    constant RW_HEX_INIT : string := "./memories/rw/hex_init.txt";
    constant RW_HEX      : string := "./memories/rw/hex.txt";
    -- LORENZO
    -- constant RO_HEX      : string := "C:\Users\ruoto\OneDrive\UNI\08 MS Microelectronic Systems\Progetto\ms\dlx\src\memories\ro\hex.txt";
    -- constant RW_HEX_INIT : string := "C:\Users\ruoto\OneDrive\UNI\08 MS Microelectronic Systems\Progetto\ms\dlx\src\memories\rw\hex_init.txt";
    -- constant RW_HEX      : string := "C:\Users\ruoto\OneDrive\UNI\08 MS Microelectronic Systems\Progetto\ms\dlx\src\memories\rw\hex.txt";

    ---- Process declarations ----
    pure function to_data(arg : pc_t) return data_t;
    pure function to_data(arg : signed) return data_t;

    type dp_to_fu_t is record
        rs1_F     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        rs2_F     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RD_ID     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RD_EX     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RD_MEM    : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RS_ID     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RT_ID     : std_logic_vector(INS_R1_SIZE - 1 downto 0);
    end record;

    type cu_to_fu_t is record
        RF_WR_EX  : std_logic;
        RF_WR_MEM : std_logic;
        MUX_A_CU  : std_logic;
        MUX_B_CU  : std_logic;
        DRAM_READNOTWRITE : std_logic;
        DRAM_ENABLE_MEM   : std_logic;
        DRAM_ENABLE_EX    : std_logic;
        IS_JUMP_EX        : std_logic;
        MUX_COND_SEL      : std_logic_vector(1 downto 0);
    end record;

    type dp_to_hu_t is record
        RT_ID  : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RS_IF  : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        RT_IF  : std_logic_vector(INS_R1_SIZE - 1 downto 0);
        B_TAKEN : std_logic;
    end record;

    type cu_to_hu_t is record
        LMD_EN     : std_logic;
        IS_JUMP_ID : std_logic;
        IS_JUMP_EX : std_logic;
        IS_B_ID : std_logic_vector(1 downto 0);
        IS_B_EX : std_logic_vector(1 downto 0);
    end record;

end myTypes;

package body myTypes is
    pure function to_data(arg : pc_t) return data_t is
begin
    return data_t(resize(unsigned(arg), numBit));
end function to_data;

    pure function to_data(arg : signed) return data_t is
    begin
        return data_t(resize(arg, numBit));
    end function to_data;

end package body myTypes;
