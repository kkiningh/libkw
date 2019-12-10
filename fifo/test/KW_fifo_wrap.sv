`default_nettype none
`define DATA_WIDTH (16)
`define DEPTH      (32)
`define AF_LEVEL   (1)
`define AE_LEVEL   (1)
`define ERR_MODE   (1)

module KW_fifo_wrap (
  input logic clock,    // Clock
  input logic reset_n,  // Reset, active low, ASYNC

  /* Control */
  input logic push_req, // Push request
  input logic pop_req,  // Pop request

  /* Datapath */
  input  logic [`DATA_WIDTH-1:0] data_i,
  output logic [`DATA_WIDTH-1:0] data_o,

  /* Flags */
  output logic empty,        // FIFO level == 0
  output logic almost_empty, // FIFO level <= AE_LEVEL
  output logic half_full,    // FIFO level >= DEPTH / 2
  output logic almost_full,  // FIFO level >= (DEPTH - AF_LEVEL)
  output logic full,         // FIFO level == DEPTH
  output logic error         // FIFO error output, active high
);
  KW_fifo #(
    .DATA_WIDTH(`DATA_WIDTH),
    .DEPTH(`DEPTH),
    .AF_LEVEL(`AF_LEVEL),
    .AE_LEVEL(`AE_LEVEL),
    .ERR_MODE(`ERR_MODE)
  ) dut (
    .*
  );
endmodule
