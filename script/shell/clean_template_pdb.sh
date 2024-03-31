#!/bin/bash
# Define input and output file nam
input_file="/c/Users/AH-INFO/practical_comparative/data/1C8Q.pdb"
output_file="/c/Users/AH-INFO/practical_comparative/data/1c8q.pdb"

# Copy the original file to a new file
cp "$input_file" "$output_file"

# Remove water molecules (HOH) from the copied file
grep -E "^ATOM|^TER"  "$output_file" > "${output_file}.tmp" && mv "${output_file}.tmp" "$output_file"

# Check if the operation was successful
if [ $? -eq 0 ]; then
    echo "Water molecules removed from $input_file. Result saved to $output_file"
else
    echo "Error: Failed to remove water molecules."
fi
