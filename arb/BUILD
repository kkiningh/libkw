load("//tools:verilog.bzl", "sv_library")
package(default_visibility = ["//grip/rtl:__subpackages__"])

sv_library(
    name = "KW_arb_rr",
    srcs = ["KW_arb_rr.sv"],
)

sv_library(
    name = "KW_arb_sp",
    srcs = ["KW_arb_sp.sv"],
    deps = [
        "//grip/rtl/lib/comb:KW_ror_static",
        "//grip/rtl/lib/comb:KW_rol_static",
    ],
)
