#!/usr/bin/env bash

export NETWORK=xp
export DOCKER_HOST=unix:///var/run/docker.sock

echo "Check if network exist..."
docker network ls | grep -e "\s$NETWORK\s"

case "$?" in
	0)
		echo "So cool!"
		;;
	1)
		echo "Network does not exist, we gonna make it appear..."
		docker network create $NETWORK
		;;
	*)
		echo "WTF...?!"
		;;
esac


function run_xp {
  echo "Remove containers from a previous XP if exist..."
  docker-compose stop
  docker-compose rm -f

  echo 'Update source files...'
  cp -f ../data-stream.lua data-stream.lua
  cp -f ../map-csv-to-event.lua map-csv-to-event.lua
  cp -f ../filter-event.lua filter-event.lua
  cp -f ../reduce-events.lua reduce-events.lua
  cp -f ../print-results.lua print-results.lua
  cp -f ../router.lua router.lua

  mkdir -p output
  mkdir -p logs
  echo 'Clean routing logs...'
  rm -f logs/*

  echo "Let's experiment!"
  docker-compose scale routerdatamapper=1 routermapperfilter=1 routerfilterreduce=1 routerreduceprinter=1
  docker-compose scale mapper=${WORKERS:-1} filter=${WORKERS:-1} reduce=${WORKERS:-1}

  #docker-compose scale data1=1 data2=1 data3=1 data4=1
  docker-compose scale data=1

  docker-compose up printer
}

WORKERS=1
export RESULT_OUTPUT=results-$WORKERS.dat
echo "Run XPs with $WORKERS worker(s), output: $RESULT_OUTPUT"

for i in `seq 1 ${N:-5}`
do
  echo "Run XP #$i..."
  run_xp;
done

WORKERS=2
export RESULT_OUTPUT=results-$WORKERS.dat
echo "Run XPs with $WORKERS worker(s), output: $RESULT_OUTPUT"

for i in `seq 1 ${N:-5}`
do
  echo "Run XP #$i..."
  run_xp;
done

WORKERS=4
export RESULT_OUTPUT=results-$WORKERS.dat
echo "Run XPs with $WORKERS worker(s), output: $RESULT_OUTPUT"

for i in `seq 1 ${N:-5}`
do
  echo "Run XP #$i..."
  run_xp;
done
