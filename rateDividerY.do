vlib work

vlog rocketPosition.v
vsim rateDividerY

log -r {/*}
add wave -r {/*}

force {Reset} 1
force {Clock} 0 0ns, 1 {2ns} -r 4ns

force {Reset} 0
run 4ns

run 100ns