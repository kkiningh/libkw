load("//tools:verilog.bzl", "sv_library")

package(default_visibility = ["//grip/rtl:__subpackages__"])

sv_library(
    name = "KW_ror_static",
    srcs = ["KW_ror_static.sv"],
)

sv_library(
    name = "KW_rol_static",
    srcs = ["KW_rol_static.sv"],
)

sv_library(
    name = "KW_decode",
    srcs = ["KW_decode.sv"],
)

sv_library(
    name = "KW_decode_v",
    srcs = ["KW_decode_v.sv"],
    deps = ["//grip/rtl/lib/comb:KW_decode"],
)

sv_library(
    name = "KW_priority_encoder",
    srcs = ["KW_priority_encoder.sv"],
)

sv_library(
    name = "KW_mux_n_onehot",
    srcs = ["KW_mux_n_onehot.sv"],
)

sv_library(
    name = "KW_transpose_packed_2d",
    srcs = ["KW_transpose_packed_2d.sv"],
)

sv_library(
    name = "KW_bit_reverse",
    srcs = ["KW_bit_reverse.sv"],
)
