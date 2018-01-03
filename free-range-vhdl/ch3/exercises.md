# Exercises and Examples


## Chapter 3 Exercises


1. _Bundle_ refers to a grouped set of signals (sharing a similar purpose),
   alternatively referred to as _bus_.

2. Bundles in black-box diagrams are represented with a line and a number.

3. Always draw a black box diagram when using VHDL to model digital circuits,
   because diagrams convey information effectively compared to written (coded)
   interfaces.

4. Interface for black-box below:

   a)

```
   a_in1 +---->+----------+
               |          |
   b_in2 +---->+          +----> out_b
               |   sys1   |
    clk  +---->+          |
               |          |
ctrl_int +---->+          |
               +----------+
```

```vhdl
entity my_ent is
        port (out_b : out std_logic;
              a_in1 : in std_logic;
              b_in2 : in std_logic;
              clk : in std_logic;
              ctrl_int : in std_logic);
end my_ent;
```

   b)

```
                +---------+
input_w +------>+         |
                |         |
           8    |         |  8
 a_data +--X--->+         +--X--> dat_4
                |   sys2  |
           8    |         |  3
 b_data +--X--->+         +--X--> dat_5
                |         |
                |         |
   clk  +------>+         |
                +---------+
```

```vhdl
entity my_ent is
        port (dat_4 : out std_logic_vector(7 downto 0);
              dat_5 : out std_logic_vector(2 downto 0);
              input_w : in std_logic;
              a_data : in std_logic_vector(7 downto 0);
              b_data : in std_logic_vector(7 downto 0);
              clk : in std_logic);
end my_ent;
```


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
