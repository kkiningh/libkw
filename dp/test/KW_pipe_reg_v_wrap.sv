`default_nettype none
`define DATA_WIDTH (16)
`define DEPTH (8)

module KW_pipe_reg_v_wrap (
  input logic clock,
  input logic reset_n,

  input  logic                   i_v,
  input  logic [`DATA_WIDTH-1:0] i,
  output logic                   o_v,
  output logic [`DATA_WIDTH-1:0] o
);
  KW_pipe_reg_v #(
    .DATA_WIDTH(`DATA_WIDTH),
    .DEPTH(`DEPTH)
  ) dut (
    .*
  );
endmodule
