module tb;

  // Include necessary libraries
  import mytypes::*;        // Use custom types defined in myTypes package

  // Define signals
  logic         CLK = 1'b0;
  logic         RST;
  logic         IRAM_READY;
  logic [numbit-1:0] IRAM_DATA;
  logic [31:0] DRAM_IN;
  logic [31:0] DRAM_OUT;
  logic         DRAM_READY;
  logic         IRAM_ENABLE;
  logic [ins_size-1:0] IRAM_ADDRESS_dlx;
  logic [ins_size-1:0] IRAM_ADDRESS_ram;
  logic         DRAM_ENABLE;
  logic         init_DRAM_ENABLE;
  logic         DRAM_ENABLE_s;
  logic         DRAM_READNOTWRITE;
  logic [ins_size-1:0] DRAM_ADDRESS_dlx;
  logic [ins_size-1:0] DRAM_ADDRESS_ram;

  // Instantiate ROMEM component
  ROMEM #(ro_hex, iram_depth, ins_size, iram_addr_size, iram_delay)
  ROMEM_1 
  (
    .CLK        (CLK),
    .RST        (RST),
    .ADDRESS    (IRAM_ADDRESS_ram),
    .ENABLE     (IRAM_ENABLE),
    .DATA_READY (IRAM_READY),
    .DATA       (IRAM_DATA)
  );

  // Instantiate RWMEM component
  RWMEM #(rw_hex, rw_hex_init, numbit, numbit, dram_depth, dram_delay)
  DRAM_1 
  (
    .CLK          (CLK),
    .RST          (RST),
    .ADDR         (DRAM_ADDRESS_ram),
    .DATA_IN      (DRAM_IN),
    .ENABLE       (DRAM_ENABLE),
    .READNOTWRITE (DRAM_READNOTWRITE),
    .DATA_READY   (DRAM_READY),
    .DATA_OUT     (DRAM_OUT)
  );

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
    .IRAM_ADDRESS      (IRAM_ADDRESS_dlx),
    .DRAM_ENABLE       (DRAM_ENABLE_s),
    .DRAM_READNOTWRITE (DRAM_READNOTWRITE),
    .DRAM_ADDRESS      (DRAM_ADDRESS_dlx)
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
    $display("Time = %0t: OPCODE = %b FUNCT3 = %b FUNCT7 = %b", 
      $time, DLX_1.datapath_1.opcode, DLX_1.datapath_1.funct3, DLX_1.datapath_1.funct7);
  end

endmodule: tb