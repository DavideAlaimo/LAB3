library ieee;
use ieee.std_logic_1164.all;


ENTITY CONTROL IS
PORT(OPCODE : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
     RD: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
     Branch, MemRead, MemToReg, ALUop, MemWrite, RegWrite, MuxToBranch : OUT STD_LOGIC;
     ALUsrc1, ALUsrc2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
     EnFunctUnit : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE BEH OF CONTROL IS
BEGIN
PROCESS(OPCODE)
BEGIN
IF(OPCODE="0010011" AND RD="00000") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '0'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --NOP
			EnFunctUnit<='0';----
ELSIF(OPCODE="0010011" ) THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --ADDI ANDI SRAI
			EnFunctUnit<='0';----
ELSIF (OPCODE="0000011") THEN Branch <= '0'; MemRead <= '1'; MemToReg <= '1'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --LW
			EnFunctUnit<='0';----

ELSIF (OPCODE="0010111") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "001"; ALUsrc2 <= "001"; --AUIPC
			EnFunctUnit<='0';------

ELSIF (OPCODE="0110111") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "010"; ALUsrc2 <= "001"; --LUI
			EnFunctUnit<='0';-----

ELSIF (OPCODE="0110011") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "000"; --XOR ADD SLT
			EnFunctUnit<='0';-------

ELSIF (OPCODE="1100011") THEN Branch <= '1'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '0'; MuxToBranch <= '0';
    			ALUsrc1 <= "000"; ALUsrc2 <= "000"; --BEQ
			EnFunctUnit<='0';-----	

ELSIF (OPCODE="1101111") THEN Branch <= '1'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '1';
    			 ALUsrc1 <= "001"; ALUsrc2 <= "010"; --JAL
			 EnFunctUnit<='0';-----

ELSIF (OPCODE="0100011") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '1'; RegWrite <= '0'; MuxToBranch <= '1';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --SW
			EnFunctUnit<='0';-------

-------------------------------------------------------------------------------------------------
ELSIF(OPCODE="1111111") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --ABS 
			EnFunctUnit<='1';
-------------------------------------------------------------------------------------------------

ELSE Branch <='0' ; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '0'; MuxToBranch <= '0';
     ALUsrc1 <= "000"; ALUsrc2 <= "000"; EnFunctUnit<='0';

END IF;
END PROCESS;
END ARCHITECTURE;
