# Exercises and Examples


## Chapter 4 Examples


1.

```
        +--------+
A +---->+        |
        |        |
B +---->+  NAND  +----> F
        |        |
C +---->+        |
        +--------+
```

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity nand is
        port (F : out std_logic;
              A : in std_logic;
              B : in std_logic;
              C : in std_logic);
end nand;

architecture nand_arch of nand is
begin
        F <= not (A and B and C);
end nand_arch;
```


3.

```
       +-------+
L +--->+       |
       |       |
M +--->+       +--> F3
       |       |
N +--->+       |
       +-------+
```

```vhdl
entity my_ent is
        port (F3 : out std_logic;
              L : in std_logic;
              M : in std_logic;
              N : in std_logic);
end my_ent;

architecture my_arch of my_ent is
begin
        F3 <= '1' when ((L = '1') and (M = '1')) else
              '1' when ((L = '0') and (M = '0') and (N = '1')) else
              '0';
end my_arch;
```


4.

```
         +-----------+
 D0 +--->+           |
         |           |
 D1 +--->+           |
         |           |
 D2 +--->+   MUX     +--> MX_OUT
         |           |
 D3 +--->+           |
         |           |
      2  |           |
SEL +-X->+           |
         |           |
         +-----------+
```

```vhdl
entity mux is
        port (MX_OUT : out std_logic;
              D0, D1, D2, D3 : in std_logic;
              SEL : in std_logic_vector(1 downto 0));
end mux;

architecture mux_arch of mux is
begin
        MX_OUT <= D0 when (SEL == "00") else
                  D1 when (SEL == "01") else
                  D2 when (SEL == "10") else
                  D3 when (SEL == "11") else
                  '0';
end mux_arch;
```


5. The black box diagram is the same as in example 3.

```vhdl
entity my_ent is
        port (F3 : out std_logic;
              L : in std_logic;
              M : in std_logic;
              N : in std_logic);
end my_ent;

architecture my_arch of my_ent is
begin
        with ((L = '0') and (M = '0') and (N = '1')) or ((L = '1') and (M = '1'))) select
                F3 <= '1' when '1',
                      '0' when '0',
                      '0' when others;
end my_arch;
```


6. The black box diagram is the same as in example 4.

```vhdl
entity mux is
        port (MX_OUT : out std_logic;
              D0, D1, D2, D3 : in std_logic;
              SEL : in std_logic_vector(1 downto 0));
end mux;

architecture mux_arch of mux is
begin
        with SEL select
                MX_OUT <= D0 when "00",
                          D1 when "01",
                          D2 when "10",
                          D3 when "11",
                          '0' when others;
end mux_arch;
```


7.

```
          +-----+
       4  |     | 3
D_IN +-X->+ DEC +-X-> SZ_OUT
          |     |
          +-----+
```

```vhdl
entity decoder is
        port (SZ_OUT : out std_logic_vector(2 downto 0);
              D_IN : in std_logic_vector(3 downto 0));
end decoder;

architecture dec_arch of decoder is
begin
        with D_IN select
                -- The vertical bar is used as a selection operation in the
                -- choices section of the selected signal assignment statement.
                "100" when "0000" | "0001" | "0010" | "0011",
                "010" when "0100" | "0101" | "0110" | "0111" | "1000" | "1001",
                "001" when "1010" | "1011" | "1100" | "1101" | "1111",
                "000" when others;
end dec_arch;
```


8. Example 3, using concatenation and the selected signal assignment statement.

```vhdl
entity my_ent is
        port (F3 : out std_logic;
              L : in std_logic;
              M : in std_logic;
              N : in std_logic);
end my_ent;

architecture my_arch of my_ent is
        -- local bundle declaration
        signal cat_in : std_logic_vector(2 downto 0);
begin
        cat_in <= L & M & N;  -- & concatenation operator

        with cat_in select
                '1' when "110" | "111" | "001",
                '0' when others;
end my_arch;
```


## Chapter 4 Exercises


In the following, '.' represents logical AND, and '+' represents logical OR.
1.

a) F(A, B) = ~A.B + A + A.~B

```
        +-------+
        |       |
A +---->+ ckt1a +---> F
        |       |
B +---->+       |
        +-------+
```

See ckt1a.vhdl.
