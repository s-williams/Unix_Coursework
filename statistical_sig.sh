#!/bin/bash

#Getting the data

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


#Finding x^2
for file in "$folder"/*
do
        SUM=0
        filename=`basename $file .dat`
        #Finds number of reviews in file
        number=`grep -c "<Overall>" "$file"`
        #Gets all instances of rating into new file
        rating=$(grep "<Overall>" "$file" | grep -oP '(?<=<Overall>)[0-9]+' | awk '{SUM+= $1^2} END {print SUM}')
        average=`bc -l <<< $rating/$number`
        #Store in outputfile
        echo "$filename $average" >> $outputfile
done
#Sort the means squared
sort -k2 -n -r ./output > ./sortedsquared.out

#Top two hotels mean
toptwo=$(head -n2 ./sorted.out)
first=`echo $toptwo | cut -d " " -f2`
second=`echo $toptwo | cut -d " " -f4`

#Top two hotels mean squared
toptwosquared=$(head -n2 ./sortedsquared.out)
firstsquared=`echo $toptwosquare | cut -d " " -f2`
secondsquared=`echo $toptwosquare | cut -d " " -f4`

#Calculating SD
SDfirst=$(( ('$first'*'$first')-'$firstsquared'))
SDsecond=$(($(($second*$second))-$secondsquared))

#Output
echo t:
echo Mean hotel_1 $first, SD: $SDfirst
echo Mean hotel_2 $second, SD: $SDsecond


#Remove temporary files
rm ./output
rm ./sorted.out

