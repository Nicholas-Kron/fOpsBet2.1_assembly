#! /usr/bin/env bash

SAMPLES=`cat ../../raw_reads/short_read_dna/all_toadie_dna.txt`
READIR=../../raw_reads/short_read_dna

for SAMP in $SAMPLES
do

echo "
#! /usr/bin/env bash
#BSUB -P coral_omics
#BSUB -J ${SAMP}_align
#BSUB -e ${SAMP}_align.err
#BSUB -o ${SAMP}_align.out
#BSUB -W 120:00
#BSUB -n 10
#BUSB -R "rusage[mem=2000]"
#BSUB -q bigmem

echo \$(date -u) \"aligning ${SAMP} to the reference genome with bwa-mem2...\"

bwa-mem2 mem -t 8 fOpsBet2.1_genomic.fa ${READIR}/${SAMP}_1.fastq ${READIR}/${SAMP}_2.fastq | samtools sort -@10 -o ${SAMP}.bam -

samtools index -@10 ${SAMP}.bam

samtools idxstats -@10 ${SAMP}.bam > ${SAMP}.align.stats

echo \$(date -u) \"${SAMP} aligned!\"


" > ${SAMP}_align.job

#bsub < ${SAMP}_align.job

done
