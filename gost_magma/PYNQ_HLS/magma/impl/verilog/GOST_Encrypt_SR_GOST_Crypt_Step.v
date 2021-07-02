// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module GOST_Encrypt_SR_GOST_Crypt_Step (
        ap_ready,
        Data_prep_read,
        p_read1,
        Last,
        ap_return
);


output   ap_ready;
input  [63:0] Data_prep_read;
input  [7:0] p_read1;
input  [0:0] Last;
output  [63:0] ap_return;

wire   [7:0] shl_ln42_fu_68_p2;
wire   [7:0] or_ln42_fu_74_p2;
wire   [4:0] trunc_ln18_fu_94_p1;
wire   [2:0] tmp_s_fu_80_p4;
wire   [31:0] or_ln1_fu_98_p6;
wire   [31:0] trunc_ln46_fu_90_p1;
wire   [23:0] or_ln2_fu_116_p5;
wire   [23:0] trunc_ln46_1_fu_112_p1;
wire   [31:0] S_fu_128_p2;
wire   [31:0] trunc_ln_fu_58_p4;
wire   [7:0] tmp_17_fu_140_p4;
wire   [23:0] xor_ln49_fu_134_p2;
wire   [63:0] or_ln49_3_fu_150_p4;
wire   [63:0] or_ln_fu_160_p3;

assign S_fu_128_p2 = (trunc_ln46_fu_90_p1 ^ or_ln1_fu_98_p6);

assign ap_ready = 1'b1;

assign ap_return = ((Last[0:0] == 1'b1) ? or_ln49_3_fu_150_p4 : or_ln_fu_160_p3);

assign or_ln1_fu_98_p6 = {{{{{trunc_ln18_fu_94_p1}, {or_ln42_fu_74_p2}}, {or_ln42_fu_74_p2}}, {or_ln42_fu_74_p2}}, {tmp_s_fu_80_p4}};

assign or_ln2_fu_116_p5 = {{{{trunc_ln18_fu_94_p1}, {or_ln42_fu_74_p2}}, {or_ln42_fu_74_p2}}, {tmp_s_fu_80_p4}};

assign or_ln42_fu_74_p2 = (shl_ln42_fu_68_p2 | p_read1);

assign or_ln49_3_fu_150_p4 = {{{trunc_ln_fu_58_p4}, {tmp_17_fu_140_p4}}, {xor_ln49_fu_134_p2}};

assign or_ln_fu_160_p3 = {{S_fu_128_p2}, {trunc_ln_fu_58_p4}};

assign shl_ln42_fu_68_p2 = p_read1 << 8'd4;

assign tmp_17_fu_140_p4 = {{S_fu_128_p2[31:24]}};

assign tmp_s_fu_80_p4 = {{or_ln42_fu_74_p2[7:5]}};

assign trunc_ln18_fu_94_p1 = or_ln42_fu_74_p2[4:0];

assign trunc_ln46_1_fu_112_p1 = Data_prep_read[23:0];

assign trunc_ln46_fu_90_p1 = Data_prep_read[31:0];

assign trunc_ln_fu_58_p4 = {{Data_prep_read[63:32]}};

assign xor_ln49_fu_134_p2 = (trunc_ln46_1_fu_112_p1 ^ or_ln2_fu_116_p5);

endmodule //GOST_Encrypt_SR_GOST_Crypt_Step
