#!/usr/local/bin/bash

# Environment variables

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:$HOME/bin

# Retention params, prior to this number of days logs will be deleted :
DAYS="2"

EXPIREDATE=$(date -j -v-"$DAYS"d +"%Y.%m.%d");

/usr/local/bin/elasticdump --input=http://YOUR-IP:9200/logstash-$EXPIREDATE --output=/tmp/logstach-$EXPIREDATE.json --quiet

if [ $? -eq 0 ]
	then
	WCRESULT=($(/usr/bin/wc -l /tmp/logstach-$EXPIREDATE.json))
	LINES=${WCRESULT=[0]}
	LINESCURL=($(/usr/local/bin/curl "http://YOUR-IP:9200/logstash-$EXPIREDATE/_count" -s | egrep -o '[[:digit:]]+' | head -n1))
	#echo $LINES
	#echo $LINESCURL
	if [ $LINES -eq $LINESCURL ]
	then
		/usr/local/bin/curl -X POST http://YOUR-IP:9200/logstash-$EXPIREDATE/_close
		/usr/local/bin/curl -X DELETE http://YOUR-IP:9200/logstash-$EXPIREDATE/_close
			else
		echo "Second condition went wrong"
	fi
	else
		echo "Went bad" >&2
fi
