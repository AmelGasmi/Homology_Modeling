import os
from Bio import SeqIO
from Bio.Blast import NCBIWWW, NCBIXML

# Read the target sequence from the file
target_sequence_file = r"C:\Users\AH-INFO\practiacl_copmarative\data\target.fasta"   # Update with your file name
try:
    with open(target_sequence_file, "r") as f:
        target_record = SeqIO.read(f, "fasta")
    target_sequence = str(target_record.seq)
except FileNotFoundError:
    print("Error: Target sequence file not found.")
    exit(1)
except Exception as e:
    print(f"Error: An unexpected error occurred: {e}")
    exit(1)

# Perform BLAST search against NCBI non-redundant protein database
print("Performing BLAST search...")
try:
    result_handle = NCBIWWW.qblast("blastp", "pdb", target_sequence, hitlist_size=25)  # Limit to 25 hits
except Exception as e:
    print(f"Error: An error occurred while performing BLAST search: {e}")
    exit(1)

# Create a directory for storing blast hits if it doesn't exist
output_dir = "C:\Users\AH-INFO\practiacl_copmarative\data"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Parse the BLAST results and write hits to a log file
print("Parsing BLAST results...")
try:
    blast_records = NCBIXML.parse(result_handle)
    hits = []
    with open(os.path.join(output_dir, "blast_hits.log"), "w") as log_file:
        for blast_record in blast_records:
            for alignment in blast_record.alignments:
                for hsp in alignment.hsps:
                    description = alignment.hit_def.split('>')[1].split(' ')[0] if '>' in alignment.hit_def else "N/A"
                    scientific_name = alignment.hit_def.split(' ')[1] if len(alignment.hit_def.split(' ')) >= 2 else "N/A"
                    max_score = hsp.score
                    total_score = hsp.bits
                    query_cover = (hsp.align_length / len(target_sequence)) * 100
                    e_value = hsp.expect
                    per_ident = (hsp.identities / hsp.align_length) * 100
                    acc_len = alignment.length
                    accession = alignment.accession
                    hit_info = f"Description: {description}, Scientific Name: {scientific_name}, Max Score: {max_score}, Total Score: {total_score}, Query Cover: {query_cover:.2f}%, E-value: {e_value}, Per. Ident: {per_ident:.2f}%, Acc. Len: {acc_len}, Accession: {accession}\n"
                    hits.append(hit_info)
                    log_file.write(hit_info)
                    if len(hits) >= 25:
                        break
            if len(hits) >= 25:
                break
except Exception as e:
    print(f"Error: An error occurred while parsing BLAST results: {e}")
    exit(1)

# Print the hits
print("Homologous protein hits:")
for hit in hits:
    print(hit)