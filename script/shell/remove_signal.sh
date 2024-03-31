
#!/bin/bash
# Input and output files
input_file="/c/Users/AH-INFO/practical_comparative/data/alpha_amylase.fasta"       # Change this to your input FASTA file
output_file="/c/Users/AH-INFO/practical_comparative/data/target.fasta"     # Change this to your output FASTA file

# Read input FASTA file line by line
while IFS= read -r line
do
    # Check if the line is a header line
    if [[ $line =~ ^\> ]]; then
        header="$line"  # Save the header line
        echo "$header" >> "$output_file"  # Write header to output file
    else
        # Remove first 24 characters (amino acids) from sequence
        sequence="${line:24}"
        echo "$sequence" >> "$output_file"  # Write modified sequence to output file
    fi
done < "$input_file"

echo "Signal peptide removed from sequences. Result saved to $output_file"
