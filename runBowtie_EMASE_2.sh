#!/bin/bash

#PBS -N RNAseq_EMASE
#PBS -l nodes=1:ppn=8,walltime=8:00:00
#PBS -m e
#PBS -j oe

cd $PBS_O_WORKDIR

## Load modules
module load bowtie/1.0.0
module load samtools/1.3.1
module load Anaconda
source activate emase

## Set directories from "scripts" dir in project dir
DIR="$(dirname "$(pwd)")" ## Get current parent dir=project dir
FASTQDIR=$DIR/fastq
BAMDIR=$DIR/bams
NUM_THREADS=8
FASTQ=${FASTQDIR}/SRR7254941_1.fastq.gz 
SAMPLE=$(basename ${FASTQ} | cut -d . -f 1)

## Following variables are specific files needed to run EMASE
resdir=/projects/baker-lab/emase/R78-REL1505/B6
P2REF=${resdir}/bowtie/B6
strain="B6"
strains="B6"
g2tID=${resdir}/emase.gene2transcripts.tsv
lenFile=${resdir}/emase.transcripts.info

## Run bowtie to map to transcriptome
# zcat ${FASTQ} | \
# bowtie -q --best -a --strata --sam -m 100 -v 3 -p ${NUM_THREADS} ${P2REF} - | \
# samtools view -@ 16 -hbS - | \
# samtools sort -@ 16 - > ${BAMDIR}/${SAMPLE}.sorted.bam

## Run EMASE to asign reads and gather counts
mkdir -p ${BAMDIR}/h5
bam-to-emase -a ${BAMDIR}/${SAMPLE}.sorted.bam -i /projects/baker-lab/emase/R78-REL1505/B6/emase.transcripts.info -s ${strains} -o ${BAMDIR}/h5/${SAMPLE}.h5
echo "Done getting alignment profile .h5 file"

# mkdir -p ${BAMDIR}/counts
run-emase -i ${BAMDIR}/h5/${SAMPLE}.h5 -g ${g2tID} -L ${lenFile} -M 4 -r 50 -o ${BAMDIR}/counts/${SAMPLE}
echo "Done getting counts for emase"

# change permissions
chmod 775 -R $DIR 2>/dev/null

