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
                                     .iAUD_extL(sine_out),
                                     // Control Signals
                                     .iCLK_18_4(audio_clk),
                                     .iRST_N(delayed_reset));

    reg signed [17:0] v1;
    reg signed [17:0] v2;
    wire signed [17:0] v1_new;
    wire signed [17:0] v2_new;
    wire signed [17:0] v1xK_M;
    wire signed [17:0] v2xD_M;
    wire signed [17:0] sine_input;
    reg [4:0] count;

    // Sine wave generator
    reg [31:0] dds_accum;
    reg [10:0] dds_incr_count;
    reg [31:0] dds_incr;
    wire signed [15:0] sine_out;

    always @ (posedge CLOCK_50) begin
        if (KEY[3] == 0) begin
            dds_incr <= {14'b0, SW[17:0]};
        end
        else if (KEY[0] == 0) begin
            if (dds_incr_count == 0) begin
                dds_incr <= dds_incr + 32'b1;
            end

            dds_incr_count <= dds_incr_count + 11'b1;
        end

        dds_accum <= dds_accum + dds_incr;
    end

    sync_rom sine_table_inst(.sine_o(sine_out),
                             .clock_i(CLOCK_50),
                             .address_i(dds_accum[31:24]));

    always @(posedge CLOCK_50) begin
        count <= count + 5'b1;

        if (KEY[3] == 0) begin
            v1 <= 18'h0_0000;
            v2 <= 18'h1_0000;
        end
        else if (count == 0) begin
            v1 <= v1_new;
            v2 <= v2_new;
        end
    end

    // dt = (2 >> 9)
    // v1(n + 1) = v1(n) + dt*v2(n)
    assign v1_new = v1 + (v2 >>> 9);

    // v2(n + 1) = v2(n) + dt*(-k/m*v1(n) - d/m*v2(n))
    signed_mult K_M(v1xK_M, v1, 18'h1_0000);
    signed_mult D_M(v2xD_M, v2, 18'h0_0800);
    signed_mult sine_gain(.product_o(sine_input),
                          .a_i({sine_out[15], sine_out[15], sine_out}),
                          .b_i(18'h0_4000));

    assign v2_new = (v2 - ((v1xK_M + v2xD_M) >>> 9) + (sine_input >>> 9));

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

module sync_rom(output reg [15:0] sine_o,
                input wire clock_i,
                input wire [7:0] address_i);

    always @(posedge clock_i) begin
        case (address_i)
            8'h00: sine_o <= 16'h0000;
            8'h01: sine_o <= 16'h0192;
            8'h02: sine_o <= 16'h0323;
            8'h03: sine_o <= 16'h04b5;
            8'h04: sine_o <= 16'h0645;
            8'h05: sine_o <= 16'h07d5;
            8'h06: sine_o <= 16'h0963;
            8'h07: sine_o <= 16'h0af0;
            8'h08: sine_o <= 16'h0c7c;
            8'h09: sine_o <= 16'h0e05;
            8'h0a: sine_o <= 16'h0f8c;
            8'h0b: sine_o <= 16'h1111;
            8'h0c: sine_o <= 16'h1293;
            8'h0d: sine_o <= 16'h1413;
            8'h0e: sine_o <= 16'h158f;
            8'h0f: sine_o <= 16'h1708;
            8'h10: sine_o <= 16'h187d;
            8'h11: sine_o <= 16'h19ef;
            8'h12: sine_o <= 16'h1b5c;
            8'h13: sine_o <= 16'h1cc5;
            8'h14: sine_o <= 16'h1e2a;
            8'h15: sine_o <= 16'h1f8b;
            8'h16: sine_o <= 16'h20e6;
            8'h17: sine_o <= 16'h223c;
            8'h18: sine_o <= 16'h238d;
            8'h19: sine_o <= 16'h24d9;
            8'h1a: sine_o <= 16'h261f;
            8'h1b: sine_o <= 16'h275f;
            8'h1c: sine_o <= 16'h2899;
            8'h1d: sine_o <= 16'h29cc;
            8'h1e: sine_o <= 16'h2afa;
            8'h1f: sine_o <= 16'h2c20;
            8'h20: sine_o <= 16'h2d40;
            8'h21: sine_o <= 16'h2e59;
            8'h22: sine_o <= 16'h2f6b;
            8'h23: sine_o <= 16'h3075;
            8'h24: sine_o <= 16'h3178;
            8'h25: sine_o <= 16'h3273;
            8'h26: sine_o <= 16'h3366;
            8'h27: sine_o <= 16'h3452;
            8'h28: sine_o <= 16'h3535;
            8'h29: sine_o <= 16'h3611;
            8'h2a: sine_o <= 16'h36e4;
            8'h2b: sine_o <= 16'h37ae;
            8'h2c: sine_o <= 16'h3870;
            8'h2d: sine_o <= 16'h3929;
            8'h2e: sine_o <= 16'h39da;
            8'h2f: sine_o <= 16'h3a81;
            8'h30: sine_o <= 16'h3b1f;
            8'h31: sine_o <= 16'h3bb5;
            8'h32: sine_o <= 16'h3c41;
            8'h33: sine_o <= 16'h3cc4;
            8'h34: sine_o <= 16'h3d3d;
            8'h35: sine_o <= 16'h3dad;
            8'h36: sine_o <= 16'h3e14;
            8'h37: sine_o <= 16'h3e70;
            8'h38: sine_o <= 16'h3ec4;
            8'h39: sine_o <= 16'h3f0d;
            8'h3a: sine_o <= 16'h3f4d;
            8'h3b: sine_o <= 16'h3f83;
            8'h3c: sine_o <= 16'h3fb0;
            8'h3d: sine_o <= 16'h3fd2;
            8'h3e: sine_o <= 16'h3feb;
            8'h3f: sine_o <= 16'h3ffa;
            8'h40: sine_o <= 16'h3fff;
            8'h41: sine_o <= 16'h3ffa;
            8'h42: sine_o <= 16'h3feb;
            8'h43: sine_o <= 16'h3fd2;
            8'h44: sine_o <= 16'h3fb0;
            8'h45: sine_o <= 16'h3f83;
            8'h46: sine_o <= 16'h3f4d;
            8'h47: sine_o <= 16'h3f0d;
            8'h48: sine_o <= 16'h3ec4;
            8'h49: sine_o <= 16'h3e70;
            8'h4a: sine_o <= 16'h3e14;
            8'h4b: sine_o <= 16'h3dad;
            8'h4c: sine_o <= 16'h3d3d;
            8'h4d: sine_o <= 16'h3cc4;
            8'h4e: sine_o <= 16'h3c41;
            8'h4f: sine_o <= 16'h3bb5;
            8'h50: sine_o <= 16'h3b1f;
            8'h51: sine_o <= 16'h3a81;
            8'h52: sine_o <= 16'h39da;
            8'h53: sine_o <= 16'h3929;
            8'h54: sine_o <= 16'h3870;
            8'h55: sine_o <= 16'h37ae;
            8'h56: sine_o <= 16'h36e4;
            8'h57: sine_o <= 16'h3611;
            8'h58: sine_o <= 16'h3535;
            8'h59: sine_o <= 16'h3452;
            8'h5a: sine_o <= 16'h3366;
            8'h5b: sine_o <= 16'h3273;
            8'h5c: sine_o <= 16'h3178;
            8'h5d: sine_o <= 16'h3075;
            8'h5e: sine_o <= 16'h2f6b;
            8'h5f: sine_o <= 16'h2e59;
            8'h60: sine_o <= 16'h2d40;
            8'h61: sine_o <= 16'h2c20;
            8'h62: sine_o <= 16'h2afa;
            8'h63: sine_o <= 16'h29cc;
            8'h64: sine_o <= 16'h2899;
            8'h65: sine_o <= 16'h275f;
            8'h66: sine_o <= 16'h261f;
            8'h67: sine_o <= 16'h24d9;
            8'h68: sine_o <= 16'h238d;
            8'h69: sine_o <= 16'h223c;
            8'h6a: sine_o <= 16'h20e6;
            8'h6b: sine_o <= 16'h1f8b;
            8'h6c: sine_o <= 16'h1e2a;
            8'h6d: sine_o <= 16'h1cc5;
            8'h6e: sine_o <= 16'h1b5c;
            8'h6f: sine_o <= 16'h19ef;
            8'h70: sine_o <= 16'h187d;
            8'h71: sine_o <= 16'h1708;
            8'h72: sine_o <= 16'h158f;
            8'h73: sine_o <= 16'h1413;
            8'h74: sine_o <= 16'h1293;
            8'h75: sine_o <= 16'h1111;
            8'h76: sine_o <= 16'h0f8c;
            8'h77: sine_o <= 16'h0e05;
            8'h78: sine_o <= 16'h0c7c;
            8'h79: sine_o <= 16'h0af0;
            8'h7a: sine_o <= 16'h0963;
            8'h7b: sine_o <= 16'h07d5;
            8'h7c: sine_o <= 16'h0645;
            8'h7d: sine_o <= 16'h04b5;
            8'h7e: sine_o <= 16'h0323;
            8'h7f: sine_o <= 16'h0192;
            8'h80: sine_o <= 16'h0000;
            8'h81: sine_o <= 16'hfe6e;
            8'h82: sine_o <= 16'hfcdd;
            8'h83: sine_o <= 16'hfb4b;
            8'h84: sine_o <= 16'hf9bb;
            8'h85: sine_o <= 16'hf82b;
            8'h86: sine_o <= 16'hf69d;
            8'h87: sine_o <= 16'hf510;
            8'h88: sine_o <= 16'hf384;
            8'h89: sine_o <= 16'hf1fb;
            8'h8a: sine_o <= 16'hf074;
            8'h8b: sine_o <= 16'heeef;
            8'h8c: sine_o <= 16'hed6d;
            8'h8d: sine_o <= 16'hebed;
            8'h8e: sine_o <= 16'hea71;
            8'h8f: sine_o <= 16'he8f8;
            8'h90: sine_o <= 16'he783;
            8'h91: sine_o <= 16'he611;
            8'h92: sine_o <= 16'he4a4;
            8'h93: sine_o <= 16'he33b;
            8'h94: sine_o <= 16'he1d6;
            8'h95: sine_o <= 16'he075;
            8'h96: sine_o <= 16'hdf1a;
            8'h97: sine_o <= 16'hddc4;
            8'h98: sine_o <= 16'hdc73;
            8'h99: sine_o <= 16'hdb27;
            8'h9a: sine_o <= 16'hd9e1;
            8'h9b: sine_o <= 16'hd8a1;
            8'h9c: sine_o <= 16'hd767;
            8'h9d: sine_o <= 16'hd634;
            8'h9e: sine_o <= 16'hd506;
            8'h9f: sine_o <= 16'hd3e0;
            8'ha0: sine_o <= 16'hd2c0;
            8'ha1: sine_o <= 16'hd1a7;
            8'ha2: sine_o <= 16'hd095;
            8'ha3: sine_o <= 16'hcf8b;
            8'ha4: sine_o <= 16'hce88;
            8'ha5: sine_o <= 16'hcd8d;
            8'ha6: sine_o <= 16'hcc9a;
            8'ha7: sine_o <= 16'hcbae;
            8'ha8: sine_o <= 16'hcacb;
            8'ha9: sine_o <= 16'hc9ef;
            8'haa: sine_o <= 16'hc91c;
            8'hab: sine_o <= 16'hc852;
            8'hac: sine_o <= 16'hc790;
            8'had: sine_o <= 16'hc6d7;
            8'hae: sine_o <= 16'hc626;
            8'haf: sine_o <= 16'hc57f;
            8'hb0: sine_o <= 16'hc4e1;
            8'hb1: sine_o <= 16'hc44b;
            8'hb2: sine_o <= 16'hc3bf;
            8'hb3: sine_o <= 16'hc33c;
            8'hb4: sine_o <= 16'hc2c3;
            8'hb5: sine_o <= 16'hc253;
            8'hb6: sine_o <= 16'hc1ec;
            8'hb7: sine_o <= 16'hc190;
            8'hb8: sine_o <= 16'hc13c;
            8'hb9: sine_o <= 16'hc0f3;
            8'hba: sine_o <= 16'hc0b3;
            8'hbb: sine_o <= 16'hc07d;
            8'hbc: sine_o <= 16'hc050;
            8'hbd: sine_o <= 16'hc02e;
            8'hbe: sine_o <= 16'hc015;
            8'hbf: sine_o <= 16'hc006;
            8'hc0: sine_o <= 16'hc001;
            8'hc1: sine_o <= 16'hc006;
            8'hc2: sine_o <= 16'hc015;
            8'hc3: sine_o <= 16'hc02e;
            8'hc4: sine_o <= 16'hc050;
            8'hc5: sine_o <= 16'hc07d;
            8'hc6: sine_o <= 16'hc0b3;
            8'hc7: sine_o <= 16'hc0f3;
            8'hc8: sine_o <= 16'hc13c;
            8'hc9: sine_o <= 16'hc190;
            8'hca: sine_o <= 16'hc1ec;
            8'hcb: sine_o <= 16'hc253;
            8'hcc: sine_o <= 16'hc2c3;
            8'hcd: sine_o <= 16'hc33c;
            8'hce: sine_o <= 16'hc3bf;
            8'hcf: sine_o <= 16'hc44b;
            8'hd0: sine_o <= 16'hc4e1;
            8'hd1: sine_o <= 16'hc57f;
            8'hd2: sine_o <= 16'hc626;
            8'hd3: sine_o <= 16'hc6d7;
            8'hd4: sine_o <= 16'hc790;
            8'hd5: sine_o <= 16'hc852;
            8'hd6: sine_o <= 16'hc91c;
            8'hd7: sine_o <= 16'hc9ef;
            8'hd8: sine_o <= 16'hcacb;
            8'hd9: sine_o <= 16'hcbae;
            8'hda: sine_o <= 16'hcc9a;
            8'hdb: sine_o <= 16'hcd8d;
            8'hdc: sine_o <= 16'hce88;
            8'hdd: sine_o <= 16'hcf8b;
            8'hde: sine_o <= 16'hd095;
            8'hdf: sine_o <= 16'hd1a7;
            8'he0: sine_o <= 16'hd2c0;
            8'he1: sine_o <= 16'hd3e0;
            8'he2: sine_o <= 16'hd506;
            8'he3: sine_o <= 16'hd634;
            8'he4: sine_o <= 16'hd767;
            8'he5: sine_o <= 16'hd8a1;
            8'he6: sine_o <= 16'hd9e1;
            8'he7: sine_o <= 16'hdb27;
            8'he8: sine_o <= 16'hdc73;
            8'he9: sine_o <= 16'hddc4;
            8'hea: sine_o <= 16'hdf1a;
            8'heb: sine_o <= 16'he075;
            8'hec: sine_o <= 16'he1d6;
            8'hed: sine_o <= 16'he33b;
            8'hee: sine_o <= 16'he4a4;
            8'hef: sine_o <= 16'he611;
            8'hf0: sine_o <= 16'he783;
            8'hf1: sine_o <= 16'he8f8;
            8'hf2: sine_o <= 16'hea71;
            8'hf3: sine_o <= 16'hebed;
            8'hf4: sine_o <= 16'hed6d;
            8'hf5: sine_o <= 16'heeef;
            8'hf6: sine_o <= 16'hf074;
            8'hf7: sine_o <= 16'hf1fb;
            8'hf8: sine_o <= 16'hf384;
            8'hf9: sine_o <= 16'hf510;
            8'hfa: sine_o <= 16'hf69d;
            8'hfb: sine_o <= 16'hf82b;
            8'hfc: sine_o <= 16'hf9bb;
            8'hfd: sine_o <= 16'hfb4b;
            8'hfe: sine_o <= 16'hfcdd;
            8'hff: sine_o <= 16'hfe6e;
            default: sine_o <= 16'h0;
        endcase
    end
endmodule
