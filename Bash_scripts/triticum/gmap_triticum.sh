#!/bin/bash
#SBATCH -p pgsb
#SBATCH --cpus-per-task 4
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=GMAP_triticum
#SBATCH --output=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.out
#SBATCH --error=/home/pgsb/vanda.marosi/slurm/logs/%x.%j.%a.err

source ~/.bash_profile
source ~/.bashrc


TRI=/nfs/pgsb/data/SFB924/Kuester.ArathProteome/RNAseq/out/9_denovo_transcriptome/Trinity.fasta
# is this indir? = resulted fastas
OUT=/nfs/pgsb/data/SFB924/Kuester.ArathProteome/RNAseq/out/9_denovo_transcriptome/gmap/Trinity.gff
# my outdir: /nfs/pgsb/projects/comparative_triticeae/phenotype/flower_developmentgenes/gmap_twotimesfiltered

gmap -d Ath_TAIR10 $TRI -t 4 -f gff3_gene > $OUT


# --nosplicing --> aligning genomic sequences onto a genome; RNAseq reads on transcriptome ...
                                   
