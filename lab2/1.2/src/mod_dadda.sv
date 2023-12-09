import mod_dadda_mul_pkg::*;

module mod_dadda ( input pp_t pp,
                   input  signs_t signs,
                   output dots_t a,
                   output dots_t b
                   );

    sign_ext_pp_t sign_ext_pp;
    // triangular, extended matrix with rows for sums and carries
    dots_matrices_t dots;

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
            // the next 4 rows have not(sign) and the last element has X
            assign sign_ext_pp[i][dadda_width] = i == 0 ? signs[i] : i <= 4 ? !signs[i] : 1'bx;
            // The fourteenth element of the first row is the sign
            // the remaining three rows have 1. The last one has X
            assign sign_ext_pp[i][dadda_width + 1] = i == 0 ? signs[i] : i <= 4 ? 1 : 1'bx;
            // Only the first element is extended
            assign sign_ext_pp[i][dadda_width + 2] = i == 0 ? !signs[i] : 1'bx;
        end
    endgenerate

    // Represent sign_extended_pp with the correct shift, adding the rightmost sign bits
    generate
        for (i = 0; i < row_num; i++) begin
            assign dots[0][i][( i - 1 ) * 2] = signs[i - 1];

            for (j = 0; j < dadda_width + 3; j++) begin
                if ((j + (i * 2)) >= 15) begin
                    assign dots[0][row_num - 1 - i][j + (i * 2)] = sign_ext_pp[i][j];
                end
                else begin
                    // create the triangular share, flipping the lines
                    assign dots[0][i][j + (i * 2)] = sign_ext_pp[i][j];
                end
            end
        end
    endgenerate

    // Set to zero the second element of the second row in the first layer
    assign dots[0][1][1] = 0;

    // Allocate compressors
    genvar r;
    generate
        for (j = 0; j < 3; j++) begin
            for(i = 0; i < dots_width; i++) begin : adders_layers
                case (heights[j][i] - max_heights[j])
                  1: begin : one_ha
                      HA ha ( .a(dots[j][0][i]),
                              .b(dots[j][1][i]),
                              .c_out(dots[j + 1][0][i + 1]),
                              .sum(dots[j + 1][0 + carry_offset(j, i)][i]));

                      // Propagate elements not summed in the next layer
                      for (r = 1; r < row_num; r++) begin
                          assign dots[j + 1][r + carry_offset(j, i)][i] = dots[j][r + 1][i];
                      end
                  end

                  2: begin : one_fa
                      FA fa ( .a(dots[j][0][i]),
                              .b(dots[j][1][i]),
                              .c_in(dots[j][2][i]),
                              .c_out(dots[j + 1][0][i + 1]),
                              .sum(dots[j + 1][0 + carry_offset(j, i)][i]));

                      // Propagate elements not summed in the next layer
                      for (r = 1; r < row_num; r++) begin
                          assign dots[j + 1][r + carry_offset(j, i)][i] = dots[j][r + 2][i];
                      end
                  end
                  3: begin : one_ha_fa
                      HA ha ( .a(dots[j][0][i]),
                              .b(dots[j][1][i]),
                              .c_out(dots[j + 1][0][i + 1]),
                              .sum(dots[j + 1][0 + carry_offset(j, i)][i]));

                      FA fa ( .a(dots[j][2][i]),
                              .b(dots[j][3][i]),
                              .c_in(dots[j][4][i]),
                              .c_out(dots[j + 1][1][i + 1]),
                              .sum(dots[j + 1][1 + carry_offset(j, i)][i]));

                      for (r = 2; r < row_num; r++) begin
                          assign dots[j + 1][r + carry_offset(j, i)][i] = dots[j][r + 3][i];
                      end
                  end

                  4: begin: two_fa
                      FA fa ( .a(dots[j][0][i]),
                              .b(dots[j][1][i]),
                              .c_in(dots[j][2][i]),
                              .c_out(dots[j + 1][0][i + 1]),
                              .sum(dots[j + 1][0 + carry_offset(j, i)][i]));

                      FA faa ( .a(dots[j][3][i]),
                               .b(dots[j][4][i]),
                               .c_in(dots[j][5][i]),
                               .c_out(dots[j + 1][1][i + 1]),
                               .sum(dots[j + 1][1 + carry_offset(j, i)][i]));

                      for (r = 2; r < row_num; r++) begin
                          assign dots[j + 1][r + carry_offset(j, i)][i] = dots[j][r + 4][i];
                      end
                  end

                  default: begin
                      // it happens only when no compressor are allocated by construction
                      for (r = 0; r < row_num; r++) begin
                          assign dots[j + 1][r + carry_offset(j, i)][i] = dots[j][r][i];
                      end
                    end
                endcase
            end
        end
    endgenerate

    // Assign first two rows to the outputs
    assign a = dots[layers_num - 1][0];
    assign b = dots[layers_num - 1][1];
endmodule
