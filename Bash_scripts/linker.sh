#!/bin/bash

#This script creates symbolic links after you are sure of the csv file has only the right files. Please use the confirmationlinker.sh to --dry run this script.

################################################CHANGE THIS
csvfile=~/scripts/ng*.csv
###########################################################

confirmcsv(){ 

while read line
do
test  $(echo $line | sed 's/,.*//'| wc -m) -gt 5 && ln -s $(echo $line | sed 's/,.*//') $(echo $line | sed 's/.*,//') 

done < $csvfile
}

confirmcsv
