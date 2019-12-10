load("//tools:verilog.bzl", "sv_library")

sv_library(
    name = "KW_sram",
    srcs = [
        "KW_ram_1ra_1ws_dff.sv",
        "KW_ram_1rws_dff.sv",
        "KW_ram_1rws_sram.sv",
        "KW_ram_2rws_sram.sv",
    ],
    visibility = ["//grip/rtl:__subpackages__"],
    deps = [
        "//grip/rtl/lib/sram/sim:SRAM1RW",
        "//grip/rtl/lib/utility:KW_unread",
    ],
)
