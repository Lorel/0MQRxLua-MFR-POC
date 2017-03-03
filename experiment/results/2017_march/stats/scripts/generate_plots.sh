#!/usr/bin/env bash


echo "Generate throughput plots..."
./generate_cpu_usage_plots.sh

echo "Generate memory usage plots..."
./generate_memory_usage_plots.sh

echo "Generate CPU plots..."
./generate_tput_upload_plots.sh

echo "Done!"
