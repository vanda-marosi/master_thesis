#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 2
#SBATCH --mem-per-cpu=5G
#SBATCH --job-name=Trimmomatic
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1-35
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc

PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/wheat_project_table_trimmomatic_single.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


INPATH=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/
OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/02_Trimmomatic_single
R="$INPATH/${array[0]}.fastq.gz"

LOG=$(printf "./%s.trimmomatic.log" "${array[0]}")
DONE=$(printf "${OUTDIR}/%s.trimmomatic.DONE" "${array[0]}")
STARTED=$(printf "${OUTDIR}/%s.trimmomatic.STARTED" "${array[0]}")


r=$(basename $R)
rr=$(basename $R)
r=$OUTDIR/${r/.fastq.gz}
rr=./${rr/.fastq.gz}

IN="$INPATH/${array[0]}.fastq.gz"



        cd $OUTDIR
        date > $STARTED
        java -jar /nfs/pgsb/commons/apps/trimmomatic/Trimmomatic-0.35/trimmomatic-0.35.jar SE -threads 4 $R ${rr}_trimmed.fastq.gz ILLUMINACLIP:/nfs/pgsb/data/grill-rcar/02_Trimmomatic/adapters/adapters_et_al.nr.fasta:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:40 > $LOG 2>&1

        date > $DONE



# sbatch -N 1 ~/scripts/triticum/run_02_triticum_single_trimmomatic.slurm.sh

# HEADCROP:12
