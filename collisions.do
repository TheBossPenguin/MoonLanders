vlib work

vlog collisions.v
vsim collisions

log {/*}

add wave {/*}


force {Reset} 0
force {Clock} 0 0ns, 1 {1ns} -r 2ns
run 4ns

force {Reset} 1
run 4ns

force {rocketX} 101000000
force {rocketY} 101111100

force {asteroid1X} 101001010
force {asteroid1Y} 101101000
run 12ns

force {asteroid2X} 100001110
force {asteroid2Y} 101001010
run 12ns

force {asteroid3X} 101010100
force {asteroid3Y} 110100100
run 12ns

force {asteroid4X} 101011110
force {asteroid4Y} 101011110
run 12ns

force {asteroid5X} 101011110
force {asteroid5Y} 110010000
run 12ns

force {asteroid6X} 100011010
force {asteroid6Y} 110100010
run 12ns

force {asteroid7X} 100011010
force {asteroid7Y} 110100101
run 12ns
