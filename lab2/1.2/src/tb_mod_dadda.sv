import mod_dadda_mul_pkg::*;

module tb_mod_dadda ();

    pp_t pp;
    signs_t signs;

    mod_dadda dut (.pp, .signs);

    initial begin
        // Initialize pp with ones using nested loops
        for (int i = 0; i < row_num; i++) begin
            for (int j = 0; j < col_num; j++) begin
                pp[i][j] = j % 2 == 0 ? 1'b0 : 1'b1;
            end
        end

        // Initialize signs with ones using nested loops
        for (int i = 0; i < dadda_width; i++) begin
            signs[i] = 0'b1;
        end

    end
endmodule
