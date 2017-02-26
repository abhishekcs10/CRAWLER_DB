#!/bin/bash
file_list=($(ls "./Faculty"))
if [ -d "parsed" ]
then 
	rm -r "parsed"
	mkdir "parsed"
else
	mkdir "parsed"
fi

cd "Faculty"
#filename="cs-pallab.html"
#./scanner.out < Faculty/$filename > $filename".par"
for filename in *.html; do
	#echo $filename
	.././scanner.out < $filename > ../"parsed"/$filename".par"
done

