`default_nettype none

/// A FIFO with flags for level checking
module KW_fifo_cntl #(
  parameter int unsigned DATA_WIDTH = 16, // Data width in bits
  parameter int unsigned DEPTH      = 16, // Queue depth
  parameter int unsigned AF_LEVEL   = 1,  // Almost full level
  parameter int unsigned AE_LEVEL   = 1,  // Almost empty level

  // Error modes:
  // 0 - Underflow/overflow with pointer latched checking
  // 1 - Underflow/overflow latched checking
  // 2 - Underflow/overflow unlatched checking
  parameter int ERR_MODE = 1,

  // Do not change
  parameter int unsigned ADDR_WIDTH = $clog2(DEPTH)
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
  output logic error,        // FIFO error output, active high

  /* RAM interface */
  output logic ram_we_n, // RAM write enable, active low
  input  logic [DATA_WIDTH-1:0] ram_rd_data, // RAM read data
  output logic [ADDR_WIDTH-1:0] ram_rd_addr, // RAM read address
  output logic [DATA_WIDTH-1:0] ram_wr_data, // RAM write data
  output logic [ADDR_WIDTH-1:0] ram_wr_addr  // RAM write address
);
`ifdef VERILATOR
  // Parameter check
  initial begin
    assert (DEPTH >= 2 && $clog2(DEPTH) <= 24) else
      $fatal("DEPTH must be in the range [2, 2^24]");
    assert (AE_LEVEL >= 1 && AE_LEVEL < DEPTH) else
      $fatal("AE_LEVEL must be in the range [1, DEPTH)");
    assert (AF_LEVEL >= 1 && AF_LEVEL < DEPTH) else
      $fatal("AF_LEVEL must be in the range [1, DEPTH)");
  end
`endif

  localparam int unsigned COUNT_BITS = $clog2(DEPTH+1);
  localparam int unsigned AE_COUNT = AE_LEVEL;
  localparam int unsigned HF_COUNT = DEPTH / 2;
  localparam int unsigned AF_COUNT = DEPTH - AF_LEVEL;

  // Flags
  logic [COUNT_BITS-1:0] count;
  assign empty        = (count == {COUNT_BITS{1'b0}});
  assign almost_empty = (count <= AE_COUNT[COUNT_BITS-1:0]);
  assign half_full    = (count >= HF_COUNT[COUNT_BITS-1:0]);
  assign almost_full  = (count >= AF_COUNT[COUNT_BITS-1:0]);
  assign full         = (count == DEPTH   [COUNT_BITS-1:0]);

  // State machine
  always_ff @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
      ram_rd_addr <= 'b0;
      ram_wr_addr <= 'b0;
      count       <= 'b0;
    end else begin
      if (pop_req && push_req) begin
        ram_wr_addr <= ram_wr_addr + 1;
        ram_rd_addr <= ram_rd_addr + 1;
      end else if (push_req) begin
        ram_wr_addr <= ram_wr_addr + 1;
        count       <= count + 1;
      end else if (pop_req) begin
        ram_rd_addr <= ram_rd_addr + 1;
        count       <= count - 1;
      end
    end
  end

  // RAM control
  assign ram_we_n     = !push_req;
  assign ram_wr_data  = data_i;
  assign data_o       = ram_rd_data;

  // Error detection
  wire push_error = push_req && full && !pop_req;
  wire pop_error  = pop_req && empty;
  generate
    if (ERR_MODE == 0) begin
      initial $fatal("Not implemented");
    end else if (ERR_MODE == 1) begin
      always_ff @(posedge clock or negedge reset_n) begin
        if (~reset_n) begin
          error <= 1'b0;
        end else begin
          // Error is "sticky" until reset
          error <= error || push_error || pop_error;
        end
      end
    end else if (ERR_MODE == 2) begin
      assign error = push_error || pop_error;
    end
  endgenerate

`ifdef VERILATOR
  always_comb begin
    assert (reset_n || !push_error) else $error("push_error");
    assert (reset_n || !pop_error)  else $error("pop_error");
  end
`endif
endmodule
