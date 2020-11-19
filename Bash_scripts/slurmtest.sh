#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=fastQC
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1-5
#SBATCH --ntasks=1


echo hello
echo is it me youre looking for.
echo i can see it in your eyes
echo i can see it in your sole...
