#!/bin/bash

# This script writes a csv of "target-fastq, link-names" in ~/scripts/

###########################################change only these parameters#################################################

#End these variables with a /
targetdir=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/
linkdir=/nfs/pgsb/projects/comparative_triticeae/phenotype/flower_development/refsets/triticum/

#These variables should point to files
sratagfile=~/scripts/ngtmpindex
csvfile=~/scripts/$(basename -s .txt $sratagfile).csv
#########################################################################################################################
csvr(){
>$csvfile
while read sratag;
do
if [ -s ${targetdir}*${sratag}*1*  ] && [ -s ${targetdir}*${sratag}*2* ]
then
{
echo "$(find $targetdir -maxdepth 1 -name "*$sratag*1*"), ${linkdir}FRR${sratag}_1.fastq.gz" >> $csvfile
echo "$(find $targetdir -maxdepth 1 -name "*$sratag*2*"), ${linkdir}FRR${sratag}_2.fastq.gz" >> $csvfile
}
else 
echo "$(find $targetdir -maxdepth 1 -name "*$sratag*"), $linkdir${sratag}.fastq.gz" >> $csvfile
fi

done < $sratagfile 

echo  check out this file: $csvfile
head $csvfile -n 3
}
csvr
