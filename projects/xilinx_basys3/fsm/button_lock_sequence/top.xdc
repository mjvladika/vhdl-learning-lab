set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports reset]

set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports btn_a]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports btn_b]
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports btn_c]

set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports unlocked]

set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports ajar_led]
set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports second_led]
set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports first_led]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports locked_led]