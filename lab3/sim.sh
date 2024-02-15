#!/usr/bin/env bash

SIM_DIR='./sim'
SRC_DIR='./src'
COMPONENTS_FILE='./components'
TESTBENCH_FILE='./testbenches/DLX_tb.vhd'

echo "[INFO] Starting Compilation."
echo "[INFO] Moving into simulation directory"

# rm -rf sim
if [ ! -d "$SIM_DIR" ]; then
    echo "[INFO] $SIM_DIR does not exist yet."
    echo "[INFO] Creating it."
    mkdir -p "$SIM_DIR"
    echo "[INFO] Copying sources from $SRC_DIR"
    # TODO add simulation specific files to components
    echo "$TESTBENCH_FILE" >> "$SIM_FILE_LIST"
    cp -r $SRC_DIR/* $SIM_DIR/
else
    echo "[INFO] $SIM_DIR found."
    cp -r --update $SRC_DIR/* $SIM_DIR/
fi

cd "$SIM_DIR"
echo "[INFO] (SETMENTOR)"
INSTALL_DIR=/opt/intelFPGA/20.1/modelsim_ase/bin/
# export LM_LICENSE_FILE=${LM_LICENSE_FILE}:1717@led-x3850-3.polito.it
# source /eda/mentor/2020-21/scripts/QUESTA-CORE-PRIME_2020.4_RHELx86.sh
export PATH=$INSTALL_DIR:$PATH

echo "[INFO] Creating work library"
# vdel -all > /dev/null 2>&1
# vlib work

while IFS= read -r line || [ -n "$line" ]; do
    # Ignore empty lines
    if [ -n "$line" ]; then
        # Get the file extension
        b=$(basename $line)
        extension="${b##*.}"

        # Issue a command based on the file extension
        case "$extension" in
            "sv" | "sh" | "v" )
                vlog -mixedsvvh -work './work' $line
                if [ $? != 0 ]; then 
                    exit 1  
                fi;
                ;;
            "vhd")
                vcom -mixedsvvh -work './work' $line
                if [ $? != 0 ]; then 
                    exit 1  
                fi;
                ;;
            *)
                echo "Ignoring: $line $extension"
                ;;
        esac
    fi
done < "$COMPONENTS_FILE"

# Simulation
if ps aux | grep -q [v]sim; then
    exit 1
else
    setsid vsim -t 10ps work.tb -voptargs=+acc
fi