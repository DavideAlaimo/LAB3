library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY RegistersFile IS
PORT(ReadReg1, ReadReg2, WriteReg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
WriteData : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
CLK, RegWrite, RST : IN STD_LOGIC;
ReadData1, ReadData2 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE BEH OF RegistersFile IS
TYPE REGISTERS IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL DATA_REGISTER : REGISTERS;

BEGIN


PROCESS (CLK,RST,ReadReg1, ReadReg2)

VARIABLE ADDRESS_READ_REG1, ADDRESS_READ_REG2, ADDRESS_WRITE_REG : INTEGER RANGE 0 TO 31;

BEGIN

ADDRESS_READ_REG1 := TO_INTEGER(UNSIGNED(ReadReg1));
ADDRESS_READ_REG2 := TO_INTEGER(UNSIGNED(ReadReg2));
ReadData1 <= DATA_REGISTER(ADDRESS_READ_REG1);
ReadData2 <= DATA_REGISTER(ADDRESS_READ_REG2);


IF(RST='1') THEN 
  
     DATA_REGISTER<=(OTHERS=>(OTHERS=>'0'));
      
		ELSIF(CLK'EVENT AND CLK='1') THEN

             IF(RegWrite='1') THEN 
				 ADDRESS_WRITE_REG := TO_INTEGER(UNSIGNED(WriteReg));
             DATA_REGISTER(ADDRESS_WRITE_REG) <= WriteData;
             END IF;

	END IF;

	
	END PROCESS;

END ARCHITECTURE;