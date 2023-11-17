//`timescale 1ns

module tb;

   parameter NBIT = 9;   

   wire CLK_i;
   wire RST_n_i;
   wire [NBIT-1:0] DIN3k_i;
   wire [NBIT-1:0] DIN3k1_i;
   wire [NBIT-1:0] DIN3k2_i;   
   wire VIN_i;
   wire [NBIT-1:0] B [8:0];
   wire [NBIT-1:0] DOUT3k_i;
   wire [NBIT-1:0] DOUT3k1_i;
   wire [NBIT-1:0] DOUT3k2_i;   
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
              .CLK(CLK_i),
              .RST_n(RST_n_i));

   data_maker #(.NBIT(NBIT)) SM(.CLK(CLK_i),
                                .RST_n(RST_n_i),
                                .VOUT(VIN_i),
                                .DOUT3k(DIN3k_i),
                                .DOUT3k1(DIN3k1_i),
                                .DOUT3k2(DIN3k2_i),
                                .B0(B[0]),
                                .B1(B[1]),
                                .B2(B[2]),
                                .B3(B[3]),
                                .B4(B[4]),
                                .B5(B[5]),
                                .B6(B[6]),
                                .B7(B[7]),
                                .B8(B[8]),
                                .END_SIM(END_SIM_i));

   FIR_FILTER_ADV UUT(.CLK(CLK_i),
                      .RST_n(RST_n_i),
                      .DIN3k(DIN3k_i),
                      .DIN3k1(DIN3k1_i),
                      .DIN3k2(DIN3k2_i),
                      .VIN(VIN_i),
                      .B(B),
                      .DOUT3k(DOUT3k_i),
                      .DOUT3k1(DOUT3k1_i),
                      .DOUT3k2(DOUT3k2_i),
                      .VOUT(VOUT_i));

   data_sink #(.NBIT(NBIT)) DS(.CLK(CLK_i),
                               .RST_n(RST_n_i),
                               .VIN(VOUT_i),
                               .DIN3k(DOUT3k_i),
                               .DIN3k1(DOUT3k1_i),
                               .DIN3k2(DOUT3k2_i));

endmodule

		   
