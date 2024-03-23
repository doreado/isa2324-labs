# Output file
output_file="samples.txt"
output_file_c="result_c.txt"

# Remove the file if it exists
rm -f "$output_file"

# Run the code ten times
for ((i = 0; i < 12; i++)); do
    # Generate random float values for ff16_a and ff16_b
    fa=$(awk -v min=-100 -v max=100 -v seed=$RANDOM 'BEGIN{srand(seed); print min+rand()*(max-min)}')
    fb=$(awk -v min=-100 -v max=100 -v seed=$RANDOM 'BEGIN{srand(seed); print min+rand()*(max-min)}')

    # Run the C++ code with the generated values
    #./fp16_num "$fa" "$fb" >> "$output_file"
	output=$(./fp16_num "$fa" "$fb" | awk '/ff16_a/ {gsub("-","");printf "%s\n", $4} /ff16_b/ {gsub("-","");printf "%s\n",$4}'| tr -d '()')
	output_c=$(./fp16_num "$fa" "$fb" | awk '/ff16_c/ {gsub("-","");printf "%s\n",$4}' | tr -d '()');

    echo -n "$output" >> "$output_file"
	echo  >> "$output_file"
    echo -n "$output_c" >> "$output_file_c"
    echo >> "$output_file_c"      
    echo "Run $((i+1)) completed"
done

echo "All runs completed. Output saved to $output_file"
