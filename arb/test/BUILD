load("//tools/verilator:rules.bzl", "cc_sv_library_verilator")

cc_sv_library_verilator(
    name = "KW_arb_rr_cc",
    srcs = ["KW_arb_rr_wrap.sv"],
    top = "KW_arb_rr_wrap",
    vopts = ["--assert"],
    sysc = True,
    deps = ["//grip/rtl/lib/arb:KW_arb_rr"],
)

cc_test(
    name = "KW_arb_rr_test",
    srcs = ["KW_arb_rr_test.cpp"],
    deps = [
        ":KW_arb_rr_cc",
        "@com_github_google_googletest//:gtest",
    ],
)

cc_sv_library_verilator(
    name = "KW_arb_sp_cc",
    srcs = ["KW_arb_sp_wrap.sv"],
    top = "KW_arb_sp_wrap",
    vopts = ["--assert"],
    sysc = True,
    deps = ["//grip/rtl/lib/arb:KW_arb_sp"],
)

cc_test(
    name = "KW_arb_sp_test",
    srcs = ["KW_arb_sp_test.cpp"],
    deps = [
        ":KW_arb_sp_cc",
        "@com_github_google_googletest//:gtest",
    ],
)
