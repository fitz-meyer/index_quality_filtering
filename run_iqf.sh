#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=8:00:00
#SBATCH --qos=normal
#SBATCH --partition=amilan
#SBATCH --job-name=iqf_batch

module load miniforge # for conda
conda activate R_env

# full command
cmd="./index_quality_filtering.sh"
echo $cmd
eval $cmd