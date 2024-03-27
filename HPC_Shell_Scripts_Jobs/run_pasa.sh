#! /bin/bash

#clean the fasta

seqclean  Obeta_hq_transcripts_fixed.fasta -c 15

#launch PASA after making the config files
${PASAHOME}/Launch_PASA_pipeline.pl -c alignAssembly.config \
-C \
-r \
-R \
-g fOpsBet2.1_genomic.fa \
-t Obeta_hq_transcripts_fixed.fasta.clean \
-T \
-u Obeta_hq_transcripts_fixed.fasta \
--ALT_SPLICE \
--ALIGNERS blat,minimap2 \
--TRANSDECODER \
--CPU 15 \
1>pasa.err \
2>pasa.out


#Get protein assemblies via transdecoder
$PASAHOME/scripts/pasa_asmbls_to_training_set.dbi \
--pasa_transcripts_fasta Opsanus_beta_Bic_pasa.assemblies.fasta \
--pasa_transcripts_gff3 Opsanus_beta_Bic_pasa.pasa_assemblies.gff3 \
1>pasa_transdecoder.err \
2>pasa_transdecoder.out
