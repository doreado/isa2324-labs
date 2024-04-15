import fpnew_pkg::*;

module DUT #(
    parameter fpnew_pkg::fpu_features_t       Features       = fpnew_pkg::RV16F,         
    parameter fpnew_pkg::fpu_implementation_t Implementation = fpnew_pkg::ISA_PIPE,
    parameter type                            TagType        = logic,
    // Do not change
    localparam int unsigned WIDTH        = Features.Width,
    localparam int unsigned NUM_OPERANDS = 3
) (dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [2:0] {INITIAL,WAIT, WAIT_1, WAIT_2, SEND} state);
    
    wire clk_i;
    wire rst_ni;
    var [NUM_OPERANDS-1:0][WIDTH-1:0] operands_i;
    var fpnew_pkg::roundmode_e rnd_mode_i;
    var fpnew_pkg::operation_e op_i;
    var logic op_mod_i;
    var fpnew_pkg::fp_format_e src_fmt_i;
    var fpnew_pkg::fp_format_e dst_fmt_i;
    var fpnew_pkg::int_format_e int_fmt_i;
    var logic vectorial_op_i;
    var TagType tag_i;
    wire in_valid_i;
    wire in_ready_o;
    var logic flush_i;
    wire [WIDTH-1:0] result_o;
    var fpnew_pkg::status_t status_o;
    wire tag_o;
    wire out_valid_o;
    var logic out_ready_i;
    wire busy_o;
    wire end_sim;

    assign operands_i[0] = in_inter.A;
    assign operands_i[1] = in_inter.B;
    assign operands_i[2] = in_inter.C;
    assign rnd_mode_i = fpnew_pkg::RNE;
    assign op_i = fpnew_pkg::MUL;
    assign op_mod_i = 0;
    assign src_fmt_i = fpnew_pkg::FP16;
    assign dst_fmt_i = fpnew_pkg::FP16;
    assign int_fmt_i = fpnew_pkg::INT16;
    assign vectorial_op_i = 0;
    assign tag_i = 0;
    assign flush_i = 0;
    assign out_ready_i = out_valid_o;
    // assign in_inter.ready = out_ready_i;

    fpnew_top fpu_under_test(
      .clk_i(in_inter.clk),
      .rst_ni(!in_inter.rst),
      .operands_i,
      .rnd_mode_i,
      .op_i,
      .op_mod_i,
      .src_fmt_i,
      .dst_fmt_i,
      .int_fmt_i,
      .vectorial_op_i,
      .tag_i,
      .in_valid_i,
      .in_ready_o,
      .flush_i,
      .status_o,
      .result_o, 
      .tag_o,
      .out_valid_o,
      .busy_o,
      .out_ready_i
    );

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= WAIT;
                end
                
                WAIT: begin
                    if(in_inter.valid) begin
                        in_inter.ready <= 0;
                        //out_inter.data <= in_inter.A + in_inter.B;
                        $display("adder: input A = %d, input B = %d, output OUT = %d",in_inter.A,in_inter.B,out_inter.data);
                        $display("adder: input A = %b, input B = %b, output OUT = %b",in_inter.A,in_inter.B,out_inter.data);
                        out_inter.valid <= 1;
                        state <= SEND;
                    end
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;
                        state <= WAIT;
                    end
                end
        endcase
    end
endmodule: DUT
