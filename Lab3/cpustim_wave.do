onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpustim/clk
add wave -noupdate /cpustim/reset
add wave -noupdate /cpustim/dut/instruction
add wave -noupdate /cpustim/dut/PC_current
add wave -noupdate -radix decimal /cpustim/dut/PC_next
add wave -noupdate -radix decimal /cpustim/dut/rf/reg_outputs
add wave -noupdate -radix decimal /cpustim/dut/reg_read1
add wave -noupdate -radix decimal /cpustim/dut/reg_read2
add wave -noupdate -radix decimal /cpustim/dut/reg_data1
add wave -noupdate -radix decimal /cpustim/dut/reg_data2
add wave -noupdate /cpustim/dut/BRSel
add wave -noupdate /cpustim/dut/UncondBranch
add wave -noupdate /cpustim/dut/BrTaken
add wave -noupdate -radix decimal /cpustim/dut/branch_target
add wave -noupdate -radix decimal /cpustim/dut/alu_result
add wave -noupdate /cpustim/dut/ImmSrc
add wave -noupdate /cpustim/dut/ALUSrc
add wave -noupdate /cpustim/dut/Reg2Loc
add wave -noupdate -radix decimal /cpustim/dut/se_dAddr
add wave -noupdate -radix decimal /cpustim/dut/se_condAddr
add wave -noupdate -radix decimal /cpustim/dut/se_brAddr
add wave -noupdate -radix decimal /cpustim/dut/br_shifted
add wave -noupdate /cpustim/dut/ALUOp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1027097 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 311
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
WaveRestoreZoom {0 ps} {1319064 ps}
