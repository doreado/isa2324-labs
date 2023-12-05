import mod_dadda_mul_pkg::*;

module mod_dadda ( input pp_t pp,
                   input signs_t signs
                       );

    sign_ext_pp_t sign_ext_pp;
    // triangular, extended matrix with rows for sums and carries
    ext_dots_t dots;

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
            assign sign_ext_pp[i][dadda_width] = i == 0 ? signs[i] : i <= 4 ? !signs[i] : 1'bx;
            // The fourteenth element of the first row is the sign
            // the remaining three rows have 1. The two last ones have Z
            assign sign_ext_pp[i][dadda_width + 1] = i == 0 ? signs[i] : i < 4 ? 1 : 1'bx;
            // Only the first element is extended
            assign sign_ext_pp[i][dadda_width + 2] = i == 0 ? !signs[i] : 1'bx;
        end
    endgenerate

    // Represent sign_extended_pp with the correct shift, adding the rightmost sign bits
    generate
        for (i = 0; i < row_num; i++) begin
            assign dots[i][( i - 1 ) * 2] = signs[i - 1];

            for (j = 0; j < dadda_width + 3; j++) begin
                if ((j + (i * 2)) >= 15) begin
                    assign dots[row_num - 1 - i][j + (i * 2)] = sign_ext_pp[i][j];
                end
                else begin
                    // create the triangular share, flipping the lines
                    assign dots[i][j + (i * 2)] = sign_ext_pp[i][j];
                end
            end
        end
    endgenerate

    // Allocate
    genvar last;
    generate
        for (j = 0; j < 3; j++) begin
            for(i = 0; i < col_num; i++) begin
                case (heights[j][i] - max_heights[j])
                  1: begin : one_ha
                      $info("HA");

                      $info("layer: %d col: %d", j, i);
                      HA ha( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));
                  end
                  2: begin : one_fa
                      $info("FA");

                      $info("layer: %d col: %d", j, i);
                      FA fa( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_in(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));
                  end
                  3: begin
                      $info("HA FA");

                      $info("layer: %d col: %d", j, i);

                      HA ha( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));

                      FA fa( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_in(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));
                  end

                  4: begin
                      $info("FA FA");

                      $info("layer: %d col: %d", j, i);

                      FA fa( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_in(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));
                      FA faa( .a(dots[dot_to_sum(i)][i]),
                             .b(dots[dot_to_sum(i)][i]),
                             .c_in(dots[dot_to_sum(i)][i]),
                             .c_out(dots[first_available(i + 1)][i + 1]),
                             .sum(dots[first_available(i)][i]));
                  end

                  default: ;
                endcase
            end
        end
    endgenerate
endmodule
