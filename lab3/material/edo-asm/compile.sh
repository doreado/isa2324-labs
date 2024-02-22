make clean
make all

./extract_code.sh main.hex main.txt main.asm
./extract_data.sh data.hex data.txt

cat main.txt | sed s/.*:// | sed /^[[:space:]]*$/d > main.bin

kitten transfer main.bin /home/doreado/repos/isa-labs/lab3/src/memories/ro/hex.txt
