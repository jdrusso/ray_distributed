#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=16G
#SBATCH --time 14-00:00:00
#SBATCH --job-name jupyter-notebook
#SBATCH --partition gpu
#SBATCH --output jupyter-notebook-%J.log

source /home/groups/ZuckermanLab/russojd/miniconda/etc/profile.d/conda.sh
conda activate jupyter

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="exahead1"
port=8889

# print tunneling instructions jupyter-log
echo -e "
Command to create ssh tunnel:

ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}.ohsu.edu

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
** MUST BE ON INTERNAL NETWORK **
"

export  CUDA_VISIBLE_DEVICES=''
ray start --head --num-cpus=1 --redis-port=6379

# Run Jupyter
jupyter lab --no-browser --port=${port} --ip=${node}
