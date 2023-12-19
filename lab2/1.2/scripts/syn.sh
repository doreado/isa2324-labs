#!/usr/bin/env sh

SRC_DIR='./cvfpu_lite/src'
SYN_DIR='./syn'
SYN_RES='./res/syn'
SYN_LIBRARYNAME='.synopsys_dc.setup'

GREEN="\e[32m"  # Green text color
RESET="\e[0m"   # Reset text color

CLK_PERIOD="$1"
#SCRIPT_NUMBER="$2"
SYN_TCL="./scripts/syn.tcl"

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
    set CLK_PERIOD $CLK_PERIOD
    source $SYN_TCL
EOF
