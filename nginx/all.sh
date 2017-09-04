
# generate transaction rate 
./parser.py 5 output/nat_siege_conc-1_ > dat/trans-rate-nat-conc-1.dat
./parser.py 5 output/graft_siege_conc-1_ > dat/trans-rate-graft-conc-1.dat
./parser.py 5 output/nat_siege_conc-50_ > dat/trans-rate-nat-conc-50.dat
./parser.py 5 output/graft_siege_conc-50_ > dat/trans-rate-graft-conc-50.dat

# generate throughput
./parser.py 6 output/nat_siege_conc-1_ > dat/throughput-nat-conc-1.dat
./parser.py 6 output/graft_siege_conc-1_ > dat/throughput-graft-conc-1.dat
./parser.py 6 output/nat_siege_conc-50_ > dat/throughput-nat-conc-50.dat
./parser.py 6 output/graft_siege_conc-50_ > dat/throughput-graft-conc-50.dat


gnuplot -e "conc=1" plot-tps.plt
gnuplot -e "conc=50" plot-tps.plt
gnuplot -e "conc=1" plot-bps.plt
gnuplot -e "conc=50" plot-bps.plt
