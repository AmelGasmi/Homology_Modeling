#!/bin/bash

# Input directory containing separated sequences
input_directory="/c/Users/AH-INFO/practical_comparative/data/separated_sequences"
# Output directory for PIR files
output_directory="/c/Users/AH-INFO/practical_comparative/data/pir_files"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Read sequences from the files
seq_amy=$(< "$input_directory/sequence_AMY_PSEHA.txt")
seq_a=$(< "$input_directory/sequence_A.txt")
# Concatenate "*" directly to the end of the sequences
seq_amy="${seq_amy// /}"
seq_a="${seq_a// /}"
seq_amy="$seq_amy*"
seq_a="$seq_a*"

# Write the PIR files
printf "%s\n" ">P1;AMY_PSEHA" "sequence:AMY_PSEHA:: :: ::: 0.00: 0.00" "$seq_amy" > "$output_directory/sequence_AMY_PSEHA.pir"
printf "%s\n" ">P1;1C8Q" "structureX:1c8q:2:A:+495:A:::-1.00:-1.00" "$seq_a" > "$output_directory/sequence_A.pir"

# Append the content of both PIR files into one
cat "$output_directory/sequence_AMY_PSEHA.pir" "$output_directory/sequence_A.pir" > "$output_directory/combined_sequences.pir"

echo "PIR files generated and combined in $output_directory/combined_sequences.pir"
echo "PIR files generated in $output_directory"


