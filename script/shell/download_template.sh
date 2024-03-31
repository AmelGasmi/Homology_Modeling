#!/bin/bash

# Define the PDB ID
pdb_id="1C8Q"

# Define the URL to download the PDB file
pdb_url="https://files.rcsb.org/download/${pdb_id}.pdb"
# Define the output file name
output_file="${pdb_id}.pdb"

# Download the PDB file
curl -o "$output_file" "$pdb_url"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "PDB file downloaded successfully."

    # Define the directory of the data repository
    data_repository="/c/Users/AH-INFO/practical_comparative/data"

    # Copy the PDB file to the data repository
    mv "$output_file" "$data_repository"
    
    # Check if the copy was successful
    if [ $? -eq 0 ]; then
        echo "PDB file copied to data repository."
    else
        echo "Error: Failed to copy PDB file to data repository."
    fi
else
    echo "Error: Failed to download PDB file."
fi

