
#!/bin/bash

# Function to download FASTA file from UniProt
download_fasta() {
    local accession="$1"
    local url="https://rest.uniprot.org/uniprotkb/${accession}.fasta"
    local output_file="alpha_amylase.fasta"

    # Download the FASTA file
    curl -sS "$url" -o "$output_file"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "FASTA file downloaded successfully for accession $accession."
    else
        echo "Error: Failed to download FASTA file for accession $accession."
    fi
}

# Function to copy file to another repository
copy_to_repository() {
    local file="$1"
    local repository_path="/c/Users/AH-INFO/practical_comparative/data"  # path to the data repository

    # Check if the repository path exists
    if [ -d "$repository_path" ]; then
        # Copy the file to the repository
        mv "$file" "$repository_path"
        echo "File copied to repository."
    else
        echo "Error: Repository path '$repository_path' not found."
    fi
}

# Main function
main() {
    local accession="P29957"  # UniProt accession number of alpha-amylase
    local output_file="alpha_amylase.fasta"
    
    download_fasta "$accession"
    
    # Check if the download was successful before copying
    if [ -f "$output_file" ]; then
        copy_to_repository "$output_file"
    else
        echo "Error: Download was not successful. File not copied to repository."
    fi
}

# Run the main function
main
