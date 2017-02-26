#!/bin/bash
file_list=($(ls "./parsed"))
if [ -d "mysql_parsed" ]
then 
	rm -r "mysql_parsed"
	mkdir "mysql_parsed"
else
	mkdir "mysql_parsed"
fi

cd "./parsed"
#filename="cs-pallab.html"
#./scanner.out < Faculty/$filename > $filename".par"
for filename in *.html.par; do
	echo $filename
	.././mysql $filename > ../"mysql_parsed"/$filename".sql"
done

