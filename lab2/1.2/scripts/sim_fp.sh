#!/usr/bin/env sh

SIM_DIR='./sim'
TB_DIR='./cvfpu_lite/tb'

echo "[INFO] Compiling default design."
COMPONENTS_FILE=$SIM_DIR'/prj.txt'
SIM_CMD="vsim -t 10ps -voptargs=+acc work.tb_fpnew_top"

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

    cd $SIM_DIR
    $SIM_CMD
    rm -rf ./work
