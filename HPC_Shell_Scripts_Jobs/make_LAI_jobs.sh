#! /usr/bin/env bash

#! /usr/bin/env bash

for asm in `cat fas.txt`
do

name=`echo ${asm} | sed 's/[.]fa//g'`
mkdir ${name}

echo "
#!/bin/bash
#BSUB -J LAI_${asm}
#BSUB -P coral_omics
#BSUB -o LAI_${asm}.out
#BSUB -e LAI_${asm}.err
#BSUB -n 15
#BSUB -q general

echo \$(date -u) \"Begin calculating LAI metrics...\"

echo \$(date -u) \"Being analyzing ${asm}...\"

export PERL5LIB="/nethome/n.kron/mambaforge/envs/ltr_retriever/bin/perl5.32.1"

###LTR_FINDER
echo \$(date -u) \"Running LTR_Finder on ${asm}...\"

mkdir finder
cd finder

perl ~/local/LTR_FINDER_parallel/LTR_FINDER_parallel \
-seq ${asm} \
-harvest_out \
-t 15 \
-size 1000000 \
-time 300 

echo \$(date -u) \"LTR_Finder complete, continuing...\"

cd ../

###LTRHarvest
echo \$(date -u) \"Running LTRHarvest on ${asm}...\"

mkdir harvest
cd harvest

ln -s ../${asm} ${asm}

####build suffix array for ltrharvest

gt suffixerator -db ${asm} -indexname ${asm} -tis -suf -lcp -des -ssp -sds -dna

gt ltrharvest -index ${asm} \
-minlenltr 100 \
-maxlenltr 7000 \
-mintsd 4 \
-maxtsd 6 \
-motif TGCA \
-motifmis 1 \
-similar 85 \
-vic 10 \
-seed 20 \
-seqids yes > ${asm}.harvest.scn

echo \$(date -u) \"LTRHarvest complete, continuing...\"

cd ../

### LTR_retriever
echo \$(date -u) \"Running LTR_retriever with LTR res for ${asm}...\"

mkdir retriever
cd retriever

cat ../finder/${asm}.finder.combine.scn  ../harvest/${asm}.harvest.scn > ${asm}.rawLTR.scn

LTR_retriever -genome ${asm} -inharvest ${asm}.rawLTR.scn -threads 15 

echo \$(date -u) \"LTR_retriever complete, continuing...\"

###LAI calculation
echo \$(date -u) \"Calculating LAI for ${asm}...\"

LAI -genome ${asm} -intact ${asm}.pass.list -all ${asm}.out

echo \$(date -u) \"LAI for ${asm} calculated!\"

echo \$(date -u) \"LAIs calculated for all input assemblies! Bye!\"
" > ${name}/${name}_LAI.job

done
