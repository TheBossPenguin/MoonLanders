vlib work

vlog rocketPosition.v
vsim rocketPosition

log {/*}

add wave {/*}

force {collisionOccured} 0
force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns

run 4ns
force {Reset} 1
run 4ns

force {ySpeedEn} 1
force {up} 1
run 48ns

force {up} 0
run 12ns

force {down} 1
run 64ns

force {down} 0
run 12ns

force {up} 1
run 24ns