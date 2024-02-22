`timescale 1ps/1ps

module tb_mem_wrap_fake ();

   
   wire        CLK;
   wire        RSTn;
   wire        RST;
   wire        PROC_REQ, PROC_REQ_S;
   wire        MEM_RDY, MEM_RDY_S;
   wire [31:0] ADDR, ADDR_S;
   wire        WE, WE_S;
   wire [31:0] WDATA, WDATA_S;
   wire [31:0] RDATA, RDATA_S;
   wire        VALID, VALID_S;


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
   
    Fetcher F (
      .clk( CLK ),
      .rst( RSTn ),
      .proc_req_in( PROC_REQ ),
      .addr_in( ADDR ),
      .mem_rdy( MEM_RDY ),
      .rdata( RDATA ),
      .valid_in( VALID ),
      .data_out( RDATA_S),
      .valid_out ( VALID_S ),
      .addr_out( ADDR_S )
   ); 

   /*LoadStoreUnit LSU (
      .clk( CLK ),
      .rst( RSTn ),
      .proc_req_in( PROC_REQ ),
      .addr_in( ADDR ),
      .wdata_in( WDATA ),
      .we_in( WE ),
      .mem_rdy( MEM_RDY ),
      .rdata( RDATA ),
      .valid_in( VALID ),
      .data_out( RDATA_S),
      .valid_out ( VALID_S ),
      .addr_out( ADDR_S ),
      .we_out( WE_S ),
      .wdata_out( WDATA_S )
   );  */

   mem_wrap_fake #(
		   .CONTENT_TYPE( cCONTENT_TYPE ),
		   .tco( tco ),
		   .tpd( tpd )
   ) UUT (
      .CLK( CLK ),
      .RSTn( RSTn ),
      .PROC_REQ( PROC_REQ ),
      .MEM_RDY( MEM_RDY ),
      .ADDR( ADDR_S ),
      .WE( WE_out_s ),
      .WDATA( WDATA ),
      .RDATA( RDATA ),
      .VALID( VALID )
   );
   
  data_dumper dd (
		  .CLK( CLK ),
		  .RSTn( RSTn ),
		  .RDATA( RDATA_S ),
		  .VALID( VALID_S )
		  );
         
endmodule
