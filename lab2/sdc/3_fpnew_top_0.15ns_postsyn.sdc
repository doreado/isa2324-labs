###################################################################

# Created by write_sdc on Fri Nov 24 12:43:00 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_load -pin_load 3.40189 [get_ports in_ready_o]
set_load -pin_load 3.40189 [get_ports {result_o[15]}]
set_load -pin_load 3.40189 [get_ports {result_o[14]}]
set_load -pin_load 3.40189 [get_ports {result_o[13]}]
set_load -pin_load 3.40189 [get_ports {result_o[12]}]
set_load -pin_load 3.40189 [get_ports {result_o[11]}]
set_load -pin_load 3.40189 [get_ports {result_o[10]}]
set_load -pin_load 3.40189 [get_ports {result_o[9]}]
set_load -pin_load 3.40189 [get_ports {result_o[8]}]
set_load -pin_load 3.40189 [get_ports {result_o[7]}]
set_load -pin_load 3.40189 [get_ports {result_o[6]}]
set_load -pin_load 3.40189 [get_ports {result_o[5]}]
set_load -pin_load 3.40189 [get_ports {result_o[4]}]
set_load -pin_load 3.40189 [get_ports {result_o[3]}]
set_load -pin_load 3.40189 [get_ports {result_o[2]}]
set_load -pin_load 3.40189 [get_ports {result_o[1]}]
set_load -pin_load 3.40189 [get_ports {result_o[0]}]
set_load -pin_load 3.40189 [get_ports {status_o[NV]}]
set_load -pin_load 3.40189 [get_ports {status_o[DZ]}]
set_load -pin_load 3.40189 [get_ports {status_o[OF]}]
set_load -pin_load 3.40189 [get_ports {status_o[UF]}]
set_load -pin_load 3.40189 [get_ports {status_o[NX]}]
set_load -pin_load 3.40189 [get_ports tag_o]
set_load -pin_load 3.40189 [get_ports out_valid_o]
set_load -pin_load 3.40189 [get_ports busy_o]
set_max_delay 0.15  -from [list [get_ports clk_i] [get_ports rst_ni] [get_ports                   \
{operands_i[2][15]}] [get_ports {operands_i[2][14]}] [get_ports                \
{operands_i[2][13]}] [get_ports {operands_i[2][12]}] [get_ports                \
{operands_i[2][11]}] [get_ports {operands_i[2][10]}] [get_ports                \
{operands_i[2][9]}] [get_ports {operands_i[2][8]}] [get_ports                  \
{operands_i[2][7]}] [get_ports {operands_i[2][6]}] [get_ports                  \
{operands_i[2][5]}] [get_ports {operands_i[2][4]}] [get_ports                  \
{operands_i[2][3]}] [get_ports {operands_i[2][2]}] [get_ports                  \
{operands_i[2][1]}] [get_ports {operands_i[2][0]}] [get_ports                  \
{operands_i[1][15]}] [get_ports {operands_i[1][14]}] [get_ports                \
{operands_i[1][13]}] [get_ports {operands_i[1][12]}] [get_ports                \
{operands_i[1][11]}] [get_ports {operands_i[1][10]}] [get_ports                \
{operands_i[1][9]}] [get_ports {operands_i[1][8]}] [get_ports                  \
{operands_i[1][7]}] [get_ports {operands_i[1][6]}] [get_ports                  \
{operands_i[1][5]}] [get_ports {operands_i[1][4]}] [get_ports                  \
{operands_i[1][3]}] [get_ports {operands_i[1][2]}] [get_ports                  \
{operands_i[1][1]}] [get_ports {operands_i[1][0]}] [get_ports                  \
{operands_i[0][15]}] [get_ports {operands_i[0][14]}] [get_ports                \
{operands_i[0][13]}] [get_ports {operands_i[0][12]}] [get_ports                \
{operands_i[0][11]}] [get_ports {operands_i[0][10]}] [get_ports                \
{operands_i[0][9]}] [get_ports {operands_i[0][8]}] [get_ports                  \
{operands_i[0][7]}] [get_ports {operands_i[0][6]}] [get_ports                  \
{operands_i[0][5]}] [get_ports {operands_i[0][4]}] [get_ports                  \
{operands_i[0][3]}] [get_ports {operands_i[0][2]}] [get_ports                  \
{operands_i[0][1]}] [get_ports {operands_i[0][0]}] [get_ports {rnd_mode_i[2]}] \
[get_ports {rnd_mode_i[1]}] [get_ports {rnd_mode_i[0]}] [get_ports {op_i[3]}]  \
[get_ports {op_i[2]}] [get_ports {op_i[1]}] [get_ports {op_i[0]}] [get_ports   \
op_mod_i] [get_ports {src_fmt_i[2]}] [get_ports {src_fmt_i[1]}] [get_ports     \
{src_fmt_i[0]}] [get_ports {dst_fmt_i[2]}] [get_ports {dst_fmt_i[1]}]          \
[get_ports {dst_fmt_i[0]}] [get_ports {int_fmt_i[1]}] [get_ports               \
{int_fmt_i[0]}] [get_ports vectorial_op_i] [get_ports tag_i] [get_ports        \
in_valid_i] [get_ports flush_i] [get_ports out_ready_i]]  -to [list [get_ports in_ready_o] [get_ports {result_o[15]}] [get_ports        \
{result_o[14]}] [get_ports {result_o[13]}] [get_ports {result_o[12]}]          \
[get_ports {result_o[11]}] [get_ports {result_o[10]}] [get_ports               \
{result_o[9]}] [get_ports {result_o[8]}] [get_ports {result_o[7]}] [get_ports  \
{result_o[6]}] [get_ports {result_o[5]}] [get_ports {result_o[4]}] [get_ports  \
{result_o[3]}] [get_ports {result_o[2]}] [get_ports {result_o[1]}] [get_ports  \
{result_o[0]}] [get_ports {status_o[NV]}] [get_ports {status_o[DZ]}]           \
[get_ports {status_o[OF]}] [get_ports {status_o[UF]}] [get_ports               \
{status_o[NX]}] [get_ports tag_o] [get_ports out_valid_o] [get_ports busy_o]]
