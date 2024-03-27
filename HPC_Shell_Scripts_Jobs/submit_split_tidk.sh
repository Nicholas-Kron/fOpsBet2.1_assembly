#! /usr/bin/env bash


#FILES=fOpsBet2.1_genomic_split/all.hifi_reads.part_001.fa

for FILE in fOpsBet2.1_genomic_split/*.fa
#for FILE in $FILES
do
COMMAND="tidk explore -m 5 -x 12 --distance 1 -v $FILE 1>${FILE}_tidk_explore.out 2>${FILE}_tidk_explore.stderr"

echo "submitting job for $FILE"
echo $COMMAND

bsub -P coral_omics -J tidk_$(basename $FILE) -e tidk_$(basename $FILE).err -o tidk_$(basename $FILE).out -q general -n 5 -W 48:00 exec ${COMMAND}

done

echo "All done"
