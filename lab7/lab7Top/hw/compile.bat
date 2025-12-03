quartus_sh -t compile.tcl
pause
quartus_pgm --mode=JTAG -o P;output_files\Lab_7_With_Instruction_Memory.sof@2
pause