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
    // Four dimensional matrix to represent connections
    typedef logic [dots_width - 1:0] dots_t[0:3][0:row_num - 1];

    // Functions
    function int carry_offset(int layer, int column);
        automatic int diff;

        if (column < 1) begin
            return 0;
        end

        diff = heights[layer][column - 1] - max_heights[layer];

        if (diff < 1 || diff > 4) begin
            return 0;
        end

        return diff <= 2 ? 1 : 2;
    endfunction : carry_offset
endpackage
