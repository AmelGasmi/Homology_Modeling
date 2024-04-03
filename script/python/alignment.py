from modeller import *

# Define the directory containing the template and target sequence files
data_dir = "C:\\Users\\AH-INFO\\practical_comparative\\data"

# Initialize MODELLER environment
env = environ()

# Read the template (model) fileq
template_file = data_dir + "\\1c8q.pdb"
mdl = model(env, file=template_file, model_segment=('FIRST:A','LAST:A'))

# Read the target sequence file
target_sequence_file = data_dir + "\\target.ali"
aln = alignment(env)
aln.append(file=target_sequence_file, align_codes='AMY_PSEHA')

# Perform sequence alignment
aln.append_model(mdl, align_codes='1C8Q', atom_files='1c8q.pdb')
aln.align2d()

# Write alignments
output_file_pir = data_dir + "\\query-1c8q.ali"
output_file_pap = data_dir + "\\query-1c8q.pap"
aln.write(file=output_file_pir, alignment_format='PIR')
aln.write(file=output_file_pap, alignment_format='PAP')
