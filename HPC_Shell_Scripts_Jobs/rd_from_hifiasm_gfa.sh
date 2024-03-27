#!/usr/bin/env bash

gfa=$1

name=`basename --suffix .gfa ${gfa}`

printf "sequence\tread_depth\n" > ${name}_read_depth.txt

grep -e "rd:i:" ${gfa} | awk '{print $2,$5}' | tr " " "\t" | sed 's/rd:i://g' >> ${name}_read_depth.txt
