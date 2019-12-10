`default_nettype none
`define DATA_WIDTH (16)
`define DEPTH (8)

module KW_pipe_reg_wrap (
  input logic clock,

  input  logic [`DATA_WIDTH-1:0] i,
  output logic [`DATA_WIDTH-1:0] o
);
  KW_pipe_reg #(
    .DATA_WIDTH(`DATA_WIDTH),
    .DEPTH(`DEPTH)
  ) dut (
    .*
  );
endmodule
