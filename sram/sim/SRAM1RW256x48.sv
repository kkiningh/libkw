`default_nettype none

module SRAM1RW256x48 (
  input wire [8-1:0] A,
  input wire CE,
  input wire WEB,
  input wire OEB,
  input wire CSB,
  input wire [48-1:0] I,
  output reg [48-1:0] O
);
  wire RE = ~CSB && WEB;
  wire WE = ~CSB && ~WEB;

  reg [256-1:0][48-1:0] mem;
  reg [48-1:0] data_out;
  always_ff @(posedge CE) begin
    if (RE) data_out <= mem[A];
    if (WE) mem[A] <= I;
  end

  assign O = !OEB ? data_out : 48'bz;
endmodule
