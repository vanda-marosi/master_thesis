#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=fastQC
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1-35
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc

PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/wheat_project_table_trimmomatic_single.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


INDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/02_Trimmomatic_single
OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/03_FastQC_trimmed_single
IN="$INDIR/${array[0]}_trimmed.fastq.gz"


first=$(printf "%s/%s_fastqc.summary.txt" "$OUTDIR" "${array[0]}")


if [ -n "${array[0]}" ] && [ -e "$IN" ] && ! [ -e "$first" ] && ! [ -s "$first"  ]
then

        date
        echo $IN

        /home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/fastqc --threads 4 --outdir $OUTDIR -f fastq $IN

        for R1 in $IN
        do
        r1=$(basename $R1)
        r1=${r1/.fastq.gz}
                echo $r1
                unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/summary.txt > $OUTDIR/${r1}_fastqc.summary.txt
                unzip -p $OUTDIR/${r1}_fastqc.zip ${r1}_fastqc/fastqc_data.txt > $OUTDIR/${r1}_fastqc.data.txt
        done
        date
fi


# sbatch -N 1 ~/scripts/triticum/run_03_triticum_single_fastqc.slurm.sh

