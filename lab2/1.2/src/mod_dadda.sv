import mod_dadda_mul_pkg::*;

module mod_dadda ( input pp_t pp,
                   input signs_t signs
                       );

    sign_ext_pp_t sign_ext_pp;
    dots_t dots;
    bit_dots_t init_dots;
    // heights retrieved using a script
    // heights do consider carry generated in that level
    localparam int       heights[0:2][dots_width - 1:0] = {{2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 7, 7, 5, 5, 3, 4, 2, 3, 1, 2},
                                                           {3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 2, 3, 1, 2},
                                                           {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 1, 2}};
    // height threshold for each level
    localparam int                  max_heights[0:2] = {4, 3, 2};


    genvar i, j; // row_idx, column_idx
    // Sign extend partial products (pp)
    // The last row is not sign extended
    generate
        for (i = 0; i < row_num; i++) begin
            // The first dadda_width elements are mirrored
            for (j = 0; j < dadda_width; j++) begin
                assign sign_ext_pp[i][j] = pp[i][j];
            end

            // The thirteenth element of the first row is the sign,
            // the next 4 rows have not(sign) and the last element has Z
            assign sign_ext_pp[i][dadda_width] = i == 0 ? signs[i] : i <= 4 ? !signs[i] : 1'bz;
            // The fourteenth element of the first row is the sign
            // the remaining three rows have 1. The two last ones have Z
            assign sign_ext_pp[i][dadda_width + 1] = i == 0 ? signs[i] : i < 4 ? 1 : 1'bz;
            // Only the first element is extended
            assign sign_ext_pp[i][dadda_width + 2] = i == 0 ? !signs[i] : 1'bz;
        end
    endgenerate

    // Represent sign_extended_pp with the correct shift, adding the rightmost sign bits
    generate
        for (i = 0; i < row_num; i++) begin
            for (j = 0; j < i * 2; j++) begin
                // Ensure adding sign bit in the correct position
                assign dots[i][j] = j == ( i - 1 ) * 2  ? signs[i - 1] : 1'bz;
            end

            for (j = 0; j < dadda_width + 3; j++) begin
                // Ensure do not exceed the bounds
                if (j + (i * 2) <= dots_width - 1) begin
                    assign dots[i][j + (i * 2)] = sign_ext_pp[i][j];
                end
            end
        end
    endgenerate

    // Allocate
    generate
        for (j = 0; j < 3; j++) begin
            for(i = 0; i < col_num; i++) begin
                case (heights[j][i] - max_heights[j])
                  1: begin

                      // HA
                  end
                  2: begin
                      // FA
                  end
                  3: begin
                      // HA
                      // FA
                  end

                  4: begin
                      // FA
                      // FA
                  end

                  default: ;
                endcase
            end
        end
    endgenerate
endmodule
