#!/usr/bin/env sh

SIM_DIR='./sim'
TB_DIR='./tb'
COMPONENTS_FILE=$SIM_DIR'/components'

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
    'MarcoPc')
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
# vdel -all > /dev/null 2>&1
# vlib -dirpath $SIM_DIR'/work' work

vcom  -work $SIM_DIR'/work' $(grep .vhd $COMPONENTS_FILE)
if [ $? -ne 0 ]; then
    echo "There are some compilation errors"
    exit 1
fi

vlog  -work $SIM_DIR'/work' $(grep '.v$' $COMPONENTS_FILE)
if [ $? -ne 0 ]; then
    echo "There are some compilation errors"
    exit 1
fi

# Start simulation
if ps aux | grep -q [v]sim; then
    exit 1
else
    cd $SIM_DIR
    vsim -t 10ps work.tb -voptargs=+acc
fi
