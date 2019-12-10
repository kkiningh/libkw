load("//tools/verilator:rules.bzl", "cc_sv_library_verilator")

cc_sv_library_verilator(
    name = "KW_clock_div_cc",
    srcs = ["KW_clock_div_wrap.sv"],
    top = "KW_clock_div_wrap",
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/clock:KW_clock_div"],
)

cc_sv_library_verilator(
    name = "KW_reset_sync_cc",
    srcs = ["KW_reset_sync_wrap.sv"],
    top = "KW_reset_sync_wrap",
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/clock:KW_reset_sync"],
)
