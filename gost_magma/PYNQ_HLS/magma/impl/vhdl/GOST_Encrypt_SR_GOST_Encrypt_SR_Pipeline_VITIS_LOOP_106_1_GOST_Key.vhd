-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_106_1_GOST_Key is 
    generic(
             DataWidth     : integer := 32; 
             AddressWidth     : integer := 3; 
             AddressRange    : integer := 8
    ); 
    port (
          address0      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DataWidth-1 downto 0);
          reset     : in std_logic;
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of GOST_Encrypt_SR_GOST_Encrypt_SR_Pipeline_VITIS_LOOP_106_1_GOST_Key is 

signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 
type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 
signal mem : mem_array := (
    0 => "11100000111101100111010100000100", 
    1 => "11111010111110110011100001010000", 
    2 => "10010000110000111100011111010010", 
    3 => "00111101110010101011001111101101", 
    4 => "01000010000100100100011100010101", 
    5 => "10001010000111101010111010010001", 
    6 => "10011110110011010111100100101111", 
    7 => "10111101111011111011110011010010" );


begin 


memory_access_guard_0: process (address0) 
begin
      address0_tmp <= address0;
--synthesis translate_off
      if (CONV_INTEGER(address0) > AddressRange-1) then
           address0_tmp <= (others => '0');
      else 
           address0_tmp <= address0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(address0_tmp)); 
        end if;
    end if;
end process;

end rtl;

