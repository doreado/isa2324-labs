#!/usr/bin/env sh

SIM_DIR='./sim'
TB_DIR='./tb'


if [ $# -gt 0 ] && [ $1 -lt 6 ] && [ $1 -gt 0 ] ; then
    echo "[INFO] Compiling $1 netlist design."
    COMPONENTS_FILE=$SIM_DIR"/components_net"$1

    case $1 in 
    1)
        CLK="2.04"
        tco="0.204"
        ;;
    2)
        CLK="2.04"
        tco="0.204"
        ;;
    3)
        CLK="2.49"
        tco="0.249"
        ;;
    4)
        CLK="2.18"
        tco="0.218"
        ;;
    5)
        CLK="2.05"
        tco="0.205"
        ;;
    esac

    sed -i "s/\(.*fpnew_top_\).*\(ns_postsyn.v\)/\1$CLK\2/" $COMPONENTS_FILE
    sed -i "s/\(^.*constant Ts : time := \).*$/\1"$CLK" ns;/" cvfpu_lite/tb/clk_gen.vhd
    sed -i "s/\(^.*constant tco : time := \).*$/\1"$tco" ns;/" cvfpu_lite/tb/data_gen16.vhd

    SIM_CMD="vsim  \
                -t 10ps -c \
                -voptargs=+acc \
                -L /eda/dk/nangate45/verilog/qsim2020.4 \
                -sdftyp /tb_fpnew_top/UUT=../sdf/"$1"_fpnew_top_postsyn.sdf \
                work.tb_fpnew_top"
else
    echo "[INFO] Compiling default design."
    COMPONENTS_FILE=$SIM_DIR'/components_tb'
    SIM_CMD="vsim -t 10ps -voptargs=+acc work.tb_mod_dadda"
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
mkdir $SIM_DIR"/work"

# Read each non-empty line from the file
while IFS= read -r line || [ -n "$line" ]; do
    # Ignore empty lines
    if [ -n "$line" ]; then
        # Get the file extension
        extension="${line##*.}"

        # Issue a command based on the file extension
        case "$extension" in
            "sv" | "sh" | "v" )
                if ! vlog  -work $SIM_DIR'/work' "$line"; then
                    exit 1
                fi;
                ;;
            "vhd")
                if ! vcom  -work $SIM_DIR'/work' "$line"; then
                    exit 1
                fi;
                ;;
            *)
                echo "Ignoring: $line"
                ;;
        esac
    fi
done < "$COMPONENTS_FILE"

if ! pgrep -l vsimk 2>&1; then
    cd $SIM_DIR
    $SIM_CMD
    rm -rf ./work
fi;
