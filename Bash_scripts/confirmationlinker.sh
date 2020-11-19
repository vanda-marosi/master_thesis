#!/bin/bash

# This script only prints to screen, it does not write to file. Use this to see if your csv is working alright or if you have missing files for corresponding sra ids.

confirmcsv(){ 

while read line
do

#If the first column has more than 5 characters, then print first column "becomes" second column. else, print "this link will have no target"

test  $(echo $line | sed 's/,.*//'| wc -m) -gt 5 && echo $(echo $line | sed 's/,.*//') will link to $(echo $line | sed 's/.*,//') ||  echo this link will have no target ${line##*/}

done < $csvfile
}

####################Change this file only
csvfile=~/scripts/ng*.csv
#############################################################
########################################Operate the script here
#For your first run, make sure the next line is uncommented.
confirmcsv | grep "will have no target"


#For your 2nd run, please comment the previous line and uncomment the next line.
confirmcsv
