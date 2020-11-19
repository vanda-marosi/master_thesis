#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=fastQC
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1-240
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc


TASKID=$SGE_TASK_ID
PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/barley_project_table.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


INDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum # path to raw data
OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/01_FastQC_raw_single
IN="$INDIR/${array[0]}.fastq.gz" # here the extension can be changed to ".fastq.gz"


first=$(printf "%s/%s_fastqc.summary.txt" "$OUTDIR" "${array[0]}")


if [ -n "${array[0]}" ] && [ -e "$IN" ] && ! [ -e "$first" ] && ! [ -s "$first"  ]
then

	date
	echo $IN

	/home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/fastqc --threads 4 --outdir $OUTDIR -f fastq $IN

	for R1 in $IN
	do
    	r1=$(basename $R1)
        r1=${r1/.fastq.gz} # here the extension can be changed to ".fastq.gz"
		echo $r1
		unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/summary.txt > $OUTDIR/${r1}_fastqc.summary.txt
        	unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/fastqc_data.txt > $OUTDIR/${r1}_fastqc.data.txt
	done
	date
else
	echo if statement failed. array start ${array[*]} finish $IN $first
fi


# sbatch -N 1 ~/scripts/hordeum/run_01_hordeum_single.fastqc.slurm.sh
