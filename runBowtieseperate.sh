#!/bin/bash

## Load modules
module load bowtie/1.0.0
module load samtools/1.3.1

## Set directories from "scripts" dir in project dir
DIR="$(dirname "$(pwd)")" ## Get current parent dir=project dir
FASTQDIR=$DIR/fastq
BAMDIR=$DIR/bams
NUM_THREADS=8
FASTQ=${FASTQDIR}/SRR7254948_1.fastq.gz
SAMPLE=$(basename ${FASTQ} | cut -d . -f 1)
P2REF=/projects/baker-lab/emase/R78-REL1505/B6/bowtie/B6

## Run bowtie to map to transcriptome
zcat ${FASTQ} | \
bowtie -q --best -a --strata --sam -m 100 -v 3 -p ${NUM_THREADS} ${P2REF} - | \
samtools view -@ 16 -hbS - | \
samtools sort -@ 16 - > ${BAMDIR}/${SAMPLE}.sorted.bam
