#!/bin/bash
LOG_FILE=/var/lib/docker/volumes/data-volume/_data/most_occur_word.txt
res=$(curl -s localhost:80|sed s/\<[^\<]*\>//g|sed s/" "/\\n/g|sed /^[[:space:]]*$/d|sort|uniq -c |sort -nr|sed 's/^[ \t]*//g'|awk '{print $2":"$1}')
echo "Most Frequency word is : " > $LOG_FILE
echo $res|sed s/" "/\\n/g|head -1 >> $LOG_FILE
echo " " >> $LOG_FILE
echo "Top 5 Frequency words are: " >> $LOG_FILE
echo $res|sed s/" "/\\n/g|head -5 >> $LOG_FILE
