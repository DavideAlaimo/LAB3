library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardingUnit IS
PORT(RS1,RS2,RD_EX_MEM,RD_MEM_WB : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
     RegWrite_EX_MEM, RegWrite_MEM_WB : IN STD_LOGIC; 
     ForwardA, ForwardB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
     PriorityA, PriorityB : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE BEH OF ForwardingUnit IS


BEGIN

PROCESS(RS1,RS2,RD_EX_MEM,RD_MEM_WB,RegWrite_EX_MEM, RegWrite_MEM_WB)

variable caseconc : std_logic_vector(1 downto 0); 

BEGIN

caseconc := RegWrite_EX_MEM & RegWrite_MEM_WB;


CASE (caseconc) is
when "10" => IF(RS1=RD_EX_MEM) THEN ForwardA <= "011"; ForwardB <= "000"; PriorityA <= '1'; PriorityB <= '0'; 
            	ELSIF(RS2=RD_EX_MEM) THEN ForwardB <= "011"; ForwardA <= "000"; PriorityA <= '0'; PriorityB <= '1';
               	ELSE PriorityA <= '0'; PriorityB <= '0'; ForwardA <= "000"; ForwardB <= "000";
             END IF;

when "01" => 	IF(RS1=RD_MEM_WB) THEN ForwardA <= "100"; ForwardB <= "000"; PriorityA <= '1'; PriorityB <= '0';
               	ELSIF (RS2=RD_MEM_WB) THEN ForwardB <= "100"; ForwardA <="000"; PriorityA <= '0'; PriorityB <= '1';
	                ELSE PriorityA <= '0'; PriorityB <= '0'; ForwardA <= "000"; ForwardB <= "000";
               END IF;

when "11" =>   IF ((RS1=RD_EX_MEM) AND (RS2=RD_MEM_WB)) THEN
					ForwardA <= "011"; PriorityA <= '1'; PriorityB <= '1'; ForwardB <= "100";
					ELSIF ((RS1=RD_MEM_WB) AND (RS2=RD_EX_MEM)) THEN 
					ForwardA <= "100"; PriorityA <= '1'; PriorityB <= '1'; ForwardB <= "011";
					ELSIF((RS1=RD_EX_MEM) AND (NOT(RS2=RD_MEM_WB))) THEN
					ForwardA <= "011"; PriorityA <= '1'; PriorityB <= '0'; ForwardB <= "000";
					ELSIF((RS1=RD_MEM_WB) AND (NOT(RS2=RD_EX_MEM))) THEN
					ForwardA <= "100"; PriorityA <= '1'; PriorityB <= '0'; ForwardB <= "000";
					ELSIF((RS2=RD_EX_MEM) AND (NOT(RS1=RD_MEM_WB))) THEN
					ForwardB <= "011"; PriorityB <= '1'; PriorityA <= '0'; ForwardA <= "000";
					ELSIF((RS2=RD_MEM_WB) AND (NOT(RS1=RD_EX_MEM))) THEN
					ForwardB <= "100"; PriorityB <= '1'; PriorityA <= '0'; ForwardA <= "000";
					ELSE PriorityA <= '0'; PriorityB <= '0'; ForwardA <= "000"; ForwardB <= "000";
					END IF;

when "00" => 	PriorityA <= '0'; PriorityB <= '0'; ForwardA <= "000"; ForwardB <= "000";

when others => PriorityA <= '0'; PriorityB <= '0'; ForwardA <= "000"; ForwardB <= "000";

END CASE;
END PROCESS;
END ARCHITECTURE;