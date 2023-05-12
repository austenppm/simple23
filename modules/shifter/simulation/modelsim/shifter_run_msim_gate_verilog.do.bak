transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {shifter.vo}

vlog -vlog01compat -work work +incdir+C:/Users/kazu4/2023-simple-2023-team23/shifter/simulation/modelsim {C:/Users/kazu4/2023-simple-2023-team23/shifter/simulation/modelsim/shifter_test1.vt}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  test1

add wave *
view structure
view signals
run -all
