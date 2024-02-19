`timescale 1ps/1ps

import work.myTypes::*;
module tb_mem_wrap_fake ();

   wire        CLK;
   wire        RSTn;
   wire        RST;
   wire        PROC_REQ;
   wire        MEM_RDY;
   wire [31:0] ADDR;
   wire        WE;
   wire [31:0] WDATA;
   wire [31:0] RDATA;
   wire        VALID;
   wire valid_out_s, we_out_s;
   wire we_out_sn;
   wire [31:0] addr_out_s, wdata_out_s;

   localparam Ts = 10000;
   localparam tco = 1;
   localparam tpd = 1;
   localparam cRG_FAST = 0;
   localparam cIS_CODE = 0;
   localparam cIS_DATA = 1;   
   localparam cCONTENT_TYPE = cIS_CODE; 
   
   clk_gen #(
	     .T( Ts )
   ) CG (
  	 .CLK( CLK ),
	 .RSTn( RSTn )
   );

   if (cRG_FAST == 1) begin : RGF1

      req_gen_fast #(
		     .CONTENT_TYPE( cCONTENT_TYPE ),
		     .tco( tco ),
		     .tpd( tpd )
      ) rg (
            .CLK( CLK ),
            .RSTn( RSTn ),
            .PROC_REQ( PROC_REQ ),
            .MEM_RDY( MEM_RDY ),
            .WE( WE ),
            .ADDR( ADDR ),
            .WDATA( WDATA )
      );      
   end // block: RGF1

   if (cRG_FAST == 0) begin : RGF0

      req_gen #(
		.CONTENT_TYPE( cCONTENT_TYPE ),
		.tco( tco ),
		.tpd( tpd )
      ) rg (
            .CLK( CLK ),
            .RSTn( RSTn ),
            .PROC_REQ( PROC_REQ ),
            .MEM_RDY( MEM_RDY ),
            .WE( WE ),
            .ADDR( ADDR ),
            .WDATA( WDATA )
      );      
   end // block: RGF0

   LoadStoreUnit LSU (
      .clk( CLK ),
      .rst( RSTn ),
      .proc_req_in( PROC_REQ ),
      .addr_in( ADDR ),
      .wdata_in( WDATA ),
      .we_in( WE ),
      .mem_rdy( MEM_RDY ),
      .rdata( RDATA ),
      .valid_in( VALID ),
      .data_out( RDATA),
      .valid_out ( valid_out_s ),
      .addr_out( ADDR ),
      .we_out( we_out_s ),
      .wdata_out( wdata_out_s )
   );

   assign RST = ~RSTn;
   assign we_out_sn = ~we_out_s;

   /*mem_wrap_fake #(
		   .CONTENT_TYPE( cCONTENT_TYPE ),
		   .tco( tco ),
		   .tpd( tpd )
   ) UUT (
      .CLK( CLK ),
      .RSTn( RSTn ),
      .PROC_REQ( PROC_REQ ),
      .MEM_RDY( MEM_RDY ),
      .ADDR( ADDR ),
      .WE( WE ),
      .WDATA( WDATA ),
      .RDATA( RDATA ),
      .VALID( VALID )
   );
   */

   RWMEM #(
       .FILE_PATH(RW_HEX),
       .FILE_PATH_INIT(RW_HEX_INIT),
       .DATA_SIZE( numBit),
       .INSTR_SIZE( numBit ),
       .RAM_DEPTH ( DRAM_DEPTH ),
       .DATA_DELAY ( DRAM_DELAY )
     ) data_RAM (
      .CLK( CLK ),
      .RST( RST ),
      //.PROC_REQ( PROC_REQ ),
      //.MEM_RDY( MEM_RDY ),
      .ADDR( ADDR ),
      .READNOTWRITE( we_out_sn ), 
      .DATA_IN( wdata_out_s ),
      .DATA_OUT( rdata ),
      .DATA_READY( valid_out )
   ); 

  data_dumper dd (
		  .CLK( CLK ),
		  .RSTn( RSTn ),
		  .RDATA( rdata ),
		  .VALID( valid_out )
		  );
         
endmodule
