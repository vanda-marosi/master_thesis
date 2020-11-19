#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 6
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=trimmomatic
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --array=1-193
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc


PROJECT_TABLE=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/barley_project_table_trimmomatic_paired.txt # see example_samples.txt

source /nfs/pgsb/projects/Olsen_DEK1/code/arrayHelpers.sh

tablerow2array $PROJECT_TABLE $SLURM_ARRAY_TASK_ID


INPATH=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/

R1=$(printf "${INPATH}/%s_1.fastq.gz" "${array[0]}") # watch out for naming, some are eg. _R1.fastq.gz
R2=$(printf "${INPATH}/%s_2.fastq.gz" "${array[0]}")
OUTDIR=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/hordeum/02_Trimmomatic_paired

LOG=$(printf "./%s.trimmomatic.log" "${array[0]}") # if you want to change naming (instead of eg. SRA1), you can use "${array[1]}" (it's the second column, so would be leaf_rep1)
DONE=$(printf "${OUTDIR}/%s.trimmomatic.DONE" "${array[0]}")
STARTED=$(printf "${OUTDIR}/%s.trimmomatic.STARTED" "${array[0]}")


r1=$(basename $R1)
rr1=$(basename $R1)
r1=$OUTDIR/${r1/.fastq.gz}
rr1=./${rr1/.fastq.gz}

r2=$(basename $R2)
rr2=$(basename $R2)
r2=$OUTDIR/${r2/.fastq.gz}
rr2=./${rr2/.fastq.gz}


IN="$INPATH/${array[0]}_%s.fastq.gz"
raw=( $(printf $IN "1")  $(printf $IN "2")  )


cd $OUTDIR

date > $STARTED

java -jar  /nfs/pgsb/commons/apps/trimmomatic/Trimmomatic-0.35/trimmomatic-0.35.jar PE -threads 6 -validatePairs $R1 $R2 ${rr1}_paired.fastq.gz ${rr1}_unpaired.fastq.gz ${rr2}_paired.fastq.gz ${rr2}_unpaired.fastq.gz ILLUMINACLIP:/nfs/pgsb/data/grill-rcar/02_Trimmomatic/adapters/adapters_et_al.nr.fasta:2:30:10:8:true LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:60 > $LOG 2>&1

date > $DONE


# sbatch -N 1 ~/scripts/hordeum/run_02_hordeum_paired_trimmomatic.slurm.sh

# my samples.txt has 15 entries, if you have eg. 50 samples, it would be --array=1-50

