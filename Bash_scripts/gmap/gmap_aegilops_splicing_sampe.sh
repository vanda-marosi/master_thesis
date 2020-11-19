#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 4
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=gmap
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err
#SBATCH --ntasks=1

source ~/.bash_profile
source ~/.bashrc


IN=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refgenes/gmap/aegilops/aegilops_splicing.fasta # only .fasta in splicing category
OUT=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refgenes/gmap/aegilops/aegilops_splicing.sampe

/home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/gmap -D /nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/indexes/gmap -d aegilops $IN -t 4 -f sampe > $OUT


# --nosplicing --> aligning genomic sequences onto a genome; RNAseq reads on transcriptome ...
                   
# to run: sbatch -N 1 ~/scripts/gmap/gmap_aegilops_splicing_sampe.sh
                
