library IEEE;
use IEEE.std_logic_1164.all;

entity ckt6 is
        port (decoded : out std_logic_vector(7 downto 0);
              input : in std_logic_vector(2 downto 0));
end ckt6;

-- 3:8 decoder using conditional signal assignment and selected signal
-- assignment.
architecture ckt6_arch of ckt6 is
begin
        -- conditional
        decoded <= "10000000" when (input = "000") else
                   "01000000" when (input = "001") else
                   "00100000" when (input = "010") else
                   "00010000" when (input = "011") else
                   "00001000" when (input = "100") else
                   "00000100" when (input = "101") else
                   "00000010" when (input = "110") else
                   "00000001" when (input = "111") else
                   "00000000";

        -- selected
        with input select
                decoded <= "10000000" when "000",
                           "01000000" when "001",
                           "00100000" when "010",
                           "00010000" when "011",
                           "00001000" when "100",
                           "00000100" when "101",
                           "00000010" when "110",
                           "00000001" when "111",
                           "00000000" when others;
end ckt6_arch;
