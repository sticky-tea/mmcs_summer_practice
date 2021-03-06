-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_112_2_VITIS_LOOP_114_3 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    Data_prep_323_reload : IN STD_LOGIC_VECTOR (63 downto 0);
    Data_prep_5_out : OUT STD_LOGIC_VECTOR (63 downto 0);
    Data_prep_5_out_ap_vld : OUT STD_LOGIC;
    grp_GOST_Crypt_Step_fu_213_p_din1 : OUT STD_LOGIC_VECTOR (63 downto 0);
    grp_GOST_Crypt_Step_fu_213_p_din2 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_GOST_Crypt_Step_fu_213_p_din3 : OUT STD_LOGIC_VECTOR (0 downto 0);
    grp_GOST_Crypt_Step_fu_213_p_dout0 : IN STD_LOGIC_VECTOR (63 downto 0);
    grp_GOST_Crypt_Step_fu_213_p_ce : OUT STD_LOGIC;
    grp_GOST_Crypt_Step_fu_213_p_start : OUT STD_LOGIC;
    grp_GOST_Crypt_Step_fu_213_p_ready : IN STD_LOGIC;
    grp_GOST_Crypt_Step_fu_213_p_done : IN STD_LOGIC;
    grp_GOST_Crypt_Step_fu_213_p_idle : IN STD_LOGIC );
end;


architecture behav of GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_112_2_VITIS_LOOP_114_3 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_lv5_10 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv5_1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_const_lv4_F : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    constant ap_const_lv4_8 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal icmp_ln112_fu_132_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal GOST_Key_address0 : STD_LOGIC_VECTOR (2 downto 0);
    signal GOST_Key_ce0 : STD_LOGIC;
    signal GOST_Key_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal icmp_ln112_reg_258 : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_GOST_Crypt_Step_fu_98_ap_ready : STD_LOGIC;
    signal grp_GOST_Crypt_Step_fu_98_ap_start_reg : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal zext_ln117_fu_182_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal j_fu_56 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal ap_sig_allocacmp_j_load : STD_LOGIC_VECTOR (3 downto 0);
    signal select_ln114_fu_193_p3 : STD_LOGIC_VECTOR (3 downto 0);
    signal indvars_iv_fu_60 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_sig_allocacmp_indvars_iv_load : STD_LOGIC_VECTOR (3 downto 0);
    signal select_ln116_fu_162_p3 : STD_LOGIC_VECTOR (3 downto 0);
    signal Data_prep_fu_64 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_sig_allocacmp_Data_prep_load_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal indvar_flatten7_fu_68 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_sig_allocacmp_indvar_flatten7_load : STD_LOGIC_VECTOR (4 downto 0);
    signal add_ln112_fu_138_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal icmp_ln114_fu_156_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln116_fu_150_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal trunc_ln117_fu_170_p1 : STD_LOGIC_VECTOR (2 downto 0);
    signal and_ln_fu_174_p3 : STD_LOGIC_VECTOR (4 downto 0);
    signal add_ln114_fu_187_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter1_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component GOST_Encrypt_SR_GOST_Crypt_Step IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_ce : IN STD_LOGIC;
        Data_prep_read : IN STD_LOGIC_VECTOR (63 downto 0);
        GOST_Key : IN STD_LOGIC_VECTOR (31 downto 0);
        Last : IN STD_LOGIC_VECTOR (0 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (63 downto 0) );
    end component;


    component GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_106_1_GOST_Key IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (2 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component GOST_Encrypt_SR_flow_control_loop_pipe_sequential_init IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC );
    end component;



begin
    GOST_Key_U : component GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_106_1_GOST_Key
    generic map (
        DataWidth => 32,
        AddressRange => 8,
        AddressWidth => 3)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => GOST_Key_address0,
        ce0 => GOST_Key_ce0,
        q0 => GOST_Key_q0);

    flow_control_loop_pipe_sequential_init_U : component GOST_Encrypt_SR_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage0,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage0)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start_int;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    grp_GOST_Crypt_Step_fu_98_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_GOST_Crypt_Step_fu_98_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    grp_GOST_Crypt_Step_fu_98_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_GOST_Crypt_Step_fu_98_ap_ready = ap_const_logic_1)) then 
                    grp_GOST_Crypt_Step_fu_98_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    Data_prep_fu_64_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
                    Data_prep_fu_64 <= Data_prep_323_reload;
                elsif ((ap_enable_reg_pp0_iter2 = ap_const_logic_1)) then 
                    Data_prep_fu_64 <= grp_GOST_Crypt_Step_fu_213_p_dout0;
                end if;
            end if; 
        end if;
    end process;

    indvar_flatten7_fu_68_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln112_fu_132_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    indvar_flatten7_fu_68 <= add_ln112_fu_138_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    indvar_flatten7_fu_68 <= ap_const_lv5_0;
                end if;
            end if; 
        end if;
    end process;

    indvars_iv_fu_60_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln112_fu_132_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    indvars_iv_fu_60 <= select_ln116_fu_162_p3;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    indvars_iv_fu_60 <= ap_const_lv4_0;
                end if;
            end if; 
        end if;
    end process;

    j_fu_56_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln112_fu_132_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    j_fu_56 <= select_ln114_fu_193_p3;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    j_fu_56 <= ap_const_lv4_0;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
                icmp_ln112_reg_258 <= icmp_ln112_fu_132_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    Data_prep_5_out <= Data_prep_fu_64;

    Data_prep_5_out_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, icmp_ln112_reg_258)
    begin
        if (((icmp_ln112_reg_258 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            Data_prep_5_out_ap_vld <= ap_const_logic_1;
        else 
            Data_prep_5_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    GOST_Key_address0 <= zext_ln117_fu_182_p1(3 - 1 downto 0);

    GOST_Key_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            GOST_Key_ce0 <= ap_const_logic_1;
        else 
            GOST_Key_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    add_ln112_fu_138_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_indvar_flatten7_load) + unsigned(ap_const_lv5_1));
    add_ln114_fu_187_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_j_load) + unsigned(ap_const_lv4_1));
    add_ln116_fu_150_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_indvars_iv_load) + unsigned(ap_const_lv4_F));
    and_ln_fu_174_p3 <= (ap_const_lv2_0 & trunc_ln117_fu_170_p1);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_exit_pp0_iter0_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, icmp_ln112_fu_132_p2)
    begin
        if (((icmp_ln112_fu_132_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_subdone, ap_done_reg, ap_loop_exit_ready_pp0_iter1_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start_int;

    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_idle_pp0 = ap_const_logic_1) and (ap_start_int = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage0;

    ap_ready_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_Data_prep_load_3_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0, Data_prep_fu_64, grp_GOST_Crypt_Step_fu_213_p_dout0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            ap_sig_allocacmp_Data_prep_load_3 <= grp_GOST_Crypt_Step_fu_213_p_dout0;
        else 
            ap_sig_allocacmp_Data_prep_load_3 <= Data_prep_fu_64;
        end if; 
    end process;


    ap_sig_allocacmp_indvar_flatten7_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_loop_init, indvar_flatten7_fu_68)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_indvar_flatten7_load <= ap_const_lv5_0;
        else 
            ap_sig_allocacmp_indvar_flatten7_load <= indvar_flatten7_fu_68;
        end if; 
    end process;


    ap_sig_allocacmp_indvars_iv_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_loop_init, indvars_iv_fu_60)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_indvars_iv_load <= ap_const_lv4_0;
        else 
            ap_sig_allocacmp_indvars_iv_load <= indvars_iv_fu_60;
        end if; 
    end process;


    ap_sig_allocacmp_j_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, j_fu_56, ap_loop_init)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_j_load <= ap_const_lv4_0;
        else 
            ap_sig_allocacmp_j_load <= j_fu_56;
        end if; 
    end process;

    grp_GOST_Crypt_Step_fu_213_p_ce <= ap_const_logic_1;
    grp_GOST_Crypt_Step_fu_213_p_din1 <= ap_sig_allocacmp_Data_prep_load_3;
    grp_GOST_Crypt_Step_fu_213_p_din2 <= GOST_Key_q0;
    grp_GOST_Crypt_Step_fu_213_p_din3 <= ap_const_lv1_0;
    grp_GOST_Crypt_Step_fu_213_p_start <= grp_GOST_Crypt_Step_fu_98_ap_start_reg;
    grp_GOST_Crypt_Step_fu_98_ap_ready <= grp_GOST_Crypt_Step_fu_213_p_ready;
    icmp_ln112_fu_132_p2 <= "1" when (ap_sig_allocacmp_indvar_flatten7_load = ap_const_lv5_10) else "0";
    icmp_ln114_fu_156_p2 <= "1" when (ap_sig_allocacmp_j_load = ap_const_lv4_8) else "0";
    select_ln114_fu_193_p3 <= 
        ap_const_lv4_1 when (icmp_ln114_fu_156_p2(0) = '1') else 
        add_ln114_fu_187_p2;
    select_ln116_fu_162_p3 <= 
        ap_const_lv4_F when (icmp_ln114_fu_156_p2(0) = '1') else 
        add_ln116_fu_150_p2;
    trunc_ln117_fu_170_p1 <= select_ln116_fu_162_p3(3 - 1 downto 0);
    zext_ln117_fu_182_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(and_ln_fu_174_p3),64));
end behav;
