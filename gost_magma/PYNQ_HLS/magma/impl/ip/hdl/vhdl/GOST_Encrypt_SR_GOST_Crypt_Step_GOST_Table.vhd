-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity GOST_Encrypt_SR_GOST_Crypt_Step_GOST_Table is 
    generic(
             DataWidth     : integer := 4; 
             AddressWidth     : integer := 7; 
             AddressRange    : integer := 128
    ); 
    port (
          address0      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DataWidth-1 downto 0);
          address1      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce1       : in std_logic; 
          q1         : out std_logic_vector(DataWidth-1 downto 0);
          address2      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce2       : in std_logic; 
          q2         : out std_logic_vector(DataWidth-1 downto 0);
          address3      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce3       : in std_logic; 
          q3         : out std_logic_vector(DataWidth-1 downto 0);
          address4      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce4       : in std_logic; 
          q4         : out std_logic_vector(DataWidth-1 downto 0);
          address5      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce5       : in std_logic; 
          q5         : out std_logic_vector(DataWidth-1 downto 0);
          address6      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce6       : in std_logic; 
          q6         : out std_logic_vector(DataWidth-1 downto 0);
          address7      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce7       : in std_logic; 
          q7         : out std_logic_vector(DataWidth-1 downto 0);
          reset     : in std_logic;
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of GOST_Encrypt_SR_GOST_Crypt_Step_GOST_Table is 

signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address1_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address2_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address3_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address4_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address5_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address6_tmp : std_logic_vector(AddressWidth-1 downto 0); 
signal address7_tmp : std_logic_vector(AddressWidth-1 downto 0); 
type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 
signal mem0 : mem_array := (
    0 => "0100", 1 => "0010", 2 => "1111", 3 => "0101", 4 => "1001", 
    5 => "0001", 6 => "0000", 7 => "1000", 8 => "1110", 9 => "0011", 
    10 => "1011", 11 => "1100", 12 => "1101", 13 => "0111", 14 => "1010", 
    15 => "0110", 16 => "1100", 17 => "1001", 18 => "1111", 19 => "1110", 
    20 => "1000", 21 => "0001", 22 => "0011", 23 => "1010", 24 => "0010", 
    25 => "0111", 26 => "0100", 27 => "1101", 28 => "0110", 29 => "0000", 
    30 => "1011", 31 => "0101", 32 => "1101", 33 => "1000", 34 => "1110", 
    35 => "1100", 36 => "0111", 37 => "0011", 38 => "1001", 39 => "1010", 
    40 => "0001", 41 => "0101", 42 => "0010", 43 => "0100", 44 => "0110", 
    45 => "1111", 46 => "0000", 47 => "1011", 48 => "1110", 49 => "1001", 
    50 => "1011", 51 => "0010", 52 => "0101", 53 => "1111", 54 => "0111", 
    55 => "0001", 56 => "0000", 57 => "1101", 58 => "1100", 59 => "0110", 
    60 => "1010", 61 => "0100", 62 => "0011", 63 => "1000", 64 => "0011", 
    65 => "1110", 66 => "0101", 67 => "1001", 68 => "0110", 69 => "1000", 
    70 => "0000", 71 => "1101", 72 => "1010", 73 => "1011", 74 => "0111", 
    75 => "1100", 76 => "0010", 77 => "0001", 78 => "1111", 79 => "0100", 
    80 => "1000", 81 => "1111", 82 => "0110", 83 => "1011", 84 => "0001", 
    85 => "1001", 86 => "1100", 87 => "0101", 88 => "1101", 89 => "0011", 
    90 => "0111", 91 => "1010", 92 => "0000", 93 => "1110", 94 => "0010", 
    95 => "0100", 96 => "1001", 97 => "1011", 98 => "1100", 99 => "0000", 
    100 => "0011", 101 => "0110", 102 => "0111", 103 => "0101", 104 => "0100", 
    105 => "1000", 106 => "1110", 107 => "1111", 108 => "0001", 109 => "1010", 
    110 => "0010", 111 => "1101", 112 => "1100", 113 => "0110", 114 => "0101", 
    115 => "0010", 116 => "1011", 117 => "0000", 118 => "1001", 119 => "1101", 
    120 => "0011", 121 => "1110", 122 => "0111", 123 => "1010", 124 => "1111", 
    125 => "0100", 126 => "0001", 127 => "1000" );
signal mem1 : mem_array := (
    0 => "0100", 1 => "0010", 2 => "1111", 3 => "0101", 4 => "1001", 
    5 => "0001", 6 => "0000", 7 => "1000", 8 => "1110", 9 => "0011", 
    10 => "1011", 11 => "1100", 12 => "1101", 13 => "0111", 14 => "1010", 
    15 => "0110", 16 => "1100", 17 => "1001", 18 => "1111", 19 => "1110", 
    20 => "1000", 21 => "0001", 22 => "0011", 23 => "1010", 24 => "0010", 
    25 => "0111", 26 => "0100", 27 => "1101", 28 => "0110", 29 => "0000", 
    30 => "1011", 31 => "0101", 32 => "1101", 33 => "1000", 34 => "1110", 
    35 => "1100", 36 => "0111", 37 => "0011", 38 => "1001", 39 => "1010", 
    40 => "0001", 41 => "0101", 42 => "0010", 43 => "0100", 44 => "0110", 
    45 => "1111", 46 => "0000", 47 => "1011", 48 => "1110", 49 => "1001", 
    50 => "1011", 51 => "0010", 52 => "0101", 53 => "1111", 54 => "0111", 
    55 => "0001", 56 => "0000", 57 => "1101", 58 => "1100", 59 => "0110", 
    60 => "1010", 61 => "0100", 62 => "0011", 63 => "1000", 64 => "0011", 
    65 => "1110", 66 => "0101", 67 => "1001", 68 => "0110", 69 => "1000", 
    70 => "0000", 71 => "1101", 72 => "1010", 73 => "1011", 74 => "0111", 
    75 => "1100", 76 => "0010", 77 => "0001", 78 => "1111", 79 => "0100", 
    80 => "1000", 81 => "1111", 82 => "0110", 83 => "1011", 84 => "0001", 
    85 => "1001", 86 => "1100", 87 => "0101", 88 => "1101", 89 => "0011", 
    90 => "0111", 91 => "1010", 92 => "0000", 93 => "1110", 94 => "0010", 
    95 => "0100", 96 => "1001", 97 => "1011", 98 => "1100", 99 => "0000", 
    100 => "0011", 101 => "0110", 102 => "0111", 103 => "0101", 104 => "0100", 
    105 => "1000", 106 => "1110", 107 => "1111", 108 => "0001", 109 => "1010", 
    110 => "0010", 111 => "1101", 112 => "1100", 113 => "0110", 114 => "0101", 
    115 => "0010", 116 => "1011", 117 => "0000", 118 => "1001", 119 => "1101", 
    120 => "0011", 121 => "1110", 122 => "0111", 123 => "1010", 124 => "1111", 
    125 => "0100", 126 => "0001", 127 => "1000" );
signal mem2 : mem_array := (
    0 => "0100", 1 => "0010", 2 => "1111", 3 => "0101", 4 => "1001", 
    5 => "0001", 6 => "0000", 7 => "1000", 8 => "1110", 9 => "0011", 
    10 => "1011", 11 => "1100", 12 => "1101", 13 => "0111", 14 => "1010", 
    15 => "0110", 16 => "1100", 17 => "1001", 18 => "1111", 19 => "1110", 
    20 => "1000", 21 => "0001", 22 => "0011", 23 => "1010", 24 => "0010", 
    25 => "0111", 26 => "0100", 27 => "1101", 28 => "0110", 29 => "0000", 
    30 => "1011", 31 => "0101", 32 => "1101", 33 => "1000", 34 => "1110", 
    35 => "1100", 36 => "0111", 37 => "0011", 38 => "1001", 39 => "1010", 
    40 => "0001", 41 => "0101", 42 => "0010", 43 => "0100", 44 => "0110", 
    45 => "1111", 46 => "0000", 47 => "1011", 48 => "1110", 49 => "1001", 
    50 => "1011", 51 => "0010", 52 => "0101", 53 => "1111", 54 => "0111", 
    55 => "0001", 56 => "0000", 57 => "1101", 58 => "1100", 59 => "0110", 
    60 => "1010", 61 => "0100", 62 => "0011", 63 => "1000", 64 => "0011", 
    65 => "1110", 66 => "0101", 67 => "1001", 68 => "0110", 69 => "1000", 
    70 => "0000", 71 => "1101", 72 => "1010", 73 => "1011", 74 => "0111", 
    75 => "1100", 76 => "0010", 77 => "0001", 78 => "1111", 79 => "0100", 
    80 => "1000", 81 => "1111", 82 => "0110", 83 => "1011", 84 => "0001", 
    85 => "1001", 86 => "1100", 87 => "0101", 88 => "1101", 89 => "0011", 
    90 => "0111", 91 => "1010", 92 => "0000", 93 => "1110", 94 => "0010", 
    95 => "0100", 96 => "1001", 97 => "1011", 98 => "1100", 99 => "0000", 
    100 => "0011", 101 => "0110", 102 => "0111", 103 => "0101", 104 => "0100", 
    105 => "1000", 106 => "1110", 107 => "1111", 108 => "0001", 109 => "1010", 
    110 => "0010", 111 => "1101", 112 => "1100", 113 => "0110", 114 => "0101", 
    115 => "0010", 116 => "1011", 117 => "0000", 118 => "1001", 119 => "1101", 
    120 => "0011", 121 => "1110", 122 => "0111", 123 => "1010", 124 => "1111", 
    125 => "0100", 126 => "0001", 127 => "1000" );
signal mem3 : mem_array := (
    0 => "0100", 1 => "0010", 2 => "1111", 3 => "0101", 4 => "1001", 
    5 => "0001", 6 => "0000", 7 => "1000", 8 => "1110", 9 => "0011", 
    10 => "1011", 11 => "1100", 12 => "1101", 13 => "0111", 14 => "1010", 
    15 => "0110", 16 => "1100", 17 => "1001", 18 => "1111", 19 => "1110", 
    20 => "1000", 21 => "0001", 22 => "0011", 23 => "1010", 24 => "0010", 
    25 => "0111", 26 => "0100", 27 => "1101", 28 => "0110", 29 => "0000", 
    30 => "1011", 31 => "0101", 32 => "1101", 33 => "1000", 34 => "1110", 
    35 => "1100", 36 => "0111", 37 => "0011", 38 => "1001", 39 => "1010", 
    40 => "0001", 41 => "0101", 42 => "0010", 43 => "0100", 44 => "0110", 
    45 => "1111", 46 => "0000", 47 => "1011", 48 => "1110", 49 => "1001", 
    50 => "1011", 51 => "0010", 52 => "0101", 53 => "1111", 54 => "0111", 
    55 => "0001", 56 => "0000", 57 => "1101", 58 => "1100", 59 => "0110", 
    60 => "1010", 61 => "0100", 62 => "0011", 63 => "1000", 64 => "0011", 
    65 => "1110", 66 => "0101", 67 => "1001", 68 => "0110", 69 => "1000", 
    70 => "0000", 71 => "1101", 72 => "1010", 73 => "1011", 74 => "0111", 
    75 => "1100", 76 => "0010", 77 => "0001", 78 => "1111", 79 => "0100", 
    80 => "1000", 81 => "1111", 82 => "0110", 83 => "1011", 84 => "0001", 
    85 => "1001", 86 => "1100", 87 => "0101", 88 => "1101", 89 => "0011", 
    90 => "0111", 91 => "1010", 92 => "0000", 93 => "1110", 94 => "0010", 
    95 => "0100", 96 => "1001", 97 => "1011", 98 => "1100", 99 => "0000", 
    100 => "0011", 101 => "0110", 102 => "0111", 103 => "0101", 104 => "0100", 
    105 => "1000", 106 => "1110", 107 => "1111", 108 => "0001", 109 => "1010", 
    110 => "0010", 111 => "1101", 112 => "1100", 113 => "0110", 114 => "0101", 
    115 => "0010", 116 => "1011", 117 => "0000", 118 => "1001", 119 => "1101", 
    120 => "0011", 121 => "1110", 122 => "0111", 123 => "1010", 124 => "1111", 
    125 => "0100", 126 => "0001", 127 => "1000" );


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

memory_access_guard_1: process (address1) 
begin
      address1_tmp <= address1;
--synthesis translate_off
      if (CONV_INTEGER(address1) > AddressRange-1) then
           address1_tmp <= (others => '0');
      else 
           address1_tmp <= address1;
      end if;
--synthesis translate_on
end process;

memory_access_guard_2: process (address2) 
begin
      address2_tmp <= address2;
--synthesis translate_off
      if (CONV_INTEGER(address2) > AddressRange-1) then
           address2_tmp <= (others => '0');
      else 
           address2_tmp <= address2;
      end if;
--synthesis translate_on
end process;

memory_access_guard_3: process (address3) 
begin
      address3_tmp <= address3;
--synthesis translate_off
      if (CONV_INTEGER(address3) > AddressRange-1) then
           address3_tmp <= (others => '0');
      else 
           address3_tmp <= address3;
      end if;
--synthesis translate_on
end process;

memory_access_guard_4: process (address4) 
begin
      address4_tmp <= address4;
--synthesis translate_off
      if (CONV_INTEGER(address4) > AddressRange-1) then
           address4_tmp <= (others => '0');
      else 
           address4_tmp <= address4;
      end if;
--synthesis translate_on
end process;

memory_access_guard_5: process (address5) 
begin
      address5_tmp <= address5;
--synthesis translate_off
      if (CONV_INTEGER(address5) > AddressRange-1) then
           address5_tmp <= (others => '0');
      else 
           address5_tmp <= address5;
      end if;
--synthesis translate_on
end process;

memory_access_guard_6: process (address6) 
begin
      address6_tmp <= address6;
--synthesis translate_off
      if (CONV_INTEGER(address6) > AddressRange-1) then
           address6_tmp <= (others => '0');
      else 
           address6_tmp <= address6;
      end if;
--synthesis translate_on
end process;

memory_access_guard_7: process (address7) 
begin
      address7_tmp <= address7;
--synthesis translate_off
      if (CONV_INTEGER(address7) > AddressRange-1) then
           address7_tmp <= (others => '0');
      else 
           address7_tmp <= address7;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem0(CONV_INTEGER(address0_tmp)); 
        end if;
        if (ce1 = '1') then 
            q1 <= mem0(CONV_INTEGER(address1_tmp)); 
        end if;
        if (ce2 = '1') then 
            q2 <= mem1(CONV_INTEGER(address2_tmp)); 
        end if;
        if (ce3 = '1') then 
            q3 <= mem1(CONV_INTEGER(address3_tmp)); 
        end if;
        if (ce4 = '1') then 
            q4 <= mem2(CONV_INTEGER(address4_tmp)); 
        end if;
        if (ce5 = '1') then 
            q5 <= mem2(CONV_INTEGER(address5_tmp)); 
        end if;
        if (ce6 = '1') then 
            q6 <= mem3(CONV_INTEGER(address6_tmp)); 
        end if;
        if (ce7 = '1') then 
            q7 <= mem3(CONV_INTEGER(address7_tmp)); 
        end if;
    end if;
end process;

end rtl;

