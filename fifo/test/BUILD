load("//tools/verilator:rules.bzl", "cc_sv_library_verilator")

cc_sv_library_verilator(
    name = "KW_fifo_cc",
    srcs = ["KW_fifo_wrap.sv"],
    top = "KW_fifo_wrap",
    deps = ["//grip/rtl/lib/fifo:KW_fifo"],
)

cc_sv_library_verilator(
    name = "KW_fifo_stream_cc",
    srcs = ["KW_fifo_stream_wrap.sv"],
    top = "KW_fifo_stream_wrap",
    deps = ["//grip/rtl/lib/fifo:KW_fifo_stream"],
)
