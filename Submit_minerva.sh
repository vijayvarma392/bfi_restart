#!/bin/bash -
#SBATCH -o .bfi_restart/%x.log    # Output file name. x=SLURM_JOB_NAME
#SBATCH -e .bfi_restart/%x.log    # Error file name
#SBATCH -n 1                      # Number of cores
#SBATCH --ntasks-per-node 1       # number of MPI ranks per node
#SBATCH -N 1                      # number of nodes
#SBATCH -p nr                     # Queue name
#SBATCH -t 1:0:00                 # Run time
#SBATCH --no-requeue
#SBATCH --begin now+1minute        # Stay in pending for 2 days

umask 0022

#NOTE: Submit this from $HOME, with format:
# sbatch -J <ProjectNumberOrName> --export=EMAIL="<YOUREMAIL>" .bfi_restart/Submit.sh
# Example:
# sbatch -J "q8_7d" --export=EMAIL="vijay.varma392@gmail.com" .bfi_restart/Submit.sh

# BFI project. Edit Job name above if you want to edit this.
ProjectNumberOrName=$SLURM_JOB_NAME

.bfi_restart/Restart.sh $ProjectNumberOrName $SLURM_JOB_NAME $SLURM_JOB_ID $EMAIL

# Resumbmit the job to slurm
sbatch -J $ProjectNumberOrName --export=EMAIL=$EMAIL .bfi_restart/Submit.sh 
