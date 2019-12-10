`default_nettype none

`define DATA_WIDTH (256)
`define DEPTH      (32)
`define ADDR_WIDTH ($clog2(`DEPTH))
`define RESET_MODE (1)

module KW_ram_1ra_1ws_dff_wrap (
  input logic clock,
  input logic reset_n,

  input logic cs_n,
  input logic we_n,

  input  logic [`ADDR_WIDTH-1:0] rd_addr,
  input  logic [`ADDR_WIDTH-1:0] wr_addr,
  input  logic [`DATA_WIDTH-1:0] data_in,
  output logic [`DATA_WIDTH-1:0] data_out
);
  KW_ram_1ra_1ws_dff #(
    .DATA_WIDTH(`DATA_WIDTH),
    .DEPTH(`DEPTH),
    .RESET_MODE(`RESET_MODE)
  ) dut (
    .clock(clock),
    .reset_n(reset_n),
    .cs_n(cs_n),
    .we_n(we_n),
    .rd_addr(rd_addr),
    .wr_addr(wr_addr),
    .data_in(data_in),
    .data_out(data_out)
  );
endmodule
