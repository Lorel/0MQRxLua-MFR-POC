awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_data1_1.dat               | tail -n +2 >> tmp_stats-testsgx_data1_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_data2_1.dat               | tail -n +2 >> tmp_stats-testsgx_data2_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_data3_1.dat               | tail -n +2 >> tmp_stats-testsgx_data3_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_data4_1.dat               | tail -n +2 >> tmp_stats-testsgx_data4_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_mappersgx_1.dat              | tail -n +2 >> tmp_stats-testsgx_mappersgx_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_mappersgx_2.dat              | tail -n +2 >> tmp_stats-testsgx_mappersgx_2.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_mappersgx_3.dat              | tail -n +2 >> tmp_stats-testsgx_mappersgx_3.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_mappersgx_4.dat              | tail -n +2 >> tmp_stats-testsgx_mappersgx_4.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_filter_1.dat              | tail -n +2 >> tmp_stats-testsgx_filter_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_filter_2.dat              | tail -n +2 >> tmp_stats-testsgx_filter_2.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_filter_3.dat              | tail -n +2 >> tmp_stats-testsgx_filter_3.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_filter_4.dat              | tail -n +2 >> tmp_stats-testsgx_filter_4.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_reduce_1.dat              | tail -n +2 >> tmp_stats-testsgx_reduce_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_reduce_2.dat              | tail -n +2 >> tmp_stats-testsgx_reduce_2.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_reduce_3.dat              | tail -n +2 >> tmp_stats-testsgx_reduce_3.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_reduce_4.dat              | tail -n +2 >> tmp_stats-testsgx_reduce_4.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_printer_1.dat             | tail -n +2 >> tmp_stats-testsgx_printer_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_routerdatamapper_1.dat    | tail -n +2 >> tmp_stats-testsgx_routerdatamapper_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_routerfilterreduce_1.dat  | tail -n +2 >> tmp_stats-testsgx_routerfilterreduce_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_routermapperfilter_1.dat  | tail -n +2 >> tmp_stats-testsgx_routermapperfilter_1.dat
awk -F ' ' {'print $5'}  ../data/$XP/stats-testsgx_routerreduceprinter_1.dat | tail -n +2 >> tmp_stats-testsgx_routerreduceprinter_1.dat

paste \
    tmp_stats-testsgx_data1_1.dat \
    tmp_stats-testsgx_data2_1.dat \
    tmp_stats-testsgx_data3_1.dat \
    tmp_stats-testsgx_data4_1.dat \
    tmp_stats-testsgx_mappersgx_1.dat \
    tmp_stats-testsgx_mappersgx_2.dat \
    tmp_stats-testsgx_mappersgx_3.dat \
    tmp_stats-testsgx_mappersgx_4.dat \
    tmp_stats-testsgx_filter_1.dat \
    tmp_stats-testsgx_filter_2.dat \
    tmp_stats-testsgx_filter_3.dat \
    tmp_stats-testsgx_filter_4.dat \
    tmp_stats-testsgx_reduce_1.dat \
    tmp_stats-testsgx_reduce_2.dat \
    tmp_stats-testsgx_reduce_3.dat \
    tmp_stats-testsgx_reduce_4.dat \
    tmp_stats-testsgx_printer_1.dat \
    tmp_stats-testsgx_routerdatamapper_1.dat \
    tmp_stats-testsgx_routerfilterreduce_1.dat \
    tmp_stats-testsgx_routermapperfilter_1.dat \
    tmp_stats-testsgx_routerreduceprinter_1.dat > all_tx.dat

cat all_tx.dat | lua  stats.lua > ../data/$XP/tput_tx_percentiles_$XP.txt

rm tmp_stats-testsgx_data1_1.dat
rm tmp_stats-testsgx_data2_1.dat
rm tmp_stats-testsgx_data3_1.dat
rm tmp_stats-testsgx_data4_1.dat
rm tmp_stats-testsgx_mappersgx_1.dat
rm tmp_stats-testsgx_mappersgx_2.dat
rm tmp_stats-testsgx_mappersgx_3.dat
rm tmp_stats-testsgx_mappersgx_4.dat
rm tmp_stats-testsgx_filter_1.dat
rm tmp_stats-testsgx_filter_2.dat
rm tmp_stats-testsgx_filter_3.dat
rm tmp_stats-testsgx_filter_4.dat
rm tmp_stats-testsgx_reduce_1.dat
rm tmp_stats-testsgx_reduce_2.dat
rm tmp_stats-testsgx_reduce_3.dat
rm tmp_stats-testsgx_reduce_4.dat
rm tmp_stats-testsgx_printer_1.dat
rm tmp_stats-testsgx_routerdatamapper_1.dat
rm tmp_stats-testsgx_routerfilterreduce_1.dat
rm tmp_stats-testsgx_routermapperfilter_1.dat
rm tmp_stats-testsgx_routerreduceprinter_1.dat
rm all_tx.dat
