# Comparative modeling by the automodel class
from modeller import *              # Load standard Modeller classes
from modeller.automodel import *    # Load the automodel class

log.verbose()    # request verbose output
env = environ()  # create a new MODELLER environment to build this model in
env.io.hetatm = True
data_dir = "C:\\Users\\AH-INFO\\practical_comparative\\data"

# Define the full path to the alignment file
env.io.atom_files_directory =[data_dir]
a = automodel(env,
              alnfile='query-1c8q.pir',
              knowns='1C8Q',
              sequence='AMY_PSEHA',
              assess_methods=(assess.DOPE,
                              #soap_protein_od.Scorer(),
                              assess.GA341))
             # code of the target
a.starting_model= 1                 # index of the first model
a.ending_model  = 10                # index of the last model
                                    # (determines how many models to calculate)
a.make() 

