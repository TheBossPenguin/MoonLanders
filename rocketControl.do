vlib work

vlog rocketControl.v
vsim rocketControl

log {/*}

add wave {/*}


force {Reset} 0
force {up} 0
force {down} 0

force {Clock} 0 0ns, 1 {1ns} -r 2ns

run 4ns

force {Reset} 1
run 4ns

force {up} 1
run 100ns

force {up} 0
force {down} 1
run 100ns

force {down} 0

run 100ns