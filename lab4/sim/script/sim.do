vlib work
vcom -93 -work work ../../src/add_sub.vhd
vcom -93 -work work ../../src/add_sub_top.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/synchronizer.vhd
vcom -93 -work work ../src/add_sub_tb.vhd
vsim -voptargs=+acc add_sub_tb
do wave.do
run 6000 ns
