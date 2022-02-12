library ieee;
use ieee.std_logic_1164.all;


ENTITY CONTROL IS
PORT(OPCODE : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
     Branch, MemRead, MemToReg, ALUop, MemWrite, RegWrite, MuxToBranch : OUT STD_LOGIC;
     ALUsrc1, ALUsrc2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEH OF CONTROL IS
BEGIN
PROCESS(OPCODE)
BEGIN
IF(OPCODE="0010011") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --ADDI ANDI SRAI

ELSIF (OPCODE="0000011") THEN Branch <= '0'; MemRead <= '1'; MemToReg <= '1'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --LW

ELSIF (OPCODE="0010111") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "001"; ALUsrc2 <= "001"; --AUIPC

ELSIF (OPCODE="0110111") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "010"; ALUsrc2 <= "001"; --LUI

ELSIF (OPCODE="0110011") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '1'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '0';
     			ALUsrc1 <= "000"; ALUsrc2 <= "000"; --XOR ADD SLT

ELSIF (OPCODE="1100011") THEN Branch <= '1'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '0'; MuxToBranch <= '0';
    			ALUsrc1 <= "000"; ALUsrc2 <= "000"; --BEQ

ELSIF (OPCODE="1101111") THEN Branch <= '1'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '1'; MuxToBranch <= '1';
    			 ALUsrc1 <= "001"; ALUsrc2 <= "010"; --JAL

ELSIF (OPCODE="0100011") THEN Branch <= '0'; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '1'; RegWrite <= '0'; MuxToBranch <= '1';
     			ALUsrc1 <= "000"; ALUsrc2 <= "001"; --SW

ELSE Branch <='0' ; MemRead <= '0'; MemToReg <= '0'; ALUop <= '0'; MemWrite <= '0'; RegWrite <= '0'; MuxToBranch <= '0';
     ALUsrc1 <= "000"; ALUsrc2 <= "000";

END IF;
END PROCESS;
END ARCHITECTURE;
