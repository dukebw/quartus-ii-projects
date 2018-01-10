library IEEE;
use IEEE.std_logic_1164.all;

entity ckt1a_tb is
end ckt1a_tb;

architecture behav of ckt1a_tb is
        component ckt1a is
                port (F : out std_logic;
                      A : in std_logic;
                      B : in std_logic);
        end component;

        for ckt1a_0: ckt1a use entity work.ckt1a;
        signal F, A, B : std_logic;
begin
        ckt1a_0: ckt1a port map (F => F, A => A, B => B);

        process
        type pattern_type is record
                A : std_logic;
                B : std_logic;
                F : std_logic;
        end record;

        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
                (('0', '0', '0'),
                 ('0', '1', '1'),
                 ('1', '0', '1'),
                 ('1', '1', '1'));
        begin
                for i in patterns'range loop
                        A <= patterns(i).A;
                        B <= patterns(i).B;

                        wait for 1 ns;
                        assert F = patterns(i).F;
                end loop;
                wait;
        end process;
end behav;
