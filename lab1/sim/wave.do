onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/CLK_i
add wave -noupdate /tb/RST_n_i
add wave -noupdate /tb/DIN3k_i
add wave -noupdate /tb/DIN3k1_i
add wave -noupdate /tb/DIN3k2_i
add wave -noupdate /tb/VIN_i
add wave -noupdate /tb/B
add wave -noupdate /tb/DOUT3k_i
add wave -noupdate /tb/DOUT3k1_i
add wave -noupdate /tb/DOUT3k2_i
add wave -noupdate /tb/VOUT_i
add wave -noupdate /tb/END_SIM_i
add wave -noupdate -radix decimal /tb/UUT/DIN3k
add wave -noupdate -radix decimal /tb/UUT/DIN3k1
add wave -noupdate -radix decimal /tb/UUT/DIN3k2
add wave -noupdate -radix decimal /tb/UUT/DOUT3k
add wave -noupdate -radix decimal /tb/UUT/DOUT3k1
add wave -noupdate -radix decimal /tb/UUT/DOUT3k2
add wave -noupdate -childformat {{/tb/UUT/B(0) -radix decimal} {/tb/UUT/B(1) -radix decimal} {/tb/UUT/B(2) -radix decimal} {/tb/UUT/B(3) -radix decimal} {/tb/UUT/B(4) -radix decimal} {/tb/UUT/B(5) -radix decimal} {/tb/UUT/B(6) -radix decimal} {/tb/UUT/B(7) -radix decimal} {/tb/UUT/B(8) -radix decimal}} -subitemconfig {/tb/UUT/B(0) {-height 16 -radix decimal} /tb/UUT/B(1) {-height 16 -radix decimal} /tb/UUT/B(2) {-height 16 -radix decimal} /tb/UUT/B(3) {-height 16 -radix decimal} /tb/UUT/B(4) {-height 16 -radix decimal} /tb/UUT/B(5) {-height 16 -radix decimal} /tb/UUT/B(6) {-height 16 -radix decimal} /tb/UUT/B(7) {-height 16 -radix decimal} /tb/UUT/B(8) {-height 16 -radix decimal}} /tb/UUT/B
add wave -noupdate /tb/UUT/VIN
add wave -noupdate /tb/UUT/VOUT
add wave -noupdate /tb/UUT/CLK
add wave -noupdate /tb/UUT/RST_n
add wave -noupdate -radix decimal -childformat {{/tb/UUT/x(0) -radix decimal} {/tb/UUT/x(1) -radix decimal} {/tb/UUT/x(2) -radix decimal} {/tb/UUT/x(3) -radix decimal} {/tb/UUT/x(4) -radix decimal} {/tb/UUT/x(5) -radix decimal} {/tb/UUT/x(6) -radix decimal} {/tb/UUT/x(7) -radix decimal} {/tb/UUT/x(8) -radix decimal}} -subitemconfig {/tb/UUT/x(0) {-height 16 -radix decimal} /tb/UUT/x(1) {-height 16 -radix decimal} /tb/UUT/x(2) {-height 16 -radix decimal} /tb/UUT/x(3) {-height 16 -radix decimal} /tb/UUT/x(4) {-height 16 -radix decimal} /tb/UUT/x(5) {-height 16 -radix decimal} /tb/UUT/x(6) {-height 16 -radix decimal} /tb/UUT/x(7) {-height 16 -radix decimal} /tb/UUT/x(8) {-height 16 -radix decimal}} /tb/UUT/x
add wave -noupdate -radix decimal -childformat {{/tb/UUT/sums(0) -radix decimal -childformat {{/tb/UUT/sums(0)(0) -radix decimal} {/tb/UUT/sums(0)(1) -radix decimal} {/tb/UUT/sums(0)(2) -radix decimal}}} {/tb/UUT/sums(1) -radix decimal} {/tb/UUT/sums(2) -radix decimal} {/tb/UUT/sums(3) -radix decimal} {/tb/UUT/sums(4) -radix decimal -childformat {{/tb/UUT/sums(4)(0) -radix decimal} {/tb/UUT/sums(4)(1) -radix decimal} {/tb/UUT/sums(4)(2) -radix decimal}}} {/tb/UUT/sums(5) -radix decimal} {/tb/UUT/sums(6) -radix decimal} {/tb/UUT/sums(7) -radix decimal -childformat {{/tb/UUT/sums(7)(0) -radix decimal} {/tb/UUT/sums(7)(1) -radix decimal} {/tb/UUT/sums(7)(2) -radix decimal}}}} -subitemconfig {/tb/UUT/sums(0) {-height 16 -radix decimal -childformat {{/tb/UUT/sums(0)(0) -radix decimal} {/tb/UUT/sums(0)(1) -radix decimal} {/tb/UUT/sums(0)(2) -radix decimal}} -expand} /tb/UUT/sums(0)(0) {-height 16 -radix decimal} /tb/UUT/sums(0)(1) {-height 16 -radix decimal} /tb/UUT/sums(0)(2) {-height 16 -radix decimal} /tb/UUT/sums(1) {-height 16 -radix decimal} /tb/UUT/sums(2) {-height 16 -radix decimal} /tb/UUT/sums(3) {-height 16 -radix decimal} /tb/UUT/sums(4) {-height 16 -radix decimal -childformat {{/tb/UUT/sums(4)(0) -radix decimal} {/tb/UUT/sums(4)(1) -radix decimal} {/tb/UUT/sums(4)(2) -radix decimal}} -expand} /tb/UUT/sums(4)(0) {-height 16 -radix decimal} /tb/UUT/sums(4)(1) {-height 16 -radix decimal} /tb/UUT/sums(4)(2) {-height 16 -radix decimal} /tb/UUT/sums(5) {-height 16 -radix decimal} /tb/UUT/sums(6) {-height 16 -radix decimal} /tb/UUT/sums(7) {-height 16 -radix decimal -childformat {{/tb/UUT/sums(7)(0) -radix decimal} {/tb/UUT/sums(7)(1) -radix decimal} {/tb/UUT/sums(7)(2) -radix decimal}}} /tb/UUT/sums(7)(0) {-height 16 -radix decimal} /tb/UUT/sums(7)(1) {-height 16 -radix decimal} /tb/UUT/sums(7)(2) {-height 16 -radix decimal}} /tb/UUT/sums
add wave -noupdate -radix decimal -childformat {{/tb/UUT/mulres(0) -radix decimal -childformat {{/tb/UUT/mulres(0)(0) -radix decimal} {/tb/UUT/mulres(0)(1) -radix decimal} {/tb/UUT/mulres(0)(2) -radix decimal}}} {/tb/UUT/mulres(1) -radix decimal} {/tb/UUT/mulres(2) -radix decimal} {/tb/UUT/mulres(3) -radix decimal} {/tb/UUT/mulres(4) -radix decimal} {/tb/UUT/mulres(5) -radix decimal} {/tb/UUT/mulres(6) -radix decimal} {/tb/UUT/mulres(7) -radix decimal} {/tb/UUT/mulres(8) -radix decimal}} -expand -subitemconfig {/tb/UUT/mulres(0) {-height 16 -radix decimal -childformat {{/tb/UUT/mulres(0)(0) -radix decimal} {/tb/UUT/mulres(0)(1) -radix decimal} {/tb/UUT/mulres(0)(2) -radix decimal}}} /tb/UUT/mulres(0)(0) {-height 16 -radix decimal} /tb/UUT/mulres(0)(1) {-height 16 -radix decimal} /tb/UUT/mulres(0)(2) {-height 16 -radix decimal} /tb/UUT/mulres(1) {-height 16 -radix decimal} /tb/UUT/mulres(2) {-height 16 -radix decimal} /tb/UUT/mulres(3) {-height 16 -radix decimal} /tb/UUT/mulres(4) {-height 16 -radix decimal} /tb/UUT/mulres(5) {-height 16 -radix decimal} /tb/UUT/mulres(6) {-height 16 -radix decimal} /tb/UUT/mulres(7) {-height 16 -radix decimal} /tb/UUT/mulres(8) {-height 16 -radix decimal}} /tb/UUT/mulres
add wave -noupdate /tb/UUT/V
add wave -noupdate -radix decimal /tb/UUT/DOUT3k_s
add wave -noupdate -radix decimal /tb/UUT/sum_regs
add wave -noupdate -radix decimal /tb/UUT/mulres_first_layer
add wave -noupdate -radix decimal /tb/UUT/mulres_second_layer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1294000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {2886210 ps}
