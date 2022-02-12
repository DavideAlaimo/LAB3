library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;



ENTITY ALU IS
PORT(IN1, IN2 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
OP: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
Zero : OUT STD_LOGIC;
OUT_ALU : BUFFER STD_LOGIC_VECTOR(63 DOWNTO 0));
END ENTITY;



ARCHITECTURE BEH OF ALU IS



SIGNAL ZERO_FLAG:STD_LOGIC;
SIGNAL OUT_RESULT : STD_LOGIC_VECTOR(63 DOWNTO 0):=(OTHERS=>'0');
BEGIN


--OUT_RESULT<=(OTHERS=>'0');
PROCESS(IN1,IN2,OP)


VARIABLE DATA_ZERO: STD_LOGIC_VECTOR(63 DOWNTO 0);
VARIABLE DATA_IN_SIGNED : SIGNED(63 DOWNTO 0);
VARIABLE DATA_OUT_SHIFT : SIGNED(63 DOWNTO 0);
VARIABLE AMOUT_SHIFT : INTEGER RANGE 0 TO 31;


BEGIN
OUT_RESULT<=(OTHERS=>'0');
CASE(OP) IS
WHEN "000" => OUT_RESULT <= IN1+IN2; --SUM



WHEN "111" => OUT_RESULT <= IN1 AND IN2; --AND



WHEN "100" => OUT_RESULT <= IN1 XOR IN2; --XOR



WHEN "101" =>
DATA_IN_SIGNED:=SIGNED(IN1);
AMOUT_SHIFT:=TO_INTEGER(UNSIGNED(IN2(4 downto 0)));
DATA_OUT_SHIFT := SHIFT_RIGHT(DATA_IN_SIGNED,AMOUT_SHIFT);
OUT_RESULT <= STD_LOGIC_VECTOR(DATA_OUT_SHIFT); --RIGHT SHIFT



WHEN "010" =>
DATA_ZERO := IN1-IN2;


IF(DATA_ZERO(63)='0') THEN OUT_RESULT <= x"0000000000000000";
ELSIF(DATA_ZERO(63)='1') THEN OUT_RESULT <= x"0000000000000001";
END IF; -------------------------SLT


WHEN OTHERS => OUT_RESULT <= IN1+IN2;


END CASE;
END PROCESS;

OUT_ALU<=OUT_RESULT;

PROCESS(OUT_RESULT)
BEGIN
CASE(OUT_RESULT) IS
WHEN x"0000000000000000" => ZERO_FLAG<='1';
WHEN OTHERS => ZERO_FLAG<='0';
END CASE;
END PROCESS;


Zero<=ZERO_FLAG;


END ARCHITECTURE;
