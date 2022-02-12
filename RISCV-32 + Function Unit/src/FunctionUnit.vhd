library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

ENTITY FunctionUnit IS
PORT(EN_FUNCT : IN STD_LOGIC;
     DATA_IN : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
     DATA_OUT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF FunctionUnit is

BEGIN
PROCESS(DATA_IN,EN_FUNCT)
VARIABLE SIGN,SIGN_EXTENDED: STD_LOGIC_VECTOR(63 DOWNTO 0);
VARIABLE INPUT_COMPLEMENTED : STD_LOGIC_VECTOR(63 DOWNTO 0);
VARIABLE SUM : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN
DATA_OUT<=(OTHERS=>'0');
IF(EN_FUNCT='1') THEN 
SIGN(0):=DATA_IN(63);
SIGN(63 DOWNTO 1):=(OTHERS=>'0');
SIGN_EXTENDED:=(OTHERS=>SIGN(0));
INPUT_COMPLEMENTED:= DATA_IN XOR SIGN_EXTENDED;
SUM:=INPUT_COMPLEMENTED+SIGN;
DATA_OUT<=SUM;
END IF;
END PROCESS;
END ARCHITECTURE;

