onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpustim/clk
add wave -noupdate /cpustim/reset
add wave -noupdate /cpustim/dut/flag_zero
add wave -noupdate /cpustim/dut/flag_carryout
add wave -noupdate /cpustim/dut/flag_overflow
add wave -noupdate /cpustim/dut/flag_negative
add wave -noupdate -radix decimal /cpustim/dut/mem_out
add wave -noupdate -radix binary /cpustim/dut/instruction
add wave -noupdate -radix decimal /cpustim/dut/PC_current
add wave -noupdate -radix decimal /cpustim/dut/rf/reg_outputs
add wave -noupdate /cpustim/dut/RegWrite
add wave -noupdate /cpustim/dut/ALUSrc
add wave -noupdate /cpustim/dut/ImmSrc
add wave -noupdate -radix decimal /cpustim/dut/alu_result
add wave -noupdate -radix decimal /cpustim/dut/reg_writedata
add wave -noupdate -radix decimal /cpustim/dut/bl_writedata
add wave -noupdate -radix decimal /cpustim/dut/reg_write_addr
add wave -noupdate -radix decimal /cpustim/dut/ze_imm
add wave -noupdate -radix decimal /cpustim/dut/muxImmtoALU
add wave -noupdate -radix decimal /cpustim/dut/rf/dec/b0/out
add wave -noupdate -radix decimal /cpustim/dut/rf/dec/b1/out
add wave -noupdate -radix decimal /cpustim/dut/rf/dec/b2/out
add wave -noupdate -radix decimal /cpustim/dut/rf/dec/b3/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {828927 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 292
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5302500 ps}
