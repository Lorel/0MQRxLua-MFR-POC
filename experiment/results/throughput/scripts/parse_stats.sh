awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_data4_1.dat               | tail -n +2 >> tmp_stats-test_data4_1.dat              
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_filter_1.dat              | tail -n +2 >> tmp_stats-test_filter_1.dat             
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_mapper_1.dat              | tail -n +2 >> tmp_stats-test_mapper_1.dat             
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_printer_1.dat             | tail -n +2 >> tmp_stats-test_printer_1.dat            
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_reduce_1.dat              | tail -n +2 >> tmp_stats-test_reduce_1.dat             
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_routerdatamapper_1.dat    | tail -n +2 >> tmp_stats-test_routerdatamapper_1.dat   
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_routerfilterreduce_1.dat  | tail -n +2 >> tmp_stats-test_routerfilterreduce_1.dat 
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_routermapperfilter_1.dat  | tail -n +2 >> tmp_stats-test_routermapperfilter_1.dat 
awk -F ' ' {'print $5'}  ../datas/1-data-1-worker/stats-test_routerreduceprinter_1.dat | tail -n +2 >> tmp_stats-test_routerreduceprinter_1.dat

paste \
    tmp_stats-test_data4_1.dat  \
    tmp_stats-test_filter_1.dat \
    tmp_stats-test_mapper_1.dat \
    tmp_stats-test_printer_1.dat\
    tmp_stats-test_reduce_1.dat \
    tmp_stats-test_routerdatamapper_1.dat\
    tmp_stats-test_routerfilterreduce_1.dat\
    tmp_stats-test_routermapperfilter_1.dat\
    tmp_stats-test_routerreduceprinter_1.dat > all_tx.dat

cat all_tx.dat | lua  stats.lua > ../datas/tput_tx_percentiles.txt

rm tmp_stats-test_data4_1.dat              
rm tmp_stats-test_filter_1.dat             
rm tmp_stats-test_mapper_1.dat             
rm tmp_stats-test_printer_1.dat            
rm tmp_stats-test_reduce_1.dat             
rm tmp_stats-test_routerdatamapper_1.dat   
rm tmp_stats-test_routerfilterreduce_1.dat 
rm tmp_stats-test_routermapperfilter_1.dat 
rm tmp_stats-test_routerreduceprinter_1.dat
rm all_tx.dat