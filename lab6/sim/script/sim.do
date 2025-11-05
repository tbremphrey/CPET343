vlib work
vcom -93 -work work ../../src/alu.vhd
vcom -93 -work work ../../src/calc_state_machine.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/synchronizer.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../src/calc_state_machine_tb.vhd
vsim -voptargs=+acc calc_state_machine_tb
do wave.do
run 2950 ns
