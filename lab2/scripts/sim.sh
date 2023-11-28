#!/usr/bin/env sh

SIM_DIR='./sim'
TB_DIR='./tb'


if [ $# -gt 0 ] && [ $1 -lt 6 ] && [ $1 -gt 0 ] ; then
    echo "[INFO] Compiling $1 netlist design."
    COMPONENTS_FILE=$SIM_DIR"/components_net"$1
else
    echo "[INFO] Compiling default design."
    COMPONENTS_FILE=$SIM_DIR'/components_tb'
fi; 

echo "[INFO] Starting Compilation."
echo "[INFO] Moving into simulation directory"

if [ ! -d "$SIM_DIR" ]; then
    echo "[INFO] $SIM_DIR does not exist yet."
    echo "[INFO] Creating it."
    mkdir -p "$SIM_DIR"
else
    echo "[INFO] $SIM_DIR found."
fi

echo "[INFO] (SETMENTOR)"
hostname=$(hostname)
case $hostname in
    'yoga')
        INSTALL_DIR=/opt/intelFPGA/20.1/modelsim_ase/bin/
        ;;
    'MarcoPc'|'DESKTOP-R7HTGI3')
        INSTALL_DIR=/mnt/c/intelFPGA_lite/18.1/modelsim_ase/win32aloem
        ;;
    *)
        INSTALL_DIR=/eda/mentor/2020-21/RHELx86/QUESTA-CORE-PRIME_2020.4/questasim/linux_x86_64
        export LM_LICENSE_FILE=${LM_LICENSE_FILE}:1717@led-x3850-3.polito.it
        source /eda/mentor/2020-21/scripts/QUESTA-CORE-PRIME_2020.4_RHELx86.sh
        ;;
esac

export PATH=$INSTALL_DIR:$PATH

echo "[INFO] Creating work library"

# match testbenches modules
components=$(grep '.vhd$' $COMPONENTS_FILE)
if [ -n "$components" ]; then
    vcom  -work $SIM_DIR'/work' $components
    if [ $? -ne 0 ]; then
        echo "There are some compilation errors"
        exit 1
    fi
fi

# match post synthesis netlits
components=$(grep '.v$' $COMPONENTS_FILE)
if [ -n "$components" ]; then 
    vlog  -work $SIM_DIR'/work' $components
    if [ $? -ne 0 ]; then
        echo "There are some compilation errors"
        exit 1
    fi
fi

# match cvfpu design files
components=$(grep '.svh$' $COMPONENTS_FILE) 
if [ -n "$components" ]; then
    vlog  -work $SIM_DIR'/work' $components
    if [ $? -ne 0 ]; then
        echo "There are some compilation errors"
        exit 1
    fi
fi 

components=$(grep '.sv$' $COMPONENTS_FILE)
if [ -n "$components" ]; then
    vlog  -work $SIM_DIR'/work' $components
    if [ $? -ne 0 ]; then
        echo "There are some compilation errors"
        exit 1
    fi
fi

cd $SIM_DIR
    vsim -c -t 10ps -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fpnew_top -voptargs=+acc
