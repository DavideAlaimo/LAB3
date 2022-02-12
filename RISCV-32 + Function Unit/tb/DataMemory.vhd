
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


ENTITY DataMemory IS
PORT(ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     CLK, RST, MemWrite, MemRead : IN STD_LOGIC;
     ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF DataMemory IS
TYPE CELL IS ARRAY (0 TO 127) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL CELLS : CELL;
BEGIN

PROCESS(CLK,RST)
VARIABLE ADDRESS_CELL : INTEGER RANGE 0 TO 7;
BEGIN
IF(RST='1') THEN 
	CELLS(0) <= x"0000000A"; --00
	CELLS(1) <= x"FFFFFFD1"; --04
	CELLS(2) <= x"00000016"; --08
	CELLS(3) <= x"FFFFFFFD"; --0C
	CELLS(4) <= x"0000000F"; --10
	CELLS(5) <= x"0000001B"; --14
	CELLS(6) <= x"FFFFFFFC"; --18
	CELLS(7) <= x"00000000"; --1C
	for item in 8 to 127 loop
	CELLS(item)<=x"00000000";
	end loop;

ELSIF (CLK'EVENT AND CLK='1') then
     if (MemRead='1') then   
     ReadData<=CELLS(TO_INTEGER(UNSIGNED(ADDRESS(15 DOWNTO 2))));
     end if;

     if (MemWrite='1') then
        CELLS(TO_INTEGER(UNSIGNED(ADDRESS(15 DOWNTO 2))))<=WriteData;

end if;

end if;
END PROCESS;
END ARCHITECTURE;