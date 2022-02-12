library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY Adder IS
GENERIC (N : INTEGER :=64);
PORT(IN1, IN2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
     RST : IN STD_LOGIC;
     OUT_SUM : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF Adder IS
BEGIN
PROCESS(IN1,IN2)
BEGIN

OUT_SUM <= IN1+IN2;

END PROCESS;
END ARCHITECTURE;