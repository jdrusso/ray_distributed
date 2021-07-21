#!/bin/bash
#SBATCH --tasks-per-node 1
#SBATCH --cpus-per-task 2
#SBATCH --tasks 1
##SBATCH --nodes 1
#SBATCH --time 1-12:00:00
#SBATCH --job-name ray_worker
#SBATCH --partition exacloud
#SBATCH --mem-per-cpu=80000
#SBATCH --distribution=cyclic

# THat mem-per-cpu is setting 40GB per core

source /home/groups/ZuckermanLab/russojd/miniconda/etc/profile.d/conda.sh
conda activate jupyter

export  CUDA_VISIBLE_DEVICES=''
export  REDIS_PASSWORD=$(cat password.dat)

# Just in case
ray stop

ray start --block --object-store-memory=$((80 * 1024 * 1024 * 1024)) --memory=$((80 * 1024 * 1024 * 1024)) --num-cpus=$SLURM_CPUS_PER_TASK --address='172.20.15.67:6379' --redis-password=$REDIS_PASSWORD
