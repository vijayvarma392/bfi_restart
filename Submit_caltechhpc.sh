#!/bin/bash -
#SBATCH -o .bfi_restart/%x.log    # Output file name. x=SLURM_JOB_NAME
#SBATCH -e .bfi_restart/%x.log    # Error file name
#SBATCH -n 1                      # Number of cores
#SBATCH --ntasks-per-node 1       # number of MPI ranks per node
#SBATCH -N 1                      # number of nodes
#SBATCH -p any                    # Queue name
#SBATCH -A sxs                    # Account name
#SBATCH -t 1:0:00                 # Run time
#SBATCH --no-requeue
#SBATCH --begin now+2days        # Stay in pending for 2 days

umask 0022

# See README.md for usage.

# BFI project. Edit Job name in command line args if you want to edit this.
ProjectNumberOrName=$SLURM_JOB_NAME

Machine="CaltechHPC"

.bfi_restart/Restart.sh $ProjectNumberOrName $SLURM_JOB_NAME $SLURM_JOB_ID $EMAIL $Machine

# Resumbmit the job to slurm
sbatch -J $ProjectNumberOrName --export=ALL,EMAIL=$EMAIL .bfi_restart/Submit.sh
