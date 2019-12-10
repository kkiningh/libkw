`default_nettype none

// Single Asynchronous Read/Synchronous Write-Port RAM (Flip-Flop Based)
module KW_ram_1rws_dff #(
  parameter int DATA_WIDTH, // Width of data_in and data_out buses. Must be between 1-256
  parameter int DEPTH,      // Number of words in the memory array. Must be between 2-256

  // Determines the behavior of reset_n
  // 0: reset_n asynchronous reset
  // 1: reset_n synchronous reset
  // To generate a non-resettable RAM, tie reset_n HIGH
  parameter int RESET_MODE = 0,

  // Number of address bits. Do not override.
  parameter int ADDR_WIDTH = $clog2(DEPTH)
) (
  input logic clock,
  input logic reset_n,

  /* Port 1 control */
  input logic cs_n,
  input logic we_n,

  /* Port 1 datapath */
  input  logic [ADDR_WIDTH-1:0] rw_addr,
  input  logic [DATA_WIDTH-1:0] data_in,
  output logic [DATA_WIDTH-1:0] data_out
);
`ifndef SYNTHESIS
  initial begin
    assert (DATA_WIDTH >= 1 && DATA_WIDTH <= 256) else
      $fatal("Invalid DATA_WIDTH");
    assert (DEPTH >= 2 && DEPTH <= 256) else
      $fatal("Invalid DEPTH");
    assert (RESET_MODE == 0 || RESET_MODE == 1) else
      $fatal("Invalid RESET_MODE");
  end
`endif

`ifdef VERILATOR
  logic [DEPTH-1:0][DATA_WIDTH-1:0] memory;
  wire we = ~cs_n && ~we_n;

  // Synchronous write
  generate
    case (RESET_MODE)
      0: always_ff @(posedge clock or negedge reset_n) begin
        if (~reset_n) begin
          memory <= {DEPTH * DATA_WIDTH{1'b0}};
        end else begin
          if (we) begin
            memory[rw_addr] <= data_in;
          end
        end
      end
      1: always_ff @(posedge clock) begin
        if (~reset_n) begin
          memory <= {DEPTH * DATA_WIDTH{1'b0}};
        end else begin
          if (we) begin
            memory[rw_addr] <= data_in;
          end
        end
      end
    endcase
  endgenerate

  // Async read
  assign data_out = memory[rw_addr];
`else
  DW_ram_rw_s_dff #(
    .data_width(DATA_WIDTH),
    .depth     (DEPTH),
    .rst_mode  (RESET_MODE)
  ) ram (
    .clk     (clock),
    .rst_n   (reset_n),
    .cs_n    (cs_n),
    .wr_n    (we_n),
    .rw_addr (rw_addr),
    .data_in (data_in),
    .data_out(data_out)
  );
`endif
endmodule
