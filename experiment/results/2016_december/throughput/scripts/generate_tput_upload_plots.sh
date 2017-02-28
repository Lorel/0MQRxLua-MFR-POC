#!/usr/bin/env sh

export OUTPUT_DIR=../outputs

export XP=1-data-1-worker
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=1-data-2-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=1-data-4-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=4-datas-1-worker
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=4-datas-2-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=4-datas-4-workers
./parse_stats_${XP}.sh
./tput_upload.gp
