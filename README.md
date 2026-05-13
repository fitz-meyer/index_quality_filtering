index_quality_filtering.sh calls index_quality_filtering.R <br>
run_iqf.sh runs the IQF pipeline on Alpine via sbatch

before running: <br>
- this script, index_quality_filtering.R, and all fastq files must be in your working directory <br>
- all R packages (tidyverse, Biostrings, ShortRead) must be installed in R conda environment (R_env) <br>
- R_env must be activated <br>
- BBmap must be installed via conda (bbmap_env) <br>
