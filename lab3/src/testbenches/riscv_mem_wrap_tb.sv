module tb;

  // Include necessary libraries
  import mytypes::*;        // Use custom types defined in myTypes package

   wire        CLK;
   wire        RSTn;
   wire        PROC_REQ;
   wire        MEM_RDY;
   wire [31:0] ADDR;
   wire        WE;
   wire [31:0] WDATA;
   wire [31:0] RDATA;
   wire        VALID;

  // Define signals
  logic         CLK = 1'b0;
  logic         RST;
  logic         IRAM_READY;
  logic [numbit-1:0] IRAM_DATA;
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

  assign IRAM_ADDRESS_mem = IRAM_ADDRESS >> 2;
  assign DRAM_ADDRESS_mem = DRAM_ADDRESS >> 2;

  // Instantiate DLX component
  DLX DLX_1 (
    .CLK               (CLK),
    .RST               (RST),
    .IRAM_READY        (IRAM_READY),
    .IRAM_DATA         (IRAM_DATA),
    .DRAM_IN           (DRAM_IN),
    .DRAM_OUT          (DRAM_OUT),
    .DRAM_READY        (DRAM_READY),
    .IRAM_ENABLE       (IRAM_ENABLE),
    .IRAM_ADDRESS      (IRAM_ADDRESS),
    .DRAM_ENABLE       (DRAM_ENABLE_s),
    .DRAM_READNOTWRITE (DRAM_READNOTWRITE),
    .DRAM_ADDRESS      (DRAM_ADDRESS)
  );

  // Assignments and clock generation
  always #10 CLK = ~CLK;
  initial begin
    #5 RST = 1'b1;
    #5 RST = 1'b0;
  end
  initial begin
    #60 init_DRAM_ENABLE = 1'b0;
    #60 init_DRAM_ENABLE = 1'b1;
  end
  assign DRAM_ENABLE = init_DRAM_ENABLE & DRAM_ENABLE_s;

  // Monitor process to display signals
  always @(posedge CLK) begin
    $display("Time = %0t: IR = %h OPCODE = %b FUNCT3 = %b FUNCT7 = %b", 
      $time, DLX_1.datapath_1.ir, DLX_1.datapath_1.opcode, DLX_1.datapath_1.funct3, DLX_1.datapath_1.funct7);
  end

endmodule: tb