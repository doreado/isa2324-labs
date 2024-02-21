onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DLX_1/DATAPATH_1/CLK
add wave -noupdate /tb/DLX_1/DATAPATH_1/RST
add wave -noupdate -divider IF
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/PC
add wave -noupdate -divider IF/ID
add wave -noupdate -radix hexadecimal -childformat {{/tb/DLX_1/DATAPATH_1/IR(31) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(30) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(29) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(28) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(27) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(26) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(25) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(24) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(23) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(22) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(21) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(20) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(19) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(18) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(17) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(16) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(15) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(14) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(13) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(12) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(11) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(10) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(9) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(8) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(7) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(6) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(5) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(4) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(3) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(2) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(1) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/IR(0) -radix hexadecimal}} -subitemconfig {/tb/DLX_1/DATAPATH_1/IR(31) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(30) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(29) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(28) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(27) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(26) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(25) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(24) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(23) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(22) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(21) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(20) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(19) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(18) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(17) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(16) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(15) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(14) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(13) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(12) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(11) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(10) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(9) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(8) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(7) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(6) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(5) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(4) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(3) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(2) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(1) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/IR(0) {-height 16 -radix hexadecimal}} /tb/DLX_1/DATAPATH_1/IR
add wave -noupdate -divider ID
add wave -noupdate /tb/DLX_1/DATAPATH_1/CW.decode
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_CMP_A_SEL
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/mux_fwd_cmp_a_out
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_CMP_B_SEL
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/mux_fwd_cmp_b_out
add wave -noupdate /tb/DLX_1/DATAPATH_1/a_gte_b
add wave -noupdate -radix hexadecimal -childformat {{/tb/DLX_1/DATAPATH_1/target_addr(31) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(30) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(29) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(28) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(27) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(26) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(25) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(24) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(23) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(22) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(21) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(20) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(19) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(18) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(17) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(16) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(15) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(14) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(13) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(12) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(11) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(10) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(9) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(8) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(7) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(6) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(5) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(4) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(3) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(2) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(1) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/target_addr(0) -radix hexadecimal}} -expand -subitemconfig {/tb/DLX_1/DATAPATH_1/target_addr(31) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(30) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(29) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(28) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(27) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(26) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(25) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(24) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(23) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(22) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(21) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(20) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(19) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(18) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(17) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(16) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(15) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(14) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(13) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(12) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(11) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(10) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(9) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(8) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(7) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(6) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(5) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(4) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(3) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(2) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(1) {-radix hexadecimal} /tb/DLX_1/DATAPATH_1/target_addr(0) {-radix hexadecimal}} /tb/DLX_1/DATAPATH_1/target_addr
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/MUX_COND_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/OPCODE
add wave -noupdate /tb/DLX_1/DATAPATH_1/FUNCT3
add wave -noupdate /tb/DLX_1/DATAPATH_1/FUNCT7
add wave -noupdate /tb/DLX_1/DATAPATH_1/INS_RS1
add wave -noupdate /tb/DLX_1/DATAPATH_1/INS_RS2
add wave -noupdate /tb/DLX_1/DATAPATH_1/INS_RD
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/MUX_IMM_OUT
add wave -noupdate -group IMM -radix hexadecimal /tb/DLX_1/DATAPATH_1/INS_I_IMM
add wave -noupdate -group IMM -radix hexadecimal /tb/DLX_1/DATAPATH_1/INS_U_IMM
add wave -noupdate -group IMM -radix hexadecimal /tb/DLX_1/DATAPATH_1/INS_UJ_IMM
add wave -noupdate -group IMM -radix hexadecimal /tb/DLX_1/DATAPATH_1/INS_S_IMM
add wave -noupdate -group IMM -radix hexadecimal /tb/DLX_1/DATAPATH_1/INS_SB_IMM
add wave -noupdate -divider EX
add wave -noupdate /tb/DLX_1/DATAPATH_1/CW.execute
add wave -noupdate -divider MEM
add wave -noupdate /tb/DLX_1/DATAPATH_1/CW.memory
add wave -noupdate -divider MEM/WB
add wave -noupdate -divider WB
add wave -noupdate /tb/DLX_1/DATAPATH_1/CW.wb
add wave -noupdate -radix hexadecimal /tb/DLX_1/DATAPATH_1/MUX_LMD_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/SECW
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_MEM_LMD_SEL
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_EX_LMD_SEL
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_A_SEL
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_B_SEL
add wave -noupdate /tb/DLX_1/DATAPATH_1/dp_to_fu
add wave -noupdate /tb/DLX_1/DATAPATH_1/dp_to_hu
add wave -noupdate /tb/DLX_1/DATAPATH_1/OUT_CW
add wave -noupdate /tb/DLX_1/DATAPATH_1/DRAM_IN
add wave -noupdate /tb/DLX_1/DATAPATH_1/DRAM_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/IRAM_DATA
add wave -noupdate /tb/DLX_1/DATAPATH_1/IRAM_ADDRESS
add wave -noupdate /tb/DLX_1/DATAPATH_1/DRAM_ADDRESS
add wave -noupdate /tb/DLX_1/DATAPATH_1/NPC
add wave -noupdate /tb/DLX_1/DATAPATH_1/RF_OUT_1
add wave -noupdate /tb/DLX_1/DATAPATH_1/RF_OUT_2
add wave -noupdate /tb/DLX_1/DATAPATH_1/A
add wave -noupdate /tb/DLX_1/DATAPATH_1/B
add wave -noupdate /tb/DLX_1/DATAPATH_1/IMM
add wave -noupdate /tb/DLX_1/DATAPATH_1/NPC_ID
add wave -noupdate /tb/DLX_1/DATAPATH_1/RD_ID
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_R_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/RS_ID
add wave -noupdate /tb/DLX_1/DATAPATH_1/RT_ID
add wave -noupdate /tb/DLX_1/DATAPATH_1/ALU_IN_1
add wave -noupdate /tb/DLX_1/DATAPATH_1/ALU_IN_2
add wave -noupdate /tb/DLX_1/DATAPATH_1/ALU_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/ALU_OUT_REG
add wave -noupdate /tb/DLX_1/DATAPATH_1/COND
add wave -noupdate /tb/DLX_1/DATAPATH_1/B_EX
add wave -noupdate /tb/DLX_1/DATAPATH_1/B_TAKEN
add wave -noupdate /tb/DLX_1/DATAPATH_1/NPC_EX
add wave -noupdate /tb/DLX_1/DATAPATH_1/RD_EX
add wave -noupdate /tb/DLX_1/DATAPATH_1/LMD
add wave -noupdate /tb/DLX_1/DATAPATH_1/ALU_OUT_REG_ME
add wave -noupdate /tb/DLX_1/DATAPATH_1/RD_MEM
add wave -noupdate /tb/DLX_1/DATAPATH_1/NPC_MEM
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_MEM_LMD_OUT
add wave -noupdate /tb/DLX_1/DATAPATH_1/MUX_FWD_EX_LMD_OUT
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/cu_to_fu
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/dp_to_fu
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_FWD_MEM_LMD_SEL
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_FWD_EX_LMD_SEL
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_FWD_CMP_A_SEL
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_FWD_CMP_B_SEL
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_A_SEL
add wave -noupdate -group FU /tb/DLX_1/forwarding_unit_1/MUX_B_SEL
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/ENABLE
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/RD1
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/RD2
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/WR
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/ADD_WR
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/ADD_RD1
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/ADD_RD2
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/DATAIN
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/OUT1
add wave -noupdate -group RF /tb/DLX_1/DATAPATH_1/RF_i/OUT2
add wave -noupdate -group RF -radix hexadecimal -childformat {{/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(0) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(1) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(2) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(3) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(4) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(5) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(6) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(7) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(8) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(9) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(10) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(11) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(12) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(13) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(14) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(15) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(16) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(17) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(18) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(19) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(20) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(21) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(22) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(23) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(24) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(25) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(26) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(27) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(28) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(29) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(30) -radix hexadecimal} {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(31) -radix hexadecimal}} -expand -subitemconfig {/tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(0) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(1) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(2) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(3) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(4) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(5) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(6) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(7) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(8) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(9) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(10) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(11) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(12) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(13) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(14) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(15) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(16) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(17) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(18) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(19) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(20) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(21) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(22) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(23) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(24) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(25) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(26) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(27) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(28) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(29) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(30) {-height 16 -radix hexadecimal} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS(31) {-height 16 -radix hexadecimal}} /tb/DLX_1/DATAPATH_1/RF_i/REGISTERS
add wave -noupdate -expand -group HDU -expand /tb/DLX_1/HAZARD_DETECTION_UNIT_1/cu_to_hu
add wave -noupdate -expand -group HDU /tb/DLX_1/HAZARD_DETECTION_UNIT_1/dp_to_hu
add wave -noupdate -expand -group HDU /tb/DLX_1/HAZARD_DETECTION_UNIT_1/DRAM_READY
add wave -noupdate -expand -group HDU /tb/DLX_1/HAZARD_DETECTION_UNIT_1/IRAM_READY
add wave -noupdate -expand -group HDU /tb/DLX_1/HAZARD_DETECTION_UNIT_1/RST
add wave -noupdate -expand -group HDU /tb/DLX_1/HAZARD_DETECTION_UNIT_1/SECW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {470 ps} {3030 ps}
