vlib work
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../src/seven_seg_tb.vhd
vsim -voptargs=+acc seven_seg_tb
do wave.do
run 500 ns
