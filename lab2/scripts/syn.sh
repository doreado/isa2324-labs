#!/usr/bin/env sh

SRC_DIR='./cvfpu_lite/src'
SYN_DIR='./syn'
SYN_RES='./res/syn'
SYN_LIBRARYNAME='.synopsys_dc.setup'
CLK_PERIOD_DEF=1

GREEN="\e[32m"  # Green text color
RESET="\e[0m"   # Reset text color

if [ $# -lt 2 ] || [ $2 -gt 5 ] || [ $2 -lt 1 ] ; then
    echo -e "${RED}usage: ./scripts/syn.sh CLK SCRIPT_NUMBER"
    echo -e "${RED}Available SCRIPT_NUMBER:\n1\t\n2\n3\n4\n5"
    exit 1
fi; 

CLK_PERIOD="$1"
SCRIPT_NUMBER="$2"
SYN_TCL="./scripts/syn_${SCRIPT_NUMBER}.tcl"

echo -e "${GREEN}[INFO] Synthesis Setup...${RESET}"
if [ ! -d "$SYN_DIR" ]; then
    echo -e "${GREEN}[INFO] Folder $SYN_DIR does not exist yet, creating it now.${RESET}"
    mkdir -p "$SYN_DIR"
fi

mkdir -p "$SYN_DIR/work"

echo -e "${GREEN}[INFO] Setting up Design Vision${RESET}"
source /eda/scripts/init_design_vision

echo -e "${GREEN}[INFO] Setup done, launching Design Vision...${RESET}"
dc_shell-t -no_log -no_gui << EOF
    source $SYN_LIBRARYNAME
    set script_num $SCRIPT_NUMBER
    set CLK_PERIOD $CLK_PERIOD
    source $SYN_TCL
EOF
