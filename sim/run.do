.main clear
quit -sim

vlib work

vlog ./tb_fsm.v
vlog ./../design/*.v

vsim -voptargs=+acc work.tb_fsm

add wave /tb_fsm/fsm_inst/*

run 15us
