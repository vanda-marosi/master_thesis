#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 6
#SBATCH --mem-per-cpu=60G
#SBATCH --job-name=Kallisto
#SBATCH --output=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/04_Kallisto_single/logs_err/%x.%j.%a.out
#SBATCH --error=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/04_Kallisto_single/logs_err/%x.%j.%a.err
#SBATCH --array=1-47
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc

PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/barley_project_table_trimmomatic_single.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


CMD=/home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/kallisto # version: kallisto 0.46.2

OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/04_Kallisto_single

INPATH=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/02_Trimmomatic_single

INDEX=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/indexes/kallisto/hordeum_transcript.idx

R1=$(printf "${INPATH}/%s_trimmed.fastq.gz" "${array[0]}")

name=${array[0]}

mkdir $OUTDIR/$name

 
$CMD quant --index $INDEX --output $OUTDIR/$name --single -l 100 -s 10 --threads=6 -b 100 --bias --seed 42 $R1 # TruSeq RNA Library Prep Kit v2 without strand information


# sbatch -N 1 ~/scripts/hordeum/run_04_hordeum_kallisto_single.sh
