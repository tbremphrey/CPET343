vlib work
vmap altera_mf ../../src/altera_mf
vcom -93 -work work ../../src/alu.vhd
vcom -93 -work work ../../src/calc_state_machine.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/synchronizer.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/rom/blink_rom.vhd
vcom -93 -work work ../../src/lab7_top.vhd
vcom -93 -work work ../src/lab7_top_tb.vhd
vsim -voptargs=+acc lab7_top_tb
do wave.do
run 2600 ns
