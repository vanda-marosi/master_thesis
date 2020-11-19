#!/bin/bash
ls *_paired* -lh | cut -d 'r' -f 6 | cut -d 'S' -f1 | cut -d 'E' -f1 | cut -d 'F' -f1 | cut -d 'C' -f1 |cut -c -7 |grep M > ./sizeM.txt
ls *_paired* -lh | cut -d 'r' -f 6 | cut -d 'S' -f1 | cut -d 'E' -f1 | cut -d 'F' -f1 | cut -d 'C' -f1 |cut -c -7 |grep G > ./sizeG.txt
let ma=0
let ga=0
for b in $(cat ./sizeM.txt | cut -d 'M' -f1); do let ma=$ma+$b; done
let ms=$ma/1024
for b in $(cat ./sizeG.txt | cut -d 'G' -f1); do let ga=$ga+$b; done 
let s=$ga+$ms
rm ./size[MG].txt
echo final size is : $s GB

# execute this script in the folder of trimmed fastq files
