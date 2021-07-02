// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_79_1_VITIS_LOOP_81_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        Data_prep,
        Data_prep_121_out,
        Data_prep_121_out_ap_vld,
        grp_GOST_Crypt_Step_fu_603_p_din1,
        grp_GOST_Crypt_Step_fu_603_p_din2,
        grp_GOST_Crypt_Step_fu_603_p_din3,
        grp_GOST_Crypt_Step_fu_603_p_dout0,
        grp_GOST_Crypt_Step_fu_603_p_ce,
        grp_GOST_Crypt_Step_fu_603_p_start,
        grp_GOST_Crypt_Step_fu_603_p_ready,
        grp_GOST_Crypt_Step_fu_603_p_done,
        grp_GOST_Crypt_Step_fu_603_p_idle
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [63:0] Data_prep;
output  [63:0] Data_prep_121_out;
output   Data_prep_121_out_ap_vld;
output  [63:0] grp_GOST_Crypt_Step_fu_603_p_din1;
output  [31:0] grp_GOST_Crypt_Step_fu_603_p_din2;
output  [0:0] grp_GOST_Crypt_Step_fu_603_p_din3;
input  [63:0] grp_GOST_Crypt_Step_fu_603_p_dout0;
output   grp_GOST_Crypt_Step_fu_603_p_ce;
output   grp_GOST_Crypt_Step_fu_603_p_start;
input   grp_GOST_Crypt_Step_fu_603_p_ready;
input   grp_GOST_Crypt_Step_fu_603_p_done;
input   grp_GOST_Crypt_Step_fu_603_p_idle;

reg ap_idle;
reg Data_prep_121_out_ap_vld;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln79_fu_117_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
wire   [2:0] GOST_Key_address0;
reg    GOST_Key_ce0;
wire   [31:0] GOST_Key_q0;
wire    ap_block_pp0_stage0_11001;
reg   [0:0] icmp_ln79_reg_202;
wire    grp_GOST_Crypt_Step_fu_88_ap_ready;
reg    grp_GOST_Crypt_Step_fu_88_ap_start_reg;
wire    ap_block_pp0_stage0;
wire   [63:0] j_2_cast_fu_146_p1;
reg   [3:0] j_fu_50;
wire    ap_loop_init;
reg   [3:0] ap_sig_allocacmp_j_load;
wire   [3:0] add_ln81_fu_151_p2;
reg   [63:0] Data_prep_2_fu_54;
reg   [63:0] ap_sig_allocacmp_Data_prep_2_load_1;
reg   [4:0] indvar_flatten_fu_58;
reg   [4:0] ap_sig_allocacmp_indvar_flatten_load;
wire   [4:0] add_ln79_fu_123_p2;
wire    ap_block_pp0_stage0_01001;
wire   [0:0] icmp_ln81_fu_132_p2;
wire   [3:0] select_ln74_fu_138_p3;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 grp_GOST_Crypt_Step_fu_88_ap_start_reg = 1'b0;
#0 ap_done_reg = 1'b0;
end

GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_106_1_GOST_Key #(
    .DataWidth( 32 ),
    .AddressRange( 8 ),
    .AddressWidth( 3 ))
GOST_Key_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(GOST_Key_address0),
    .ce0(GOST_Key_ce0),
    .q0(GOST_Key_q0)
);

GOST_Encrypt_SR_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_GOST_Crypt_Step_fu_88_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            grp_GOST_Crypt_Step_fu_88_ap_start_reg <= 1'b1;
        end else if ((grp_GOST_Crypt_Step_fu_88_ap_ready == 1'b1)) begin
            grp_GOST_Crypt_Step_fu_88_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            Data_prep_2_fu_54 <= Data_prep;
        end else if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
            Data_prep_2_fu_54 <= grp_GOST_Crypt_Step_fu_603_p_dout0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln79_fu_117_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten_fu_58 <= add_ln79_fu_123_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_58 <= 5'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln79_fu_117_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            j_fu_50 <= add_ln81_fu_151_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            j_fu_50 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        icmp_ln79_reg_202 <= icmp_ln79_fu_117_p2;
    end
end

always @ (*) begin
    if (((icmp_ln79_reg_202 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        Data_prep_121_out_ap_vld = 1'b1;
    end else begin
        Data_prep_121_out_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        GOST_Key_ce0 = 1'b1;
    end else begin
        GOST_Key_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln79_fu_117_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_Data_prep_2_load_1 = grp_GOST_Crypt_Step_fu_603_p_dout0;
    end else begin
        ap_sig_allocacmp_Data_prep_2_load_1 = Data_prep_2_fu_54;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_indvar_flatten_load = 5'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten_load = indvar_flatten_fu_58;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_j_load = 4'd0;
    end else begin
        ap_sig_allocacmp_j_load = j_fu_50;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign Data_prep_121_out = Data_prep_2_fu_54;

assign GOST_Key_address0 = j_2_cast_fu_146_p1;

assign add_ln79_fu_123_p2 = (ap_sig_allocacmp_indvar_flatten_load + 5'd1);

assign add_ln81_fu_151_p2 = (select_ln74_fu_138_p3 + 4'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign grp_GOST_Crypt_Step_fu_603_p_ce = 1'b1;

assign grp_GOST_Crypt_Step_fu_603_p_din1 = ap_sig_allocacmp_Data_prep_2_load_1;

assign grp_GOST_Crypt_Step_fu_603_p_din2 = GOST_Key_q0;

assign grp_GOST_Crypt_Step_fu_603_p_din3 = 1'd0;

assign grp_GOST_Crypt_Step_fu_603_p_start = grp_GOST_Crypt_Step_fu_88_ap_start_reg;

assign grp_GOST_Crypt_Step_fu_88_ap_ready = grp_GOST_Crypt_Step_fu_603_p_ready;

assign icmp_ln79_fu_117_p2 = ((ap_sig_allocacmp_indvar_flatten_load == 5'd24) ? 1'b1 : 1'b0);

assign icmp_ln81_fu_132_p2 = ((ap_sig_allocacmp_j_load == 4'd8) ? 1'b1 : 1'b0);

assign j_2_cast_fu_146_p1 = select_ln74_fu_138_p3;

assign select_ln74_fu_138_p3 = ((icmp_ln81_fu_132_p2[0:0] == 1'b1) ? 4'd0 : ap_sig_allocacmp_j_load);

endmodule //GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_79_1_VITIS_LOOP_81_2