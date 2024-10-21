#!/bin/bash
#PBS -l nodes=1:ppn=6,walltime=04:00:00

cd $PBS_O_WORKDIR

module load java/1.7.0_79

FASTQDIR=/projects/baker-lab/mahada/testismac/trim/
FNAME=SRR7254749.fastq.gz
OPATH=${FASTQDIR}trim/
ONAME=$(echo ${FNAME} | sed 's/fastq/trim.fastq/')

java -jar /opt/compsci/Trimmomatic/0.33/trimmomatic-0.33.jar SE \
        -threads 6 ${FASTQDIR}${FNAME} ${OPATH}${ONAME} \
        LEADING:20 TRAILING:3 MINLEN:36

