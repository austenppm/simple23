## Generated SDC file "simple_pipeline.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Standard Edition"

## DATE    "Thu Jun  8 12:08:03 2023"

##
## DEVICE  "EP4CE30F23I7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {clk1} -period 50.000 -waveform { 0.000 25.000 } [get_ports {clk20}]
create_clock -name {clk2} -period 25.000 -waveform { 0.000 12.500 } [get_ports {clkin}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {pll|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 7 -divide_by 4 -master_clock {clk2} [get_pins {pll|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************

set_clock_latency -source   0.000 [get_clocks {altera_reserved_tck}]
set_clock_latency -source   0.000 [get_clocks {clk1}]
set_clock_latency -source   0.000 [get_clocks {clk2}]
set_clock_latency -source   0.000 [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]


#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {exec}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[0]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[1]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[2]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[3]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[4]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[5]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[6]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[7]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[8]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[9]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[10]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[11]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[12]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[13]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[14]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {in[15]}]
set_input_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {rst_n}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {pll|altpll_component|auto_generated|pll1|clk[0]}]  0.000 [get_ports {altera_reserved_tdo}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_1[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_2[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_3[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_4[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_5[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_6[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_7[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {disp_8[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out2[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {out3[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel3[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel3[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel3[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sel3[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk1}]  0.000 [get_ports {sl_out2[8]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_cells -compatibility_mode *] -to [get_cells -compatibility_mode {counta2:c2|*}]
set_false_path -from [get_cells -compatibility_mode *] -to [get_cells -compatibility_mode {counta3:c3|*}]
set_false_path -from [get_cells -compatibility_mode *] -to [get_cells -compatibility_mode {display:ds|*}]
set_false_path -from [get_ports *] -to [get_cells -compatibility_mode {counta2:c2|*}]
set_false_path -from [get_ports *] -to [get_cells -compatibility_mode {counta3:c3|*}]
set_false_path -from [get_ports *] -to [get_cells -compatibility_mode {display:ds|*}]
set_false_path -from [get_ports {rst_n}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_ports {exec}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_cells {rc|*}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a11~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a9~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a8~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a7~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a3~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a0~porta_address_reg0}] -to [get_cells -compatibility_mode *]
set_false_path -from [get_keepers {ram:ram1|altsyncram:altsyncram_component|altsyncram_sel1:auto_generated|altsyncram_qob2:altsyncram1|ram_block3a5~porta_address_reg0}] -to [get_cells -compatibility_mode *]
#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

