vlib work

vlog drawBackground.v
vsim -L altera_mf_ver drawBackground

log {/*}

add wave {/*}

force {currentLevel} 000
force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns

run 4ns
force {Reset} 1

run 4ns
force {backgroundSignal} 1
run 45000ns

force {backgroundSignal} 0
run 2ns

force {backgroundSignal} 1
run 2000ns



