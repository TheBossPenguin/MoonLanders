vlib work

vlog drawBox.v
vsim drawBox

log {/*}
add wave {/*}


force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns
force {backgroundSignal} 0
run 4ns

force {Reset} 1
run 4ns

force {plotSignal} 1
force {xCoord} 1001100
force {yCoord} 1100100
force {object} 1
force {colour} 001

run 600ns

force {plotSignal} 0
run 2ns

force {plotSignal} 1
force {xCoord} 0
force {yCoord} 0
force {object} 10
force {colour} 001
run 600ns