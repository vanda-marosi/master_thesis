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


IN=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refgenes/gmap/hordeum/barley_splicing.fasta # concatenated fasta from genomic wheat seqs that I want to map
OUT=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refgenes/gmap/hordeum/barley_splicing_est.gff

/home/pgsb/vanda.marosi/anaconda3/envs/seqtools/bin/gmapl -D /nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/indexes/gmap -d hordeum $IN -t 4 -f gff3_match_est > $OUT


# --nosplicing --> aligning genomic sequences onto a genome; RNAseq reads on transcriptome ...
                   
# to run: sbatch -N 1 ~/scripts/gmap/gmap_barley_splicing_est_gff.sh
                
