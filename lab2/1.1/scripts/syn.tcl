#!/usr/bin/env tclsh

# colors
proc color {foreground text} {
    return [exec tput setaf $foreground]$text[exec tput sgr0]
}

proc print_info {message} {
	puts [ color 2 "\[INFO\] $message" ]
}

proc print_error {message} {
	puts [ color 1 "\[ERROR\] $message" ]
}

puts "\n"
print_info "Starting Synthesis."

# clock
print_info "Clock period: $CLK_PERIOD ns"
set target_clk_ns $CLK_PERIOD

# constants
set design_entity "fpnew_top"
set design_arch "beh"
set fcomp_name "./syn/components"
set fcomp [open $fcomp_name r]
set fanalyze [read $fcomp]

# components analysis
print_info "Starting Analysis."
set errors 0
foreach component [split [string trim "$fanalyze" "\n"] "\n"] {
	if {[analyze "$component" -library WORK -format sverilog] == 0} {
		set errors 1
	}
}
if { $errors } {
	print_error "Errors during Analysis"
	exit
}
print_info "Done: Analysis"

# elaboration and synthesis settings
print_info "Starting Elaboration."
elaborate "${design_entity}" -library WORK
print_info "Done: Elaboration"

# constraints 
create_clock -name "CLK" -period $target_clk_ns clk_i
set_dont_touch_network CLK

set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

set_input_delay 0.5 -max -clock CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock CLK [all_outputs]

ungroup -all -flatten

# force pparch implementation for multiplication 
if { $script_num == 4 } {
    set_implementation DW02_mult/csa [find cell *mul*]
} elseif { $script_num == 5 } {
    set_implementation DW02_mult/pparch [find cell *mul*]
}

# compile design 
if { $script_num == 3 } {
    print_info "Starting Compile Ultra."
    compile_ultra
} else {
    print_info "Starting Compile"
    compile
}
print_info "Done: Compile"

if { $script_num != 1 && $script_num != 3 } {
    # retime registers
    optimize_registers 
    print_info "Done: Retime registers"
}

change_names -hierarchy -rules verilog

# generate delay file
exec mkdir -p sdf
write_sdf "./sdf/${script_num}_${design_entity}_postsyn.sdf"
print_info "Done: sdf"

# generate netlist
print_info "Generating Netlist."
exec mkdir -p netlists
write -format verilog -hierarchy -output "./netlists/${script_num}_${design_entity}_${target_clk_ns}ns_postsyn.v"
print_info "Done: Netlist"

# generate reports
print_info "Generating Reports."
exec mkdir -p reports
report_timing > "./reports/${script_num}_${design_entity}_${target_clk_ns}ns_timing.rpt"
report_area   > "./reports/${script_num}_${design_entity}_${target_clk_ns}ns_area.rpt"
report_power > "./reports/${script_num}_${design_entity}_${target_clk_ns}ns_power.rpt"
report_resources   > "./reports/${script_num}_${design_entity}_resources.rpt"

print_info "Done: Reports"

# final cleanup
print_info "Done: Synthesis. Cleaning up..."
exec rm -rf ./syn/work
exit
