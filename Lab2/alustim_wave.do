onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alustim/A
add wave -noupdate /alustim/B
add wave -noupdate /alustim/result
add wave -noupdate /alustim/carry_out
add wave -noupdate /alustim/cntrl
add wave -noupdate /alustim/negative
add wave -noupdate /alustim/zero
add wave -noupdate /alustim/overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000000600 ps} 0} {{Cursor 2} {10000000600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 135
configure wave -valuecolwidth 390
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
WaveRestoreZoom {0 ps} {8706342756 ps}
