load("//tools:verilog.bzl", "sv_library")

sv_library(
    name = "KW_prod_sum",
    srcs = ["KW_prod_sum.sv"],
    deps = ["//grip/rtl/lib/dp:KW_pipe_reg"],
    visibility = ["//grip/rtl:__subpackages__"],
)

sv_library(
    name = "KW_ctr",
    srcs = ["KW_ctr.sv"],
    visibility = ["//grip/rtl:__subpackages__"],
)

sv_library(
    name = "KW_sum",
    srcs = ["KW_sum.sv"],
    deps = ["//grip/rtl/lib/dp:KW_pipe_reg"],
    visibility = ["//grip/rtl:__subpackages__"],
)
