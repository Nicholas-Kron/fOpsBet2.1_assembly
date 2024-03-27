#!/bin/bash

#BSUB -P coral_omics
#BSUB -J fOpsBet2.1_IPS
#BSUB -e fOpsBet2.1_IPS.err
#BSUB -o fOpsBet2.1_IPS.out
#BSUB -W 120:00
#BSUB -n 16
#BSUB -q bigmem
#BSUB -R "rusage[mem=2000]"


module load java/17
module load python/3.8.7

IPS=/nethome/n.kron//projspace/my_interproscan/interproscan-5.52-86.0/
PROTEOME=/nethome/n.kron/coral_omics/fOpsBet2.1/funannotate/predict/update_results/Opsanus_beta_Bic.proteins.fa

${IPS}/interproscan.sh -cpu 14 -i ${PROTEOME} -d /nethome/n.kron/coral_omics/fOpsBet2.1/ips
