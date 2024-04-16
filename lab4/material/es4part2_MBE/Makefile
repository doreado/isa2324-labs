FILES := $(shell cat compile.txt)
compile:
	vlog -sv ./tb/top.sv
sim:
	vsim -c top -do "run 1000ns; quit"

run: compile sim

