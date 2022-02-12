library ieee;
use ieee.std_logic_1164.all;

ENTITY InstructionMemory IS
PORT(ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     CLK ,EN_ISTR_MEM: IN STD_LOGIC;
     INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF InstructionMemory IS
BEGIN
PROCESS(CLK)
BEGIN
IF(CLK'EVENT AND CLK='1' AND EN_ISTR_MEM='1') THEN 

----------------------------ABS VALUE INSTRUCTION------------------------------------------------- 
IF(ADDRESS=x"00400000") THEN  INSTRUCTION <= x"00700813";
ELSIF(ADDRESS=x"00400004") THEN  INSTRUCTION <= x"0fc10217";
ELSIF(ADDRESS=x"00400008") THEN  INSTRUCTION <= x"ffc20213";
ELSIF(ADDRESS=x"0040000c") THEN  INSTRUCTION <= x"0fc10297";
ELSIF(ADDRESS=x"00400010") THEN  INSTRUCTION <= x"01028293";
ELSIF(ADDRESS=x"00400014") THEN  INSTRUCTION <= x"400006b7";
ELSIF(ADDRESS=x"00400018") THEN  INSTRUCTION <= x"fff68693";
ELSIF(ADDRESS=x"0040001c") THEN  INSTRUCTION <= x"02080263";--beq
ELSIF(ADDRESS=x"00400020") THEN  INSTRUCTION <= x"00022403";--lw
ELSIF(ADDRESS=x"00400024") THEN  INSTRUCTION <= x"0004057F";--abs
ELSIF(ADDRESS=x"00400028") THEN  INSTRUCTION <= x"00420213";
ELSIF(ADDRESS=x"0040002c") THEN  INSTRUCTION <= x"fff80813";
ELSIF(ADDRESS=x"00400030") THEN  INSTRUCTION <= x"00d525b3";
ELSIF(ADDRESS=x"00400034") THEN  INSTRUCTION <= x"fe0584e3";--beq
ELSIF(ADDRESS=x"00400038") THEN  INSTRUCTION <= x"000506b3";
ELSIF(ADDRESS=x"0040003c") THEN  INSTRUCTION <= x"fe1ff0ef";--jal
ELSIF(ADDRESS=x"00400040") THEN  INSTRUCTION <= x"00d2a023";
ELSIF(ADDRESS=x"00400044") THEN  INSTRUCTION <= x"000000ef";
ELSIF(ADDRESS=x"00400048") THEN  INSTRUCTION <= x"00000013";
ELSE  INSTRUCTION(31 DOWNTO 0) <= x"00000013";
END IF;
END IF;
---------------------------------------------------------------------------------


END PROCESS;         
END ARCHITECTURE;