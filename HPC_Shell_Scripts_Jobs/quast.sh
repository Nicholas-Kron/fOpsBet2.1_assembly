#!/bin/bash
#BSUB -J quast
#BSUB -q general
#BSUB -P coral_omics
#BSUB -o quast.out
#BSUB -e quast.err
#BSUB -n 8

quast.py -t 5 --eukaryote primary_draft_assembly.fasta 00-assembly/draft_assembly.fasta 10-consensus/consensus.fasta 30-contigger/contigs.fasta 40-polishing/filtered_contigs.fasta assembly.fasta
