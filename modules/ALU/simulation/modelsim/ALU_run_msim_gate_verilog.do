transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {ALU.vo}

vlog -vlog01compat -work work +incdir+C:/Users/kazu4/2023-simple-2023-team23/ALU/simulation/modelsim {C:/Users/kazu4/2023-simple-2023-team23/ALU/simulation/modelsim/ALU_test2.vt}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  test2

add wave *
view structure
view signals
run -all
