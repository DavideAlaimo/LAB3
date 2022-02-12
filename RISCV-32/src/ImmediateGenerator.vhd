library ieee;
use ieee.std_logic_1164.all;



ENTITY ImmediateGenerator IS
PORT (Instruction : IN STD_LOGIC_VECTOR(31 downto 0);
Instruction_64 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF ImmediateGenerator IS
BEGIN

PROCESS(Instruction)
VARIABLE OPCODE : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
OPCODE:=Instruction(6 downto 0);

---------------------------------------------------I
IF(OPCODE="0010011" OR OPCODE="0000011") THEN Instruction_64(11 DOWNTO 0) <= Instruction(31 DOWNTO 20);
Instruction_64(63 DOWNTO 12) <= (others=>Instruction(31));

---------------------------------------------------U
ELSIF(OPCODE="0010111" OR OPCODE="0110111") THEN Instruction_64(31 DOWNTO 12) <= Instruction(31 DOWNTO 12); 
Instruction_64(63 DOWNTO 32) <= (others=>Instruction(31));
Instruction_64(11 DOWNTO 0) <= (others=>'0');

----------------------------------------------------SB
ELSIF(OPCODE="1100011") THEN Instruction_64 (11 DOWNTO 0) <= Instruction(31) & Instruction(7) & Instruction(30 DOWNTO 25) & Instruction(11 DOWNTO 8);
Instruction_64(63 DOWNTO 12)<= (others=>InstruCtion(31)); 

---------------------------------------------------UJ
ELSIF(OPCODE="1101111") THEN
Instruction_64(19 DOWNTO 0) <= Instruction(31) & Instruction(19 DOWNTO 12) & Instruction(20) & Instruction(30 DOWNTO 21);
Instruction_64(63 DOWNto 20) <= (OTHERS=> Instruction(31));

----------------------------------------------------S
ELSIF(OPCODE="0100011")THEN Instruction_64(11 DOWNTO 0) <= Instruction(31 DOWNTO 25) & Instruction(4 DOWNTO 0);
Instruction_64(63 DOWNTO 12) <= (OTHERS=>Instruction(31));
ELSE Instruction_64 <= (others=>'0');
END IF;
END PROCESS;
END ARCHITECTURE;