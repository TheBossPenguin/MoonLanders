vlib work

vlog asteroidsPosition.v
vsim asteroidsPosition

log {/*}

add wave {/*}


force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns
run 4ns

force {Reset} 1
run 4ns

force {xSpeedEn} 1
force {object} 0100
run 150ns

force {object} 1000
run 150ns

force {collisionOccured} 1
run 4ns

force {collisionOccured} 0
run 4ns

run 150ns