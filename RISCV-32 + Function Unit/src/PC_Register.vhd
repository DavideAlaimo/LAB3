library ieee;
use ieee.std_logic_1164.all;

ENTITY PC_Register IS

PORT(DATA_IN : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
     CLK, RST, EN : IN STD_LOGIC;
     DATA_OUT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END ENTITY;


ARCHITECTURE BEH OF PC_Register IS
BEGIN

PROCESS(CLK, RST)
BEGIN
IF(RST='1') THEN DATA_OUT<=X"0000000000400000";
        ELSIF(CLK'event  and  CLK='1') then 
	       IF(EN='1') THEN 
               DATA_OUT<=DATA_IN;
               END IF;
   END IF;

END PROCESS;
END ARCHITECTURE;
