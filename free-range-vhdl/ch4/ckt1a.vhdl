library IEEE;
use IEEE.std_logic_1164.all;

entity ckt1a is
        port (F : out std_logic;
              A : in std_logic;
              B : in std_logic);
end ckt1a;

architecture arch_ckt1a of ckt1a is
begin
        F <= ((not A) and B) or A or (A and (not B));
end arch_ckt1a;
