#!/usr/bin/env sh

export OUTPUT_DIR=../outputs

export XP=1-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=2-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=4-workers
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=1-workers-sgx
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=2-workers-sgx
./parse_stats_${XP}.sh
./tput_upload.gp

export XP=4-workers-sgx
./parse_stats_${XP}.sh
./tput_upload.gp
