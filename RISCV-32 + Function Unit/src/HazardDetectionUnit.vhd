library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY HazardDetectionUnit IS
	PORT(	RS1,RS2,RD,WriteReg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RegWrite,MemRead,Foreward_on,CLK: IN STD_LOGIC;
		EN_PC, EN_IF_ID,EN_ID_EX: OUT STD_LOGIC;
		MUX_BUBBLE: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE BEH OF HazardDetectionUnit IS

signal cnt,cnt2: std_logic_vector(2 downto 0) :=(OTHERS=>'0') ;
signal start,start2: std_logic;
signal EN_CNT: std_logic;
BEGIN
PROCESS(RS1,RS2,RD,MemRead,WriteReg)
BEGIN
start<='0';
EN_CNT<='0';
start2<='0';
IF(MemRead='1' AND ((RD=RS1) OR (RD=RS2))) THEN
	start <='1';
	EN_CNT<='1';
ELSIF((WriteReg=RS2 or WriteReg=RS1) and Foreward_on='0') THEN
start2<='1';
ELSE
	start<='0';
	EN_CNT<='0';
	start2<='0';

END IF;
END PROCESS;
	PROCESS(CLK,start,start2)begin
		IF(start='1' and EN_CNT='1') then
			EN_IF_ID <= '0';
			EN_ID_EX <= '0';
			EN_PC <= '0';
			MUX_BUBBLE <= '0';
			cnt <= cnt+ "001";
		ELSIF(start2='1' and start='0' and cnt ="000" and cnt2="000" and RegWrite='1')then
			EN_IF_ID <= '0';
			EN_ID_EX <= '0';
			EN_PC <= '0';
			MUX_BUBBLE <= '0';
			cnt2 <= cnt2+ "001";
		ELSIF(CLK'EVENT AND CLK='1') THEN
			if(start='0' and (cnt="100")) then
				EN_IF_ID <= '1';
				EN_ID_EX <= '1';
				EN_PC <= '1';
				MUX_BUBBLE <= '1';
				cnt<="000";
			elsif(start='0' and (cnt="001")) then
				cnt<=cnt+"001";
			elsif(start='0' and (cnt="010")) then
				cnt<=cnt+"001";
			elsif(start='0' and (cnt="011")) then
				cnt<=cnt+"001";
			elsif(start2='1' and cnt2="001") then
				EN_IF_ID <= '1';
				EN_ID_EX <= '1';
				EN_PC <= '1';
				MUX_BUBBLE <= '1';
				cnt2<=cnt2 + "001";
	ELSE
		EN_IF_ID <= '1';
		EN_ID_EX <= '1';
		EN_PC <= '1';
		MUX_BUBBLE <= '1';
		cnt<="000";
		cnt2<="000";

	end if;
end if;
end process;

END ARCHITECTURE;


