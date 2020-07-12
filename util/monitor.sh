#!/bin/bash
DAY=$(date +%F)
CONTAINER=nginx01
LOG_FILE_NAME=docker_monitor.log.$DAY
LOG_FILE_PATH=/var/lib/docker/volumes/data-volume/_data/
LOG_FILE=${LOG_FILE_PATH}${LOG_FILE_NAME}


logger(){
	echo [$(date +%F_%T -d "+12 hours")]:|awk -F+ -v var=$1 '{printf("%s %s\n", $1, var)}' >> $LOG_FILE
}

while true
do
status=$(docker ps -f "name=${CONTAINER}" --format '{{.Names}}:{{.Status}}:{{.ID}}'|sed s/" "/_/g)
rusage=$(docker stats ${CONTAINER} --no-stream --format '{{.Name}}_{{.CPUPerc}}_{{.MemUsage}}_{{.NetIO}}_{{.BlockIO}}'|sed s/" "//g)
stat_title="===HealthStatOf:${CONTAINER}==="
logger $stat_title
logger $status
logger " "
res_columns="Name_CPU%_MemUsage_NetIO_BlockIO"
res_title="===ResourceUsageOf:${CONTAINER}==="
logger $res_title
logger $res_columns
logger $rusage
logger " "
sleep 10
done



