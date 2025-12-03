# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "Lab_7_With_Instruction_Memory"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY lab7_top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/lab7_top.vhd
set_global_assignment -name VHDL_FILE ../../src/rom/blink_rom.vhd
set_global_assignment -name VHDL_FILE ../../src/double_dabble.vhd
set_global_assignment -name VHDL_FILE ../../src/synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/calc_state_machine.vhd
set_global_assignment -name VHDL_FILE ../../src/alu.vhd


set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AA14 -to resetButton
set_location_assignment PIN_Y16  -to nextButton

set_location_assignment PIN_V16  -to stateLED[0]
set_location_assignment PIN_W16  -to stateLED[1]
set_location_assignment PIN_V17  -to stateLED[2]
set_location_assignment PIN_V18  -to stateLED[3]
#set_location_assignment PIN_W17  -to stateLED[3]

#set_location_assignment PIN_AB12 -to inputBits[0]
#set_location_assignment PIN_AC12 -to inputBits[1]
#set_location_assignment PIN_AF9  -to inputBits[2]
#set_location_assignment PIN_AF10 -to inputBits[3]
#set_location_assignment PIN_AD11 -to inputBits[4]
#set_location_assignment PIN_AD12 -to inputBits[5]
#set_location_assignment PIN_AE11 -to inputBits[6]
#set_location_assignment PIN_AC9  -to inputBits[7]

#set_location_assignment PIN_AD10 -to inputOperator[0]
#set_location_assignment PIN_AE12 -to inputOperator[1]

set_location_assignment PIN_AE26 -to SSD0[0]
set_location_assignment PIN_AE27 -to SSD0[1]
set_location_assignment PIN_AE28 -to SSD0[2]
set_location_assignment PIN_AG27 -to SSD0[3]
set_location_assignment PIN_AF28 -to SSD0[4]
set_location_assignment PIN_AG28 -to SSD0[5]
set_location_assignment PIN_AH28 -to SSD0[6]

set_location_assignment PIN_AJ29 -to SSD1[0]
set_location_assignment PIN_AH29 -to SSD1[1]
set_location_assignment PIN_AH30 -to SSD1[2]
set_location_assignment PIN_AG30 -to SSD1[3]
set_location_assignment PIN_AF29 -to SSD1[4]
set_location_assignment PIN_AF30 -to SSD1[5]
set_location_assignment PIN_AD27 -to SSD1[6]

set_location_assignment PIN_AB23 -to SSD2[0]
set_location_assignment PIN_AE29 -to SSD2[1]
set_location_assignment PIN_AD29 -to SSD2[2]
set_location_assignment PIN_AC28 -to SSD2[3]
set_location_assignment PIN_AD30 -to SSD2[4]
set_location_assignment PIN_AC29 -to SSD2[5]
set_location_assignment PIN_AC30 -to SSD2[6]

# set_location_assignment PIN_AD26 -to bcd_3[0]
# set_location_assignment PIN_AC27 -to bcd_3[1]
# set_location_assignment PIN_AD25 -to bcd_3[2]
# set_location_assignment PIN_AC25 -to bcd_3[3]
# set_location_assignment PIN_AB28 -to bcd_3[4]
# set_location_assignment PIN_AB25 -to bcd_3[5]
# set_location_assignment PIN_AB22 -to bcd_3[6]

# set_location_assignment PIN_AA24 -to bcd_4[0]
# set_location_assignment PIN_Y23  -to bcd_4[1]
# set_location_assignment PIN_Y24  -to bcd_4[2]
# set_location_assignment PIN_W22  -to bcd_4[3]
# set_location_assignment PIN_W24  -to bcd_4[4]
# set_location_assignment PIN_V23  -to bcd_4[5]
# set_location_assignment PIN_W25  -to bcd_4[6]

# set_location_assignment PIN_V25  -to bcd_5[0]
# set_location_assignment PIN_AA28 -to bcd_5[1]
# set_location_assignment PIN_Y27  -to bcd_5[2]
# set_location_assignment PIN_AB27 -to bcd_5[3]
# set_location_assignment PIN_AB26 -to bcd_5[4]
# set_location_assignment PIN_AA26 -to bcd_5[5]
# set_location_assignment PIN_AA25 -to bcd_5[6]

execute_flow -compile
project_close