load("//tools:verilog.bzl", "sv_library")

sv_library(
    name = "KW_dblbuf",
    srcs = [
        "KW_dblbuf.sv",
        "KW_dblbuf_cntl.sv",
    ],
    visibility = ["//grip/rtl:__subpackages__"],
    deps = ["//grip/rtl/lib/sram:KW_sram"],
)

sv_library(
    name = "KW_pipe_reg",
    srcs = ["KW_pipe_reg.sv"],
    visibility = ["//grip/rtl:__subpackages__"],
)

sv_library(
    name = "KW_pipe_reg_reset",
    srcs = ["KW_pipe_reg_reset.sv"],
    visibility = ["//grip/rtl:__subpackages__"],
)

sv_library(
    name = "KW_pipe_reg_v",
    srcs = ["KW_pipe_reg_v.sv"],
    deps = [
        ":KW_pipe_reg",
        ":KW_pipe_reg_reset",
    ],
    visibility = ["//grip/rtl:__subpackages__"],
)
