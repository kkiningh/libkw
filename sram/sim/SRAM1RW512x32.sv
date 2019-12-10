`default_nettype none

module SRAM1RW512x32 (
  input wire [9-1:0] A,
  input wire CE,
  input wire WEB,
  input wire OEB,
  input wire CSB,
  input wire [32-1:0] I,
  output reg [32-1:0] O
);
  wire RE = ~CSB && WEB;
  wire WE = ~CSB && ~WEB;

  reg [512-1:0][32-1:0] mem;
  reg [32-1:0] data_out;
  always_ff @(posedge CE) begin
    if (RE) data_out <= mem[A];
    if (WE) mem[A] <= I;
  end

  assign O = !OEB ? data_out : 32'bz;
endmodule
