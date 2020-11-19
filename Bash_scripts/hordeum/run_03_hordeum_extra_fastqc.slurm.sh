#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=FastQC
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc


PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/extra_1missingfile_paired.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


INDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/02_Trimmomatic_paired
OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/03_FastQC_trimmed_paired
IN="$INDIR/${array[0]}_%s_paired.fastq.gz" # only analysing paired output
raw=( $(printf $IN "1")  $(printf $IN "2")  )



date
echo ${raw[*]}

/home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/fastqc --threads 2 --outdir $OUTDIR -f fastq ${raw[*]}

for R1 in "${raw[@]}"
do
	r1=$(basename $R1)
	r1=${r1/.fastq.gz}
        echo $r1
        unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/summary.txt > $OUTDIR/${r1}_fastqc.summary.txt
        unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/fastqc_data.txt > $OUTDIR/${r1}_fastqc.data.txt
done
date



# sbatch -N 1 ~/scripts/hordeum/run_03_hordeum_extra_fastqc.slurm.sh


