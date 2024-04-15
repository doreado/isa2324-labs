all: remote

remote:
	rsync -avh . -e 'ssh -p 10038' isa:~/tmp
	ssh -CX isa "source /eda/scripts/init_questa_core_prime && cd ~/tmp/tb && make --file ../Makefile run && rm -rf work/ "

compile:
	vlog -sv ./tb/top.sv
sim:
	vsim -c top -do "run 1000ns; quit"

run: compile sim

