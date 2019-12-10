load("//tools/verilator:rules.bzl", "cc_sv_library_verilator")

cc_sv_library_verilator(
    name = "KW_prod_sum_cc",
    srcs = ["KW_prod_sum_wrap.sv"],
    top = "KW_prod_sum_wrap",
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/arith:KW_prod_sum"],
)

cc_sv_library_verilator(
    name = "KW_ctr_cc",
    top = "KW_ctr_wrap",
    srcs = ["KW_ctr_wrap.sv"],
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/arith:KW_ctr"],
)

cc_sv_library_verilator(
    name = "KW_sum_cc",
    srcs = ["KW_sum_wrap.sv"],
    top = "KW_sum_wrap",
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/arith:KW_sum"],
)

#cc_test(
#    name = "KW_prod_sum_test",
#    srcs = ["KW_prod_sum_test.cpp"],
#    deps = [
#        ":KW_prod_sum_cc",
#        "//grip/rtl/test:verilator_driver",
#        "@com_github_google_googletest//:gtest",
#    ],
#)

#cc_test(
#    name = "KW_ctr_test",
#    srcs = ["KW_ctr_test.cpp"],
#    deps = [
#        ":KW_ctr_cc",
#        "//grip/rtl/test:verilator_driver",
#        "@com_github_google_googletest//:gtest",
#    ],
#)
