`default_nettype none
`define O_WIDTH (16)
`define I_WIDTH ($clog2(`O_WIDTH))

module KW_decode_v_wrap (
  input  logic                i_v,
  input  logic [`I_WIDTH-1:0] i,
  output logic [`O_WIDTH-1:0] o
);
  KW_decode_v #(
    .O_WIDTH(`O_WIDTH),
    .I_WIDTH(`I_WIDTH)
  ) dut (
    .*
  );
endmodule
