#!/bin/bash

folder="$1"
outputfile=./output


for file in "$folder"/*
do
	number=`grep -c "<Author>" "$file"`
	filename=`basename $file .dat`
	echo "$filename $number" >> $outputfile
done

sort -k2 -n -r $outputfile > sorted.out
cat sorted.out
rm ./output
rm ./sorted.out
