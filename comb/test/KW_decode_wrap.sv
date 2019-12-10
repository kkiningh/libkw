`default_nettype none
`define O_WIDTH (16)
`define I_WIDTH ($clog2(`O_WIDTH))

module KW_decode_wrap (
  input  logic [`I_WIDTH-1:0] i,
  output logic [`O_WIDTH-1:0] o
);
  KW_decode #(
    .O_WIDTH(`O_WIDTH),
    .I_WIDTH(`I_WIDTH)
  ) dut (
    .*
  );
endmodule
