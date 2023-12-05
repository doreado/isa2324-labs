package mod_dadda_mul_pkg;

    // Constants
    localparam int dadda_width = 12;
    localparam int row_num = 6;
    localparam int col_num = 21;
    localparam int dots_width = 21;

    // heights retrieved using a script
    // heights do consider carry generated in that level
    localparam int       heights[0:2][dots_width - 1:0] = {{2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 7, 7, 5, 5, 3, 4, 2, 3, 1, 2},
                                                           {3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 2, 3, 1, 2},
                                                           {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 1, 2}};
    // height threshold for each level
    localparam int       max_heights[0:2] = {4, 3, 2};

    // Types
    typedef logic [dadda_width - 1:0] pp_t[0:row_num - 1] ;
    // Reducing the height of Dadda tree implies extending by one additional bit the first row
    typedef logic [dadda_width + 2:0] sign_ext_pp_t[0:row_num - 1];
    typedef logic [0:row_num - 2] signs_t;
    typedef logic [dots_width - 1:0] dots_t[0:row_num - 1];
    // consider also sums and carries as part of dots matrix
    // 1th       2th       3th
    //  S   C     S   C     S   C
    // (2 + 2) + (1 + 1) + (1 + 1) = 8
    typedef logic [dots_width - 1:0] ext_dots_t[0:row_num - 1 + 8];
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

    // returns the index of the element in column col_idx
    // that should be summed in the next compressor allocation
    function int dot_to_sum(int col_idx);
        static int last[dots_width - 1: 0] = '{default: 0};

        last[col_idx] += 1;

        return last[col_idx] - 1;
    endfunction : dot_to_sum;

    // returns the first available index in which sum and carry out in the
    // column col_idx bit should be placed when a compressor is allocated
    function int first_available(int col_idx);
        static int last[dots_width - 1: 0] = heights[0];

        last[col_idx] += 1;

        return last[col_idx] - 1;
    endfunction : first_available;

endpackage
