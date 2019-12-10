load("//tools/verilator:rules.bzl", "cc_sv_library_verilator")

cc_sv_library_verilator(
    name = "KW_dblbuf_cc",
    srcs = ["KW_dblbuf_wrap.sv"],
    top = "KW_dblbuf_wrap",
    vopts = ["--assert"],
    deps = ["//grip/rtl/lib/dp:KW_dblbuf"],
)

cc_sv_library_verilator(
    name = "KW_pipe_reg_cc",
    srcs = ["KW_pipe_reg_wrap.sv"],
    top = "KW_pipe_reg_wrap",
    deps = ["//grip/rtl/lib/dp:KW_pipe_reg"],
)

cc_sv_library_verilator(
    name = "KW_pipe_reg_v_cc",
    srcs = ["KW_pipe_reg_v_wrap.sv"],
    top = "KW_pipe_reg_v_wrap",
    deps = ["//grip/rtl/lib/dp:KW_pipe_reg_v"],
)

cc_sv_library_verilator(
    name = "KW_pipe_reg_reset_cc",
    srcs = ["KW_pipe_reg_reset_wrap.sv"],
    top = "KW_pipe_reg_reset_wrap",
    deps = ["//grip/rtl/lib/dp:KW_pipe_reg_reset"],
)

#cc_test(
#    name = "KW_dblbuf_test",
#    srcs = ["KW_dblbuf_test.cpp"],
#    deps = [
#        ":KW_dblbuf_cc",
#        "@com_github_google_googletest//:gtest",
#    ],
#)
