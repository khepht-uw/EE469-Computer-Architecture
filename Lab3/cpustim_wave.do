onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /cpustim/clk
add wave -noupdate -radix binary /cpustim/dut/instruction
add wave -noupdate -radix decimal /cpustim/dut/PC_current
add wave -noupdate -radix decimal /cpustim/dut/PC_next
add wave -noupdate -radix decimal /cpustim/dut/rf/reg_outputs
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
add wave -noupdate /cpustim/dut/reg_read1
add wave -noupdate -radix decimal /cpustim/dut/reg_data1
add wave -noupdate /cpustim/dut/reg_read2
add wave -noupdate -radix decimal /cpustim/dut/reg_data2
add wave -noupdate /cpustim/dut/se_dAddr
add wave -noupdate /cpustim/dut/ALUSrc
add wave -noupdate -radix decimal /cpustim/dut/alu_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59965244 ps} 0}
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
WaveRestoreZoom {52045011 ps} {61367091 ps}
