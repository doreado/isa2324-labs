module tb;

  // Include necessary libraries
  import mytypes::*;        // Use custom types defined in myTypes package
    
   /*
   wire        CLK;
   wire        RSTn;
   wire        PROC_REQ;
   wire        MEM_RDY;
   wire [31:0] ADDR;
   wire        WE;
   wire [31:0] WDATA;
   wire [31:0] RDATA;
   wire        VALID;
   */
  // Define signals
  logic PROQ_REQ, REQ_DONE, DPROC_REQ, DREQ_DONE;
  logic         CLK = 1'b0;
  logic         RST;
  logic         IRAM_READY;
  logic [numbit-1:0] IRAM_DATA;
  logic [numbit-1:0] DMEM_RDATA;
  logic [31:0] DRAM_IN;
  logic [31:0] DRAM_OUT;
  logic         DRAM_READY;
  logic         IRAM_ENABLE;
  logic [ins_size-1:0] IRAM_ADDRESS;
  logic [ins_size-1:0] IRAM_ADDRESS_mem;
  logic         DRAM_ENABLE;
  logic         init_DRAM_ENABLE;
  logic         DRAM_ENABLE_s;
  logic         DRAM_READNOTWRITE;
  logic [ins_size-1:0] DRAM_ADDRESS;
  logic [ins_size-1:0] DRAM_ADDRESS_mem;

  logic         WEB_OUT, MEM_VALID, DMEM_VALID;
  logic [31:0] MEM_RDATA, WDATA_OUT;
  logic [31:0] IRAM_ADDR_OBI, DRAM_ADDR_OBI;
  logic [31:0] IRAM_DATA_OBI, DRAM_DATA_OBI; 
  logic IRAM_OBI_RDY, DRAM_OBI_RDY;
  logic we_s;
  logic mem_en;

  assign IRAM_ADDRESS_mem = IRAM_ADDRESS;
  assign DRAM_ADDRESS_mem = DRAM_ADDRESS;

  // Instantiate CORE component
  CORE CORE_1 (
    .CLK               (CLK),
    .RST               (RST),
    .IRAM_READY        (IRAM_READY),
    .IRAM_DATA         (IRAM_DATA_OBI),
    .DRAM_IN           (DRAM_IN),
    .DRAM_OUT          (DRAM_DATA_OBI),
    .DRAM_READY        (DRAM_READY),
    .IRAM_ENABLE       (IRAM_ENABLE),
    .IRAM_ADDRESS      (IRAM_ADDRESS),
    .DRAM_ENABLE       (mem_en),
    .DRAM_READNOTWRITE (DRAM_READNOTWRITE),
    .DRAM_ADDRESS      (DRAM_ADDRESS),
    .DPROC_REQ          (DPROC_REQ),
    .DREQ_DONE          (DREQ_DONE),
    .PROC_REQ          (PROC_REQ),
    .REQ_DONE          (REQ_DONE)
  );

  //Instantiate OBI_interface
  OBI_interface OBI(
    .clk(CLK),
    .rst(~RST),
    .mem_en(mem_en),
    .IRAM_proc_req(PROC_REQ),
    .DRAM_proc_req(DPROC_REQ),
    .IRAM_addr(IRAM_ADDRESS_mem),
    .DRAM_addr(DRAM_ADDRESS_mem),
    .wdata(DRAM_IN),
    .web(~DRAM_READNOTWRITE),            //check for active low/high inside OBI
    .IRAM_rdy(IRAM_OBI_READY),
    .DRAM_rdy(DRAM_OBI_READY),
    .IRAM_rdata(MEM_RDATA),
    .DRAM_rdata(DMEM_RDATA),
    .IRAM_valid_in(MEM_VALID),
    .DRAM_valid_in(MEM_VALID),
    .IRAM_addr_out(IRAM_ADDR_OBI),
    .DRAM_addr_out(DRAM_ADDR_OBI),
    .web_out(we_s),
    .wdata_out(WDATA_OUT),
    .IRAM_dout(IRAM_DATA_OBI),
    .DRAM_dout(DRAM_DATA_OBI),
    .req_busy_out(IRAM_READY),
    .dreq_busy_out(DRAM_READY),
    .dreq_done_out(DREQ_DONE),
    .req_done_out(REQ_DONE),
    .IRAM_valid_out(IRAM_VALID_OBI),
    .DRAM_valid_out(DRAM_VALID_OBI)
  );

  //Instantiate memory
  mem_wrap_fake #(
		   .CONTENT_TYPE(0),            // 0-CODE, 1-DATA
		   .tco( 1 ),
		   .tpd( 1 )
   ) IRAM (
      .CLK( CLK ),
      .RSTn( ~RST ),
      .PROC_REQ( PROC_REQ ),
      .MEM_RDY( IRAM_OBI_READY ),
      .ADDR(IRAM_ADDR_OBI),
      .WE(1'b0),
      //.WDATA(WDATA_OUT),
      .RDATA( MEM_RDATA ),
      .VALID( MEM_VALID )
   );
   
   mem_wrap_fake #(
		   .CONTENT_TYPE(1),            // 0-CODE, 1-DATA
		   .tco( 1 ),
		   .tpd( 1 )
   ) DRAM (
      .CLK( CLK ),
      .RSTn( ~RST ),
      .PROC_REQ( DPROC_REQ ),
      .MEM_RDY( DRAM_OBI_READY ),
      .ADDR(DRAM_ADDR_OBI),
      .WE(we_s),
      .WDATA(WDATA_OUT),
      .RDATA( DMEM_RDATA ),
      .VALID( DMEM_VALID )
   );  

  // Assignments and clock generation
  always #10 CLK = ~CLK;
  initial begin
    #1 RST = 1'b1;
    #15 RST = 1'b0;
  end
  initial begin
    #60 init_DRAM_ENABLE = 1'b0;
    #60 init_DRAM_ENABLE = 1'b1;
  end
  assign DRAM_ENABLE = init_DRAM_ENABLE & DRAM_ENABLE_s;

  // Monitor process to display signals
  always @(posedge CLK) begin
    $display("Time = %0t: IR = %h OPCODE = %b FUNCT3 = %b FUNCT7 = %b", 
      $time, CORE_1.datapath_1.ir, CORE_1.datapath_1.opcode, CORE_1.datapath_1.funct3, CORE_1.datapath_1.funct7);
  end

endmodule: tb
