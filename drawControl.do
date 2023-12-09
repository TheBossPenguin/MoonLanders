vlib work

vlog drawControl.v
vsim drawControl

log {/*}

add wave {/*}


force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns
force {start} 0
force {level} 001
force {backgroundDone} 0
force {done} 0
run 2ns

force {Reset} 1
run 2ns


force {start} 1

run 20ns

force {start} 0
force {backgroundDone} 1
force {done} 1

run 1800000ns

force {level} 100
run 1800000ns

force {start} 1
run 100ns

force {start} 0
run 4ns

force {start} 1
run 100ns


