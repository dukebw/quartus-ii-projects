module de2_115_top(
    // Clock Input
    input wire CLOCK_50,        // 50 MHz clock input, 3.3V
    input wire CLOCK2_50,       // 50 MHz clock input, 3.3V
    input wire CLOCK3_50,       // 50 MHz clock input, 3.3V
    input wire ENETCLK_25,      // Ethernet clock source, 3.3V

    // SMA external clocks
    input wire SMA_CLKIN,       // External (SMA) clock input, 3.3V
    output wire SMA_CLKOUT,     // External (SMA) clock output, depending on JP6

    // LED
    output wire [8:0] LEDG,     // LED Green, 2.5V
    output wire [17:0] LEDR,    // LED Red, 2.5V

    // Push-buttons
    input wire [3:0] KEY,       // Push-button, depending on JP7

    // Slide switches
    input wire [17:0] SW,       // Slide-switch, depending on JP7

    // Seven-segment
    output wire [6:0] HEX0,     // Seven-segment digit 0, 2.5V
    output wire [6:0] HEX1,     // Seven-segment digit 1, 2.5V
    output wire [6:0] HEX2,     // Seven-segment digit 2, 2.5V
    output wire [6:0] HEX3,     // Seven-segment digit 3, 2.5V
    output wire [6:0] HEX4,     // Seven-segment digit 4, 2.5V
    output wire [6:0] HEX5,     // Seven-segment digit 5, 2.5V
    output wire [6:0] HEX6,     // Seven-segment digit 6, 2.5V
    output wire [6:0] HEX7,     // Seven-segment digit 7, 2.5V

    // LCD
    output wire LCD_BLON,       // LCD Back Light ON/OFF, 3.3V
    inout wire [7:0] LCD_DATA,  // LCD Data, 3.3V
    output wire LCD_EN,         // LCD Enable, 3.3V
    output wire LCD_ON,         // LCD Power ON/OFF, 3.3V
    output wire LCD_RS,         // LCD Command/Data Select, 0 = Command, 1 = Data, 3.3V
    output wire LCD_RW,         // LCD Read/Write Select, 0 = Write, 1 = Read, 3.3V

    // RS232
    output wire UART_CTS,       // UART Clear to Send, 3.3V
    input wire UART_RTS,        // UART Request to Send, 3.3V
    input wire UART_RXD,        // UART Receiver, 3.3V
    output wire UART_TXD,       // UART Transmitter, 3.3V

    // PS/2
    inout wire PS2_CLK,         // PS/2 Clock, 3.3V
    inout wire PS2_DAT,         // PS/2 Data, 3.3V
    inout wire PS2_CLK2,        // PS/2 Clock (Reserved for second PS/2 device), 3.3V
    inout wire PS2_DAT2,        // PS/2 data (Reserved for second PS/2 device), 3.3V

    // SD-Card
    output wire SD_CLK,         // SD Clock, 3.3V
    inout wire SD_CMD,          // SD Command Line, 3.3V
    inout wire [3:0] SD_DAT,    // SD Data, 3.3V
    input wire SD_WP_N,         // SD Write Protect

    // VGA
    output wire [7:0] VGA_R,    // VGA Red, 3.3V
    output wire [7:0] VGA_G,    // VGA Green, 3.3V
    output wire [7:0] VGA_B,    // VGA Blue, 3.3V
    output wire VGA_BLANK_N,    // VGA BLANK, 3.3V
    output wire VGA_CLK,        // VGA Clock, 3.3V
    output wire VGA_HS,         // VGA H_SYNC, 3.3V
    output wire VGA_VS,         // VGA V_SYNC, 3.3V
    output wire VGA_SYNC_N,     // VGA SYNC, 3.3V

    // Audio CODEC
    input wire AUD_ADCDAT,      // Audio CODEC ADC Data, 3.3V
    inout wire AUD_ADCLRCK,     // Audio CODEC ADC LR Clock, 3.3V
    output wire AUD_BCLK,       // Audio CODEC Bit-Stream Clock, 3.3V
    output wire AUD_DACDAT,     // Audio CODEC DAC Data, 3.3V
    output wire AUD_DACLRCK,    // Audio CODEC DAC LR Clock, 3.3V
    output wire AUD_XCK,        // Audio CODEC Chip Clock, 3.3V

    // I2C for EEPROM
    output wire EEP_I2C_SCLK,   // EEPROM Clock, 3.3V
    inout wire EEP_I2C_SDAT,    // EEPROM Data, 3.3V

    // I2C for Audio and Tv-Decode
    output wire I2C_SCLK,       // I2C Clock, 3.3V
    inout wire I2C_SDAT,        // I2C Data, 3.3V

    // Fast Ethernet 0
    output wire ENET0_GTX_CLK,  // GMII Transmit Clock 1, 2.5V
    input wire ENET0_INT_N,     // Interrupt open drain output 1, 2.5V
    output wire ENET0_MDC,      // Management data clock reference 1, 2.5V
    input wire ENET0_MDIO,      // Management data 1
    output wire ENET0_RST_N,    // Hardware reset signal 1
    input wire ENET0_RX_CLK,    // GMII and MII receive clock 1
    input wire ENET0_RX_COL,    // GMII and MII collision 1
    input wire ENET0_RX_CRS,    // GMII and MII carrier sense 1
    input wire [3:0] ENET0_RX_DATA, // GMII and MII receive data 1
    input wire ENET0_RX_DV,     // GMII and MII receive data valid 1
    input wire ENET0_RX_ER,     // GMII and MII receive error 1
    input wire ENET0_TX_CLK,    // MII transmit clock 1
    output wire [3:0] ENET0_TX_DATA, // MII transmit data
    output wire ENET0_TX_EN,    // GMII and MII transmit enable 1
    output wire ENET0_TX_ER,    // GMII and MII transmit error 1
    input wire ENET0_LINK100,   // Parallel LED output of 100BASE-TX link 1

    // Fast Ethernet 1
    output wire ENET1_GTX_CLK,
    input wire ENET1_INT_N,
    output wire ENET1_MDC,
    input wire ENET1_MDIO,
    output wire ENET1_RST_N,
    input wire ENET1_RX_CLK,
    input wire ENET1_RX_COL,
    input wire ENET1_RX_CRS,
    input wire [3:0] ENET1_RX_DATA,
    input wire ENET1_RX_DV,
    input wire ENET1_RX_ER,
    input wire ENET1_TX_CLK,
    output wire [3:0] ENET1_TX_DATA,
    output wire ENET1_TX_EN,
    output wire ENET1_TX_ER,
    input wire ENET1_LINK100,

    // TV Decoder 1
    input wire TD_CLK27,        // TV Decoder Clock Input
    input wire [7:0] TD_DATA,   // TV Decoder Data
    input wire TD_HS,           // TV Decoder H_SYNC
    output wire TD_RESET_N,     // TV Decoder Reset
    input wire TD_VS,           // TV Decoder V_SYNC

    // USB (ISP1362) OTG Controller
    inout wire [15:0] OTG_DATA, // ISP1362 Data
    output wire [1:0] OTG_ADDR, // ISP1362 Address
    output wire OTG_CS_N,       // ISP1362 Chip Select
    output wire OTG_WR_N,       // ISP1362 Write
    output wire OTG_RD_N,       // ISP1362 Read
    input wire OTG_INT,         // ISP1362 Interrupt
    output wire OTG_RST_N,      // ISP1362 Reset

    // IR Receiver
    input wire IRDA_RXD,        // IR Receiver

    // SDRAM
    output wire [12:0] DRAM_ADDR, // SDRAM Address
    output wire [1:0] DRAM_BA,  // SDRAM Bank Address
    output wire DRAM_CAS_N,     // SDRAM Column Address Strobe
    output wire DRAM_CKE,       // SDRAM Clock Enable
    output wire DRAM_CLK,       // SDRAM Clock
    output wire DRAM_CS_N,      // SDRAM Chip Select
    inout wire [31:0] DRAM_DQ,  // SDRAM Data
    output wire [3:0] DRAM_DQM, // SDRAM byte Data Mask
    output wire DRAM_RAS_N,     // SDRAM Row Address Strobe
    output wire DRAM_WE_N,      // SDRAM Write Enable

    // SRAM
    output wire [19:0] SRAM_ADDR, // SRAM Address
    output wire SRAM_CE_N,      // SRAM Chip Select
    inout wire [15:0] SRAM_DQ,  // SRAM Data
    output wire SRAM_LB_N,      // SRAM Lower Byte Strobe
    output wire SRAM_OE_N,      // SRAM Output Enable
    output wire SRAM_UB_N,      // SRAM Higher Byte Strobe
    output wire SRAM_WE_N,      // SRAM Write Enable

    // Flash
    output wire [22:0] FL_ADDR, // Flash address
    output wire FL_CE_N,        // Flash Chip Enable
    inout wire [7:0] FL_DQ,     // Flash Data
    output wire FL_OE_N,        // Flash Output Enable
    output wire FL_RST_N,       // Flash Reset
    input wire FL_RY,           // Flash Ready/Busy output
    output wire FL_WE_N,        // Flash Write Enable
    output wire FL_WP_N,        // Flash Write Protect/Programming Acceleration

    // GPIO
    inout wire [35:0] GPIO,

    // HSMC (LVDS) Connector
    //input             HSMC_CLKIN_N1,
    //input             HSMC_CLKIN_N2,
    /* input wire HSMC_CLKIN_P1, */
    /* input wire HSMC_CLKIN_P2, */
    /* input wire HSMC_CLKIN0, */
    //output             HSMC_CLKOUT_N1,
    //output             HSMC_CLKOUT_N2,
    /* output wire HSMC_CLKOUT_P1, */
    /* output wire HSMC_CLKOUT_P2, */
    /* output wire HSMC_CLKOUT0, */
    /* inout wire [3:0] HSMC_D, */
    //input     [16:0] HSMC_RX_D_N,
    /* input wire [16:0] HSMC_RX_D_P, */
    //output     [16:0] HSMC_TX_D_N,
    /* output wire [16:0] HSMC_TX_D_P, */

    // Extend IO
    inout wire [6:0] EX_IO
);

    // Turn off all displays.
    assign HEX0 = 7'h7F;
    assign HEX1 = 7'h7F;
    assign HEX2 = 7'h7F;
    assign HEX3 = 7'h7F;
    assign HEX4 = 7'h7F;
    assign HEX5 = 7'h7F;
    assign HEX6 = 7'h7F;
    assign HEX7 = 7'h7F;
    assign LEDR = 18'h0;
    assign LEDG = 9'h0;

    // Set all GPIO to tri-state.
    assign GPIO = 36'hzzzzzzzzz;

    // Initialize audio codec
    assign AUD_ADCLRCK = 1'bz;     

    //Disable VGA.
    assign VGA_R     = 8'h0;
    assign VGA_G     = 8'h0;
    assign VGA_B     = 8'h0;
    assign VGA_BLANK_N = 1'b0;
    assign VGA_CLK   = 1'b0;
    assign VGA_HS    = 1'b0;
    assign VGA_VS    = 1'b0;
    assign VGA_SYNC_N = 1'b0;

    // Disable ethernet.
    assign ENET0_GTX_CLK = 1'b0;
    assign ENET0_MDC = 1'b0;
    assign ENET0_RST_N = 1'b0;
    assign ENET0_TX_DATA = 4'b0;
    assign ENET0_TX_EN = 1'b0;
    assign ENET0_TX_ER = 1'b0;    // GMII and MII transmit error 1

    assign ENET1_GTX_CLK = 1'b0;
    assign ENET1_MDC = 1'b0;
    assign ENET1_RST_N = 1'b0;
    assign ENET1_TX_DATA = 4'b0;
    assign ENET1_TX_EN = 1'b0;
    assign ENET1_TX_ER = 1'b0;    // GMII and MII transmit error 1

    // Disable DRAM.
    assign DRAM_ADDR  = 12'h0;
    assign DRAM_BA    = 1'b0;
    assign DRAM_CAS_N = 1'b1;
    assign DRAM_CKE   = 1'b0;
    assign DRAM_CLK   = 1'b0;
    assign DRAM_CS_N  = 1'b1;
    assign DRAM_DQ    = 32'hzzzzzzzz;
    assign DRAM_DQM   = 4'hF;
    assign DRAM_RAS_N = 1'b1;
    assign DRAM_WE_N  = 1'b1;

    // TODO(brendan): Disable ethernet?

    // Disable flash.
    assign FL_ADDR  = 22'h0;
    assign FL_CE_N  = 1'b1;
    assign FL_DQ    = 8'hzz;
    assign FL_OE_N  = 1'b1;
    assign FL_RST_N = 1'b1;
    assign FL_WE_N  = 1'b1;
    assign FL_WP_N = 1'b0;

    // Disable LCD.
    assign LCD_BLON = 1'b0;
    assign LCD_DATA = 8'hzz;
    assign LCD_EN   = 1'b0;
    assign LCD_ON   = 1'b0;
    assign LCD_RS   = 1'b0;
    assign LCD_RW   = 1'b0;

    // Disable OTG.
    assign OTG_DATA    = 16'hzzzz;
    assign OTG_ADDR    = 2'h0;
    assign OTG_CS_N    = 1'b1;
    assign OTG_RD_N    = 1'b1;
    assign OTG_RST_N   = 1'b1;
    assign OTG_WR_N    = 1'b1;

    // Disable PS2/.
    assign PS2_CLK = 1'bz;
    assign PS2_DAT = 1'bz;
    assign PS2_CLK2 = 1'bz;
    assign PS2_DAT2 = 1'bz;

    // Disable SDRAM.
    assign SD_DAT = 4'bz;
    assign SD_CMD = 1'bz;     
    assign SD_CLK = 1'bz;     

    // Disable SRAM.
    assign SRAM_ADDR = 18'h0;
    assign SRAM_CE_N = 1'b1;
    assign SRAM_DQ   = 16'hzzzz;
    assign SRAM_LB_N = 1'b1;
    assign SRAM_OE_N = 1'b1;
    assign SRAM_UB_N = 1'b1;
    assign SRAM_WE_N = 1'b1;

    // Disable UART.
    assign UART_TXD = 1'b0;
    assign UART_CTS = 1'b0;

    assign TD_RESET_N = 1'b0;

    assign EEP_I2C_SDAT = 1'bz;
    assign EEP_I2C_SCLK = 1'bz;      

    assign SMA_CLKOUT = 1'b0;

    assign EX_IO = 7'bzzzzzzz;

    wire delayed_reset;
    wire audio_clk;

    // Initialize audio codec
    assign AUD_XCK = audio_clk;

    Reset_Delay reset_delay_inst(.clock_i(CLOCK_50),
                                 .reset_o(delayed_reset));

    audio_clk_pll audio_clk_pll_inst(.areset(~delayed_reset),
                                     .inclk0(CLOCK_50),
                                     .c0(audio_clk));

    I2C_AV_Config i2c_av_config_inst(.iCLK(CLOCK_50),
                                     .iRST_N(KEY[0]),
                                     .I2C_SCLK(I2C_SCLK),
                                     .I2C_SDAT(I2C_SDAT));

    AUDIO_DAC_ADC audio_dac_adc_inst(.oAUD_BCK(AUD_BCLK),
                                     .oAUD_DATA(AUD_DACDAT),
                                     .oAUD_LRCK(AUD_DACLRCK),
                                     .oAUD_inL(),
                                     .oAUD_inR(),
                                     .iAUD_ADCDAT(AUD_ADCDAT),
                                     .iAUD_extR(v1[17:2]),
                                     .iAUD_extL(v2[17:2]),
                                     // Control Signals
                                     .iCLK_18_4(audio_clk),
                                     .iRST_N(delayed_reset));

    wire signed [17:0] a1;
    wire signed [17:0] a2;
    wire signed [17:0] b;
    wire signed [17:0] c;
    wire signed [17:0] d;
    wire signed [17:0] I1;
    wire signed [17:0] I2;
    wire signed [17:0] v1;
    wire signed [17:0] v2;
    wire signed [17:0] u1;
    wire spike1;
    wire spike2;

    reg [11:0] count;
    wire neuron_clock;
    wire neuron_reset;

    // Clock divider
    always @(posedge CLOCK_50) begin
        count <= count + 12'b1;
    end

    assign neuron_clock = (count == 0);

    assign I1 = {2'h0, SW[15:0]};
    assign I2 = {2'h0, SW[15:0]};

    assign neuron_reset = ~KEY[3];

    //burster parameters
    assign a1 = 18'sh0_051E ; // 0.02
    assign b = 18'sh0_3333 ; // 0.2
    assign c = 18'sh3_8000 ; // -0.5
    assign d = 18'sh0_051E ; // 0.02
    assign a2 = 18'sh0_041E ; // slightly lower than 0.02

    iz_neuron burst1(.v_membrane_o(v1),
                     .membrane_recovery_o(u1),
                     .spike_o(spike1),
                     .a(a1),
                     .b(b),
                     .c(c),
                     .d(d),
                     .I(I1 - (spike2 ? 18'h0_8000 : 0)),
                     .clock_i(neuron_clock),
                     .reset_i(neuron_reset));

    iz_neuron burst2(.v_membrane_o(v2),
                     .membrane_recovery_o(),
                     .spike_o(spike2),
                     .a(a2),
                     .b(b),
                     .c(c),
                     .d(d),
                     .I(I2 - (spike1 ? 18'h0_8000 : 0)),
                     .clock_i(neuron_clock),
                     .reset_i(neuron_reset));

endmodule

//////////////////////////////////////////////////
//// signed mult of 2.16 format 2'comp////////////
//////////////////////////////////////////////////
module signed_mult(output wire signed [17:0] product_o,
                   input wire signed [17:0] a_i,
                   input wire signed [17:0] b_i);

    wire signed [35:0] raw_product;

    assign raw_product = (a_i*b_i);
    assign product_o = {raw_product[35], raw_product[32:16]};

endmodule

module Reset_Delay(input wire clock_i,
                   output wire reset_o);

    reg [19:0] count;

    assign reset_o = (count == 20'hFFFFF);

    always @(posedge clock_i) begin
        if (count != 20'hFFFFF) begin
            count <= count + 20'b1;
        end
    end

endmodule

module iz_neuron(output wire signed [17:0] v_membrane_o,
                 output wire signed [17:0] membrane_recovery_o,
                 output reg spike_o,
                 input wire signed [17:0] a,
                 input wire signed [17:0] b,
                 input wire signed [17:0] c,
                 input wire signed [17:0] d,
                 input wire signed [17:0] I,
                 input wire clock_i,
                 input wire reset_i);

    wire signed [17:0] p;
    wire signed [17:0] c14;
    reg signed [17:0] v1;
    reg signed [17:0] u1;
    wire signed [17:0] v1_new;
    wire signed [17:0] u1_new;
    wire signed [17:0] v1xv1;
    wire signed [17:0] v1xb;
    wire signed [17:0] du1;
    wire signed [17:0] u1_reset;

    assign p = 18'sh0_4CCC;
    assign c14 = 18'sh1_6666;

    assign v_membrane_o = v1;
    assign membrane_recovery_o = u1;

    always @(posedge clock_i) begin
        if (reset_i) begin
            v1 <= 18'sh3_4CCD;
            u1 <= 18'sh3_CCCD;
            spike_o <= 0;
        end
        else begin
            if (v1 > p) begin
                v1 <= c;
                u1 <= u1_reset;
                spike_o <= 1;
            end
            else begin
                v1 <= v1_new;
                u1 <= u1_new;
                spike_o <= 0;
            end
        end
    end

    // dt = 1/16 or (1 >> 4)
    // v1(n+1) = v1(n) + (v1(n)^2) + 5/4*v1(n) +1.40/4 - u1(n)/4 + I/4)/4
    signed_mult v1sq(v1xv1, v1, v1);
    assign v1_new = v1 + ((v1xv1 + v1 + (v1 >>> 2) + (c14 >>> 2) - (u1 >>> 2) + (I >>> 2)) >>> 2);

    // u1(n+1) = u1 + dt*a*(b*v1(n) - u1(n))
    signed_mult bb(v1xb, v1, b);
    signed_mult aa(du1, (v1xb - u1), a);
    assign u1_new = u1 + (du1 >>> 4);
    assign u1_reset = u1 + d;

endmodule
