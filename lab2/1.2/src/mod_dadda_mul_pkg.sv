package mod_dadda_mul_pkg;

    // Constants
    localparam int dadda_width = 12;
    localparam int row_num = 6;
    localparam int col_num = 21;
    localparam int dots_width = 21;

    // Types
    typedef logic [dadda_width - 1:0] pp_t[0:row_num - 1] ;
    // Reducing the height of Dadda tree implies extending by one additional bit the first row
    typedef logic [dadda_width + 2:0] sign_ext_pp_t[0:row_num - 1];
    typedef logic [0:row_num - 2] signs_t;
    typedef logic [dots_width - 1:0] dots_t[0:row_num - 1];
    typedef bit [dots_width - 1:0] bit_dots_t[0:row_num - 1];

    // Functions
    function int count_dots(int col_idx, dots_t dots);
        automatic int acc = 0;

        for (int i = 0; i < row_num; i++) begin
            if (dots[i][col_idx] != 1'bz) begin
                acc++;
            end
        end

        // $display("I've count %0d dots", acc);
        return acc;
    endfunction : count_dots

endpackage
