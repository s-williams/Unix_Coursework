#!/bin/bash

folder="$1"
outputfile=./output
processingfile=./processing

for file in "$folder"/*
do
	SUM=0
	filename=`basename $file .dat`
	#Finds number of reviews in file
	number=`grep -c "<Overall>" "$file"`
	#Gets all instances of rating into new file
	rating=$(grep "<Overall>" "$file" | grep -oP '(?<=<Overall>)[0-9]+' | awk '{SUM+= $1} END {print SUM}')	
	average=`bc -l <<< $rating/$number`
	#Store in outputfile
	echo "$filename $average" >> $outputfile
done
#Sort outputfile
sort -k2 -n -r ./output > ./sorted.out
#Echo outputfile
cat ./sorted.out
#Remove temporary files
rm ./output
rm ./sorted.out

