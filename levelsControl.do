vlib work

vlog levelsControl.v
vsim levelsControl

log {/*}

add wave {/*}


force {Reset} 0
force {start} 0
force {clear} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns
run 4ns


force {Reset} 1

run 4ns



force {start} 1
run 4ns

force {start} 0
force {clear} 1
run 4ns

force {clear} 0
run 4ns

force {clear} 1
run 4ns

force {clear} 0
run 4ns


force {clear} 1
run 4ns


force {clear} 0
run 4ns

force {start} 1
run 4ns

force {start} 0
run 4ns

force {start} 1
run 4ns

force {start} 0
run 4ns



