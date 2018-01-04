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
