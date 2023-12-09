vlib work

vlog main.v
vsim main

log {/*}
add wave {/*}


force {KEY[1]} 1
force {CLOCK_50} 0 0ns, 1 {1ns} -r 2ns
run 4ns

force {KEY[1]} 0
run 4ns

run 4000ns