#!/bin/bash
#SBATCH --tasks-per-node 1
#SBATCH --cpus-per-task 2
#SBATCH --tasks 10
#SBATCH --time 1-12:00:00
#SBATCH --job-name ray_worker
#SBATCH --partition exacloud
#SBATCH --mem-per-cpu=80000
#SBATCH --distribution=cyclic

# That mem-per-cpu is setting 40GB per core

srun --distribution=cyclic worker.slurm
