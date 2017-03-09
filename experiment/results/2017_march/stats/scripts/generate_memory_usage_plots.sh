#!/usr/bin/env sh

export OUTPUT_DIR=../outputs
export DATA_DIR=../data
export EXTENSION=.dat
export TMP_PREFIX=tmp_


function parse_stats {
  containers=($CONTAINERS)

  prefix=$PREFIX
  extension=$EXTENSION
  tmp_prefix=$TMP_PREFIX

  suffixed_list=(${containers[@]/%/$extension})
  files_list=(${suffixed_list[@]/#/$prefix})

  for file in ${files_list[@]}; do
    awk -F ' ' {'print $3'}  $DATA_DIR/$XP/$file | tail -n +2 >> $tmp_prefix$file
  done

  tmp_files_list=(${files_list[@]/#/${tmp_prefix}})

  paste ${tmp_files_list[@]} > all_mem.dat

  cat all_mem.dat | lua  stats_cdf.lua > $DATA_DIR/$XP/memory_usage_percentiles_$XP.txt

  rm ${tmp_files_list[@]} all_mem.dat
}


# export PREFIX=stats-test_
#
# export XP=1-workers
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mapper_1 filter_1 reduce_1 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP=2-workers
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mapper_1 mapper_2 filter_1 filter_2 reduce_1 reduce_2 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP=4-workers
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mapper_1 mapper_2 mapper_3 mapper_4 filter_1 filter_2 filter_3 filter_4 reduce_1 reduce_2 reduce_3 reduce_4 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
#
# export PREFIX=stats-testsgx_
#
# export XP="1-workers-mappersgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 filter_1 reduce_1 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP="2-workers-mappersgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 mappersgx_2 filter_1 filter_2 reduce_1 reduce_2 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP="4-workers-mappersgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 mappersgx_2 mappersgx_3 mappersgx_4 filter_1 filter_2 filter_3 filter_4 reduce_1 reduce_2 reduce_3 reduce_4 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
#
# export PREFIX=stats-testsgx_
#
# export XP="1-workers-fullsgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 filtersgx_1 reducesgx_1 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP="2-workers-fullsgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 mappersgx_2 filtersgx_1 filtersgx_2 reducesgx_1 reducesgx_2 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp
#
# export XP="4-workers-fullsgx"
# export CONTAINERS="data1_1 data2_1 data3_1 data4_1 mappersgx_1 mappersgx_2 mappersgx_3 mappersgx_4 filtersgx_1 filtersgx_2 filtersgx_3 filtersgx_4 reducesgx_1 reducesgx_2 reducesgx_3 reducesgx_4 printer_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
# parse_stats
# ./plot_memory_usage.gp


export PREFIX=stats-testencrypted_

export XP="1-workers-encrypted-nosgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mapper_1 filter_1 reduce_1 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp

export XP="2-workers-encrypted-nosgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mapper_1 mapper_2 filter_1 filter_2 reduce_1 reduce_2 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp

export XP="4-workers-encrypted-nosgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mapper_1 mapper_2 mapper_3 mapper_4 filter_1 filter_2 filter_3 filter_4 reduce_1 reduce_2 reduce_3 reduce_4 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp


export PREFIX=stats-testsgx_

export XP="1-workers-encrypted-fullsgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mappersgx_1 filtersgx_1 reducesgx_1 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp

export XP="2-workers-encrypted-fullsgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mappersgx_1 mappersgx_2 filtersgx_1 filtersgx_2 reducesgx_1 reducesgx_2 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp

export XP="4-workers-encrypted-fullsgx"
export CONTAINERS="datasgx1_1 datasgx2_1 datasgx3_1 datasgx4_1 mappersgx_1 mappersgx_2 mappersgx_3 mappersgx_4 filtersgx_1 filtersgx_2 filtersgx_3 filtersgx_4 reducesgx_1 reducesgx_2 reducesgx_3 reducesgx_4 printersgx_1 routerdatamapper_1 routerfilterreduce_1 routermapperfilter_1 routerreduceprinter_1"
parse_stats
./plot_memory_usage.gp
