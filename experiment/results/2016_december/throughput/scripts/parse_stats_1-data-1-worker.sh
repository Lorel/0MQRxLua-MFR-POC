awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_data4_1.dat               | tail -n +2 >> tmp_stats-test_data4_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_mapper_1.dat              | tail -n +2 >> tmp_stats-test_mapper_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_filter_1.dat              | tail -n +2 >> tmp_stats-test_filter_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_reduce_1.dat              | tail -n +2 >> tmp_stats-test_reduce_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_printer_1.dat             | tail -n +2 >> tmp_stats-test_printer_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_routerdatamapper_1.dat    | tail -n +2 >> tmp_stats-test_routerdatamapper_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_routerfilterreduce_1.dat  | tail -n +2 >> tmp_stats-test_routerfilterreduce_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_routermapperfilter_1.dat  | tail -n +2 >> tmp_stats-test_routermapperfilter_1.dat
awk -F ' ' {'print $5'}  ../datas/$XP/stats-test_routerreduceprinter_1.dat | tail -n +2 >> tmp_stats-test_routerreduceprinter_1.dat

paste \
    tmp_stats-test_data4_1.dat \
    tmp_stats-test_mapper_1.dat \
    tmp_stats-test_filter_1.dat \
    tmp_stats-test_reduce_1.dat \
    tmp_stats-test_printer_1.dat \
    tmp_stats-test_routerdatamapper_1.dat \
    tmp_stats-test_routerfilterreduce_1.dat \
    tmp_stats-test_routermapperfilter_1.dat \
    tmp_stats-test_routerreduceprinter_1.dat > all_tx.dat

cat all_tx.dat | lua  stats.lua > ../datas/$XP/tput_tx_percentiles_$XP.txt

rm tmp_stats-test_data4_1.dat
rm tmp_stats-test_mapper_1.dat
rm tmp_stats-test_filter_1.dat
rm tmp_stats-test_reduce_1.dat
rm tmp_stats-test_printer_1.dat
rm tmp_stats-test_routerdatamapper_1.dat
rm tmp_stats-test_routerfilterreduce_1.dat
rm tmp_stats-test_routermapperfilter_1.dat
rm tmp_stats-test_routerreduceprinter_1.dat
rm all_tx.dat
