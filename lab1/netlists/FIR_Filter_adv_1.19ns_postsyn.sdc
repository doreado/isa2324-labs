###################################################################

# Created by write_sdc on Mon Nov 20 13:03:51 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_load -pin_load 3.40189 [get_ports {DOUT3k[8]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[7]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[6]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[5]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[4]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[3]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[2]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[1]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k[0]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[8]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[7]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[6]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[5]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[4]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[3]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[2]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[1]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k1[0]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[8]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[7]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[6]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[5]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[4]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[3]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[2]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[1]}]
set_load -pin_load 3.40189 [get_ports {DOUT3k2[0]}]
set_load -pin_load 3.40189 [get_ports VOUT]
create_clock [get_ports CLK]  -period 1.19  -waveform {0 0.595}
set_clock_uncertainty 0.07  [get_clocks CLK]
set_max_delay 1.19  -from [list [get_ports {DIN3k[8]}] [get_ports {DIN3k[7]}] [get_ports          \
{DIN3k[6]}] [get_ports {DIN3k[5]}] [get_ports {DIN3k[4]}] [get_ports           \
{DIN3k[3]}] [get_ports {DIN3k[2]}] [get_ports {DIN3k[1]}] [get_ports           \
{DIN3k[0]}] [get_ports {DIN3k1[8]}] [get_ports {DIN3k1[7]}] [get_ports         \
{DIN3k1[6]}] [get_ports {DIN3k1[5]}] [get_ports {DIN3k1[4]}] [get_ports        \
{DIN3k1[3]}] [get_ports {DIN3k1[2]}] [get_ports {DIN3k1[1]}] [get_ports        \
{DIN3k1[0]}] [get_ports {DIN3k2[8]}] [get_ports {DIN3k2[7]}] [get_ports        \
{DIN3k2[6]}] [get_ports {DIN3k2[5]}] [get_ports {DIN3k2[4]}] [get_ports        \
{DIN3k2[3]}] [get_ports {DIN3k2[2]}] [get_ports {DIN3k2[1]}] [get_ports        \
{DIN3k2[0]}] [get_ports {B[80]}] [get_ports {B[79]}] [get_ports {B[78]}]       \
[get_ports {B[77]}] [get_ports {B[76]}] [get_ports {B[75]}] [get_ports         \
{B[74]}] [get_ports {B[73]}] [get_ports {B[72]}] [get_ports {B[71]}]           \
[get_ports {B[70]}] [get_ports {B[69]}] [get_ports {B[68]}] [get_ports         \
{B[67]}] [get_ports {B[66]}] [get_ports {B[65]}] [get_ports {B[64]}]           \
[get_ports {B[63]}] [get_ports {B[62]}] [get_ports {B[61]}] [get_ports         \
{B[60]}] [get_ports {B[59]}] [get_ports {B[58]}] [get_ports {B[57]}]           \
[get_ports {B[56]}] [get_ports {B[55]}] [get_ports {B[54]}] [get_ports         \
{B[53]}] [get_ports {B[52]}] [get_ports {B[51]}] [get_ports {B[50]}]           \
[get_ports {B[49]}] [get_ports {B[48]}] [get_ports {B[47]}] [get_ports         \
{B[46]}] [get_ports {B[45]}] [get_ports {B[44]}] [get_ports {B[43]}]           \
[get_ports {B[42]}] [get_ports {B[41]}] [get_ports {B[40]}] [get_ports         \
{B[39]}] [get_ports {B[38]}] [get_ports {B[37]}] [get_ports {B[36]}]           \
[get_ports {B[35]}] [get_ports {B[34]}] [get_ports {B[33]}] [get_ports         \
{B[32]}] [get_ports {B[31]}] [get_ports {B[30]}] [get_ports {B[29]}]           \
[get_ports {B[28]}] [get_ports {B[27]}] [get_ports {B[26]}] [get_ports         \
{B[25]}] [get_ports {B[24]}] [get_ports {B[23]}] [get_ports {B[22]}]           \
[get_ports {B[21]}] [get_ports {B[20]}] [get_ports {B[19]}] [get_ports         \
{B[18]}] [get_ports {B[17]}] [get_ports {B[16]}] [get_ports {B[15]}]           \
[get_ports {B[14]}] [get_ports {B[13]}] [get_ports {B[12]}] [get_ports         \
{B[11]}] [get_ports {B[10]}] [get_ports {B[9]}] [get_ports {B[8]}] [get_ports  \
{B[7]}] [get_ports {B[6]}] [get_ports {B[5]}] [get_ports {B[4]}] [get_ports    \
{B[3]}] [get_ports {B[2]}] [get_ports {B[1]}] [get_ports {B[0]}] [get_ports    \
VIN] [get_ports CLK] [get_ports RST_n]]  -to [list [get_ports {DOUT3k[8]}] [get_ports {DOUT3k[7]}] [get_ports          \
{DOUT3k[6]}] [get_ports {DOUT3k[5]}] [get_ports {DOUT3k[4]}] [get_ports        \
{DOUT3k[3]}] [get_ports {DOUT3k[2]}] [get_ports {DOUT3k[1]}] [get_ports        \
{DOUT3k[0]}] [get_ports {DOUT3k1[8]}] [get_ports {DOUT3k1[7]}] [get_ports      \
{DOUT3k1[6]}] [get_ports {DOUT3k1[5]}] [get_ports {DOUT3k1[4]}] [get_ports     \
{DOUT3k1[3]}] [get_ports {DOUT3k1[2]}] [get_ports {DOUT3k1[1]}] [get_ports     \
{DOUT3k1[0]}] [get_ports {DOUT3k2[8]}] [get_ports {DOUT3k2[7]}] [get_ports     \
{DOUT3k2[6]}] [get_ports {DOUT3k2[5]}] [get_ports {DOUT3k2[4]}] [get_ports     \
{DOUT3k2[3]}] [get_ports {DOUT3k2[2]}] [get_ports {DOUT3k2[1]}] [get_ports     \
{DOUT3k2[0]}] [get_ports VOUT]]
