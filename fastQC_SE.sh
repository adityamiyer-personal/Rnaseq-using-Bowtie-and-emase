#!/bin/bash

#PBS -l nodes=1:ppn=1,walltime=2:00:00

cd $PBS_O_WORKDIR

module load fastqc/0.11.5

FASTQDIR=/projects/baker-lab/mahada/rnaseq/fastq/
FNAME=SRR7254951_2.fastq.gz

fastqc ${FASTQDIR}${FNAME} -o ${FASTQDIR}
