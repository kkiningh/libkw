`default_nettype none

// FIFO implementation using FFs for storage
module KW_fifo #(
  parameter int unsigned DATA_WIDTH = 16, // Data width in bits
  parameter int unsigned DEPTH      = 16, // Queue depth
  parameter int unsigned AF_LEVEL   = 1,  // Almost full level
  parameter int unsigned AE_LEVEL   = 1,  // Almost empty level

  // Error modes:
  // 0 - Underflow/overflow with pointer latched checking
  // 1 - Underflow/overflow latched checking
  // 2 - Underflow/overflow unlatched checking
  parameter int ERR_MODE = 1
) (
  input logic clock,    // Clock
  input logic reset_n,  // Reset, active low, ASYNC

  /* Control */
  input logic push_req, // Push request
  input logic pop_req,  // Pop request

  /* Datapath */
  input  logic [DATA_WIDTH-1:0] data_i, // Input data
  output logic [DATA_WIDTH-1:0] data_o, // Output data

  /* Flags */
  output logic empty,        // FIFO level == 0
  output logic almost_empty, // FIFO level <= AE_LEVEL
  output logic half_full,    // FIFO level >= DEPTH / 2
  output logic almost_full,  // FIFO level >= (DEPTH - AF_LEVEL)
  output logic full,         // FIFO level == DEPTH
  output logic error         // FIFO error output, active high
);
  localparam int unsigned ADDR_WIDTH = $clog2(DEPTH);

  logic ram_we_n;
  logic [DATA_WIDTH-1:0] ram_rd_data;
  logic [ADDR_WIDTH-1:0] ram_rd_addr;
  logic [DATA_WIDTH-1:0] ram_wr_data;
  logic [ADDR_WIDTH-1:0] ram_wr_addr;

  logic [DATA_WIDTH-1:0] ram [0:DEPTH-1];
  always_ff @(posedge clock) begin
    if (!ram_we_n) begin
      ram[ram_wr_addr] <= ram_wr_data;
    end
    ram_rd_data <= ram[ram_rd_addr];
  end

  KW_fifo_cntl #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH     (DEPTH),
    .AF_LEVEL  (AF_LEVEL),
    .AE_LEVEL  (AE_LEVEL),
    .ERR_MODE  (ERR_MODE)
  ) KW_fifo_cntl_inst (
    .clock  (clock),
    .reset_n(reset_n),

    /* Control */
    .push_req(push_req),
    .pop_req (pop_req),

    /* Datapath */
    .data_i(data_i),
    .data_o(data_o),

    /* Flags */
    .empty       (empty),
    .almost_empty(almost_empty),
    .half_full   (half_full),
    .almost_full (almost_full),
    .full        (full),
    .error       (error),

    /* RAM interface */
    .ram_we_n   (ram_we_n),
    .ram_rd_data(ram_rd_data),
    .ram_rd_addr(ram_rd_addr),
    .ram_wr_data(ram_wr_data),
    .ram_wr_addr(ram_wr_addr)
  );
endmodule
