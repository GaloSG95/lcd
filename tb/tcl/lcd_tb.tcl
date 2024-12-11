restart -f -nowave
config wave -signalnamewidth 1

add wave clk
add wave reset

add wave -divider ports
add wave lcd_rs 
add wave lcd_rw
add wave lcd_e
add wave lcd_db

add wave -divider counter
add wave -radix unsigned uut/counter_150us
add wave -radix unsigned uut/counter_5ms
add wave -radix unsigned uut/counter_15ms

add wave -divider states
add wave uut/state
add wave uut/next_state

run -all

view signals wave