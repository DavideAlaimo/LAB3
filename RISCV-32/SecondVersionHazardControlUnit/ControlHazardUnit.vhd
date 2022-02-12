library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;



ENTITY ControlHazardUnit IS
PORT(OPCODE,OPCODE_1: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	ZERO_ALU,CLK,RST: IN STD_LOGIC;
	SEL_MUX_PC,SEL_MUX_INSTR: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE BEH OF ControlHazardUnit IS


-------------------------vecchia versione---------------------------
--COMPONENT CNT_2 IS
--port ( clk,cnt_rst,cnt_en : in std_logic;
--CNT_out: buffer unsigned(1 downto 0));
--END COMPONENT;
--
--signal ENABLE,tmp_SEL_MUX_PC, tmp_SEL_MUX_INSTR, tmp_START_COUNT, tmp_START_COUNT1, RST1: std_logic;
--signal ENABLE1,rst_COUNT1: std_logic;
--SIGNAL COUNT,COUNT1:unsigned(1 DOWNTO 0);
--
--BEGIN
--PROCESS(OPCODE,OPCODE_1,ZERO_ALU,COUNT,COUNT1,tmp_SEL_MUX_PC, tmp_SEL_MUX_INSTR, tmp_START_COUNT, RST)
--
--BEGIN
--tmp_START_COUNT<='0';
--tmp_SEL_MUX_PC<='0';
--tmp_SEL_MUX_INSTR<='0';
--tmp_START_COUNT1<='0';
--RST1<='0';
--
--IF (RST='1') THEN
--SEL_MUX_PC<='0';
--SEL_MUX_INSTR<='0';
--tmp_START_COUNT<='0';
--tmp_SEL_MUX_PC<='0';
--tmp_SEL_MUX_INSTR<='0';
--tmp_START_COUNT1<='0';
--RST1<='0';
--
--
--
--ELSE 
--IF(OPCODE="1101111") THEN--JAL
--	SEL_MUX_PC<='1';
--	SEL_MUX_INSTR<='0';
--
--	tmp_START_COUNT<='1';
--	tmp_SEL_MUX_PC<='1';
--	tmp_SEL_MUX_INSTR<='0';
--
--ELSIF(OPCODE_1="1100011" AND ZERO_ALU='1') THEN--BEQ
--
--	SEL_MUX_PC<='1';
--	SEL_MUX_INSTR<='1';
--
--	tmp_START_COUNT1<='1';
--	tmp_SEL_MUX_PC<='1';
--	tmp_SEL_MUX_INSTR<='1';
--	RST1<='0';
--
--ELSIF(COUNT1="01") THEN
--
--	SEL_MUX_PC<= tmp_SEL_MUX_PC;
--	SEL_MUX_INSTR<= tmp_SEL_MUX_INSTR;
--	tmp_START_COUNT1<= '0';
--	RST1<='0';
--
--ELSIF(COUNT1="10") THEN
--	SEL_MUX_PC<='0';
--	SEL_MUX_INSTR<='0';
--	RST1<='1';
--
--ELSIF(COUNT="01" OR COUNT="10") THEN
--
--	SEL_MUX_PC<= tmp_SEL_MUX_PC;
--	SEL_MUX_INSTR<= tmp_SEL_MUX_INSTR;
--	tmp_START_COUNT<= '0';
--
--ELSIF(COUNT="11") THEN
--	SEL_MUX_PC<='0';
--	SEL_MUX_INSTR<='0';
--ELSE
--	SEL_MUX_PC<='0';
--	SEL_MUX_INSTR<='0';
--
--END IF;
--END IF;
--END PROCESS;
--
--rst_COUNT1<=RST or RST1;
--
--ENABLE1<=((not(tmp_START_COUNT1))and (not COUNT1(1)) and COUNT1(0))or ((not(tmp_START_COUNT1)) and  COUNT1(1) and (not COUNT1(0))) or ((tmp_START_COUNT1)and (not COUNT1(1)) and (not COUNT1(0)));
--Enable <=((not(tmp_START_COUNT)) and COUNT(0)) or ((not(tmp_START_COUNT)) and COUNT(1)) or (tmp_START_COUNT and (not COUNT(1)) and (not COUNT(0)) );
--CNT: CNT_2 PORT MAP (CLK,RST,ENABLE,COUNT);
--CNT1: CNT_2 PORT MAP(CLK,rst_COUNT1,ENABLE1,COUNT1);
------------------------------fine vecchia versione--------------------------




COMPONENT ControlHazardUnit1 IS
PORT(OPCODE: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	CLK,RST: IN STD_LOGIC;
	SEL_MUX_PC: OUT STD_LOGIC);
END COMPONENT;

COMPONENT ControlHazardUnit2 IS
PORT(OPCODE_1: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	ZERO_ALU,CLK,RST: IN STD_LOGIC;
	SEL_MUX_PC,SEL_MUX_INSTR: OUT STD_LOGIC);
END COMPONENT;

SIGNAL MUX_PC1,MUX_PC2,MUX_INSTR2 : STD_LOGIC;

BEGIN

CONTROL_HAZARD_JAL: ControlHazardUnit1 PORT MAP (OPCODE,CLK,RST,MUX_PC1);
CONTROL_HAZARD_BEQ: ControlHazardUnit2 PORT MAP (OPCODE_1,ZERO_ALU,CLK,RST,MUX_PC2,MUX_INSTR2);


SEL_MUX_PC <= MUX_PC1 OR MUX_PC2;
SEL_MUX_INSTR <= MUX_INSTR2;
END ARCHITECTURE;

