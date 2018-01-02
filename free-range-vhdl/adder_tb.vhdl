-- Testbench for adder.
entity adder_tb is
end adder_tb;

architecture behav of adder_tb is
        component adder
                port (s : out bit;
                      co : out bit;
                      i0 : in bit;
                      i1 : in bit;
                      ci : in bit);
        end component;

        for adder_0: adder use entity work.adder;
        signal s, co, i0, i1, ci : bit;
begin
        adder_0: adder port map (s => s, co => co, i0 => i0, i1 => i1,
                                 ci => ci);

        process
                type pattern_type is record
                        s, co : bit;
                        i0, i1, ci : bit;
                end record;

                type pattern_array is array (natural range <>) of pattern_type;
                constant patterns : pattern_array :=
                        (('0', '0', '0', '0', '0'),
                         ('0', '0', '1', '1', '0'),
                         ('0', '1', '0', '1', '0'),
                         ('0', '1', '1', '0', '1'),
                         ('1', '0', '0', '1', '0'),
                         ('1', '0', '1', '0', '1'),
                         ('1', '1', '0', '0', '1'),
                         ('1', '1', '1', '1', '1'));
        begin
                for i in patterns'range loop
                        i0 <= patterns(i).i0;
                        i1 <= patterns(i).i1;
                        ci <= patterns(i).ci;

                        wait for 1 ns;
                end loop;
                wait;
        end process;
end behav;
