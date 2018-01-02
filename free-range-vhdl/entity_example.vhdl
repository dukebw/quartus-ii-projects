-- Listing 3.4, a simple entity/architecture example with standard IEEE library
-- inclusions.
library IEEE;
use IEEE.std_logic_1164.all;  -- basic IEEE library.
use IEEE.numeric_std.all;     -- unsigned type and various arith ops.


entity my_ent is
        port ( A, B, C : in std_logic;
               F : out std_logic );
end my_ent;

architecture my_arch of my_ent is
        signal v1, v2 : std_logic_vector (3 downto 0);
        signal u1 : unsigned (3 downto 0);
        signal i1 : integer;
begin
        u1 <= "1101";
        i1 <= 13;
        v1 <= std_logic_vector(u1);
        v2 <= std_logic_vector(to_unsigned(i1, v2'length));

        F <= NOT (A AND B AND C);
end my_arch;
