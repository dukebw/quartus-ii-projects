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
