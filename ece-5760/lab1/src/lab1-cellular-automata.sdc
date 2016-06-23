derive_pll_clocks
derive_clock_uncertainty
create_clock -name de2_clock_50 -period 20.0ns [get_ports CLOCK_50]
create_clock -name de2_vga_clock -period 39.721ns [get_ports VGA_CLK]
set_clock_groups -asynchronous \
    -group {de2_clock_50} \
    -group {de2_vga_clock \
            vga_clk_pll_inst|altpll_component|auto_generated|pll1|clk[0]} \
    -group {altera_reserved_tck}
