onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpustim/dut/clk
add wave -noupdate -radix binary /cpustim/dut/instruction
add wave -noupdate /cpustim/dut/PC_current
add wave -noupdate /cpustim/dut/PC_next
add wave -noupdate -radix decimal /cpustim/dut/rf/reg_outputs
add wave -noupdate /cpustim/dut/reg_read1
add wave -noupdate /cpustim/dut/reg_read2
add wave -noupdate -radix decimal /cpustim/dut/reg_data1
add wave -noupdate -radix decimal /cpustim/dut/reg_data2
add wave -noupdate /cpustim/dut/reg_write
add wave -noupdate -radix binary /cpustim/dut/ALUOp
add wave -noupdate /cpustim/dut/alu_result
add wave -noupdate /cpustim/dut/zero
add wave -noupdate -radix binary /cpustim/dut/carryout
add wave -noupdate /cpustim/dut/overflow
add wave -noupdate -radix binary /cpustim/dut/negative
add wave -noupdate {/cpustim/dut/data_memory/mem[0]}
add wave -noupdate {/cpustim/dut/data_memory/mem[8]}
add wave -noupdate {/cpustim/dut/data_memory/mem[16]}
add wave -noupdate {/cpustim/dut/data_memory/mem[24]}
add wave -noupdate {/cpustim/dut/data_memory/mem[32]}
add wave -noupdate {/cpustim/dut/data_memory/mem[40]}
add wave -noupdate {/cpustim/dut/data_memory/mem[48]}
add wave -noupdate {/cpustim/dut/data_memory/mem[56]}
add wave -noupdate {/cpustim/dut/data_memory/mem[64]}
add wave -noupdate -radix decimal {/cpustim/dut/data_memory/mem[72]}
add wave -noupdate /cpustim/dut/branch_target
add wave -noupdate /cpustim/dut/Reg2Loc
add wave -noupdate -radix binary /cpustim/dut/RegWrite
add wave -noupdate -radix binary /cpustim/dut/ALUSrc
add wave -noupdate -radix binary /cpustim/dut/FlagWrite
add wave -noupdate -radix binary /cpustim/dut/ImmSrc
add wave -noupdate -radix binary /cpustim/dut/Branch
add wave -noupdate -radix binary /cpustim/dut/UncondBranch
add wave -noupdate -radix binary /cpustim/dut/BL
add wave -noupdate -radix binary /cpustim/dut/BRSel
add wave -noupdate -radix binary /cpustim/dut/MemWrite
add wave -noupdate /cpustim/dut/MemtoReg
add wave -noupdate /cpustim/dut/MemRead
add wave -noupdate /cpustim/dut/CBZ_Br
add wave -noupdate /cpustim/dut/BLT_Br
add wave -noupdate /cpustim/dut/reg_writedata
add wave -noupdate /cpustim/dut/se_dAddr
add wave -noupdate /cpustim/dut/se_condAddr
add wave -noupdate /cpustim/dut/se_brAddr
add wave -noupdate /cpustim/dut/ze_imm
add wave -noupdate /cpustim/dut/br_imm_selected
add wave -noupdate /cpustim/dut/br_shifted
add wave -noupdate /cpustim/dut/muxImmtoALU
add wave -noupdate /cpustim/dut/alu_b
add wave -noupdate /cpustim/dut/flag_zero
add wave -noupdate -radix binary /cpustim/dut/flag_carryout
add wave -noupdate -radix binary /cpustim/dut/flag_overflow
add wave -noupdate -radix binary /cpustim/dut/flag_negative
add wave -noupdate /cpustim/dut/reg_write_addr
add wave -noupdate /cpustim/dut/cbz_taken
add wave -noupdate /cpustim/dut/blt_taken
add wave -noupdate /cpustim/dut/BrTaken
add wave -noupdate /cpustim/dut/bl_writedata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {850000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 236
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
WaveRestoreZoom {0 ps} {9322080 ps}
