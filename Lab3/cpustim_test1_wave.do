onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpustim/clk
add wave -noupdate /cpustim/reset
add wave -noupdate /cpustim/dut/instruction
add wave -noupdate /cpustim/dut/PC_current
add wave -noupdate /cpustim/dut/PC_next
add wave -noupdate /cpustim/dut/branch_target
add wave -noupdate /cpustim/dut/Reg2Loc
add wave -noupdate /cpustim/dut/RegWrite
add wave -noupdate /cpustim/dut/ALUSrc
add wave -noupdate /cpustim/dut/Branch
add wave -noupdate /cpustim/dut/UncondBranch
add wave -noupdate /cpustim/dut/BL
add wave -noupdate /cpustim/dut/BRSel
add wave -noupdate /cpustim/dut/MemWrite
add wave -noupdate /cpustim/dut/MemRead
add wave -noupdate /cpustim/dut/MemtoReg
add wave -noupdate /cpustim/dut/FlagWrite
add wave -noupdate /cpustim/dut/ImmSrc
add wave -noupdate /cpustim/dut/ALUOp
add wave -noupdate /cpustim/dut/reg_read1
add wave -noupdate /cpustim/dut/reg_read2
add wave -noupdate /cpustim/dut/reg_write
add wave -noupdate /cpustim/dut/reg_data1
add wave -noupdate /cpustim/dut/reg_data2
add wave -noupdate /cpustim/dut/reg_writedata
add wave -noupdate /cpustim/dut/alu_result
add wave -noupdate /cpustim/dut/flag_zero
add wave -noupdate /cpustim/dut/flag_carryout
add wave -noupdate /cpustim/dut/flag_overflow
add wave -noupdate /cpustim/dut/flag_negative
add wave -noupdate /cpustim/dut/mem_out
add wave -noupdate /cpustim/dut/reg_write_addr
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
WaveRestoreZoom {14625 ps} {5317125 ps}
