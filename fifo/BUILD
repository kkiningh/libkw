load("//tools:verilog.bzl", "sv_library")

package(default_visibility = ["//grip/rtl:__subpackages__"])

sv_library(
    name = "KW_fifo",
    srcs = ["KW_fifo.sv"],
    deps = [":KW_fifo_cntl"],
)

sv_library(
    name = "KW_fifo_cntl",
    srcs = ["KW_fifo_cntl.sv"],
)

sv_library(
    name = "KW_fifo_stream",
    srcs = ["KW_fifo_stream.sv"],
    deps = [
        ":KW_fifo",
        "//grip/rtl/lib/utility:KW_unread",
    ],
)
