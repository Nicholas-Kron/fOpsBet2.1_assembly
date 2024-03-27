#! /usr/bin/env bash
STARdir="/nethome/n.kron/local/STAR/2.6.0a/bin/Linux_x86_64_static"
project="coral_omics"
genome=fOpsBet2.1_genomic.fa
index=fOpsBet2.1_STAR_index

if [ -d ${index} ]
  then
		rm -R ${index}
fi

if [ ! -d ${index} ]
  then
    mkdir ${index}
    bsub -P ${project} -q bigmem -n 10 ${STARdir}/STAR \
      --runThreadN 10 \
      --runMode genomeGenerate \
      --genomeDir ${index} \
      --genomeFastaFiles ${genome} \
      --sjdbOverhang 99
fi
