vlib work
vcom -93 -work work full_adder_single_bit_str.vhd
vcom -93 -work work full_adder_single_bit_str_tb.vhd
vsim -voptargs=+acc full_adder_single_bit_str_tb
do wave.do
run 100 ns
