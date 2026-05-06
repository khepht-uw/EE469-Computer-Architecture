# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./math.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./muxTo32_1.sv"
vlog "./mux2_1_5b.sv"
vlog "./mux2_1_64b.sv"
vlog "./mux64x32_1.sv"
vlog "./D_FF.sv"
vlog "./e_decoder5_32.sv"
vlog "./fullAdder.sv"
vlog "./adder64.sv"
vlog "./alu_slice.sv"
vlog "./alu.sv"
vlog "./register.sv"
vlog "./regfile.sv"
vlog "./se.sv"
vlog "./pc.sv"
vlog "./flags.sv"
vlog "./control.sv"
vlog "./cpu.sv"
vlog "./cpustim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#FIX THIS
vsim -voptargs="+acc=blarnr" -t 1ps -lib work cpustim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#FIX THIS
do cpustim_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
