set_global_assignment -entity "fpga_built_in_clk" -library "lib_fpga_built_in_clk" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "fpga_built_in_clk" -library "lib_fpga_built_in_clk" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "fpga_built_in_clk" -library "lib_fpga_built_in_clk" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fpga_built_in_clk" -name SPD_FILE [file join $::quartus(sip_path) "fpga_built_in_clk.spd"]

set_global_assignment -library "lib_fpga_built_in_clk" -name MISC_FILE [file join $::quartus(sip_path) "fpga_built_in_clk_sim/fpga_built_in_clk.vo"]
