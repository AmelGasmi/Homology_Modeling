#!/bin/bash

# Input alignment file
alignment_file="/c/Users/AH-INFO//practical_comparative/data/emboss_needle.txt"

# Output directory for sequences
output_directory="/c/Users/AH-INFO//practical_comparative/data/separated_sequences"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Initialize variables to store sequences
seq_amy=""
seq_a=""

# Read the alignment file line by line
while IFS= read -r line; do
    # Extract sequence name and content
    seq_name=$(echo "$line" | awk '{print $1}')
    seq_content=$(echo "$line" | sed 's/^[^ ]* *//; s/[0-9]//g')  # Remove sequence name and numbers
    
    # Determine the sequence content based on the sequence name
    if [ "$seq_name" == "AMY_PSEHA" ]; then
      
        echo "$seq_content" >> "$output_directory/sequence_AMY_PSEHA.txt"
    elif [ "$seq_name" == "A" ]; then
        # Append sequence content 
        echo "$seq_content"  >> "$output_directory/sequence_A.txt"
    fi
done < "$alignment_file"


echo "Sequences separated and saved in $output_directory"
