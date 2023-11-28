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
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
set_max_delay $target_clk_ns -from [all_inputs] -to [all_outputs]

ungroup -all -flatten

# force pparch implementation for multiplication 
set_implementation DW02_mult/csa [find cell *mul*]

# compile design 
print_info "Starting Compile Ultra."
compile
print_info "Done: Compile"

# retime registers
optimize_registers 
print_info "Done: Retime registers"

# generate netlist
print_info "Generating Netlist."
exec mkdir -p netlists
write -format verilog -hierarchy -output "./netlists/${script_num}_${design_entity}_${target_clk_ns}ns_postsyn.v"
print_info "Done: Netlist"

# generate Synopsys Design Constraints
exec mkdir -p sdc
write_sdc "./sdc/${script_num}_${design_entity}_${target_clk_ns}ns_postsyn.sdc"
print_info "Done: sdc"

# generate reports
print_info "Generating Reports."
exec mkdir -p reports
report_timing > "./reports/${script_num}_${design_entity}_${target_clk_ns}ns_timing.rpt"
report_area   > "./reports/${script_num}_${design_entity}_${target_clk_ns}ns_area.rpt"
# report_power  > "./reports/${design_entity}_${target_clk_ns}ns_power.rpt"
print_info "Done: Reports"

# final cleanup
print_info "Done: Synthesis. Cleaning up..."
exec rm -rf ./syn/work
exit
