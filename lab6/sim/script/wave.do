onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calc_state_machine_tb/uut/clk
add wave -noupdate /calc_state_machine_tb/uut/reset
add wave -noupdate /calc_state_machine_tb/uut/execute
add wave -noupdate /calc_state_machine_tb/uut/mSave
add wave -noupdate /calc_state_machine_tb/uut/mRecall
add wave -noupdate /calc_state_machine_tb/uut/inputBits
add wave -noupdate /calc_state_machine_tb/uut/inputOperator
add wave -noupdate -radix States /calc_state_machine_tb/uut/onesSSD
add wave -noupdate -radix States /calc_state_machine_tb/uut/tensSSD
add wave -noupdate -radix States /calc_state_machine_tb/uut/hundredsSSD
add wave -noupdate /calc_state_machine_tb/uut/clockedOutput
add wave -noupdate /calc_state_machine_tb/uut/memOut
add wave -noupdate /calc_state_machine_tb/uut/memAddress
add wave -noupdate /calc_state_machine_tb/uut/nextState
add wave -noupdate /calc_state_machine_tb/uut/currentState

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2950 ns}
