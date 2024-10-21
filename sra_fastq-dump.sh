#!/bin/bash
#PBS -l nodes=1:ppn=1,walltime=04:00:00

cd $PBS_O_WORKDIR

module load sratoolkit/2.8.2

## fastq-dump is a command from the sratoolkit to download sequence data
## --gzip zips the output
## --split-files is used for paired-end sequencing to split output into two files


### This data from: bioRxiv Wolf et al. Non-essential function of KRAB zinf finger gene clusters in retrotransposon suppression
# RNA-seq Chr13-cl WT B6 ES cells
fastq-dump  --split-files -O /projects/baker-lab/mahada/rnaseq/fastq SRR7254951

# -O redirect output to path 
