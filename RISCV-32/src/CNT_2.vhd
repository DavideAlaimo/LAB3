library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity CNT_2 is
port ( clk,cnt_rst,cnt_en : in std_logic;
	CNT_out: OUT unsigned(1 downto 0));
end CNT_2;


architecture behavior of CNT_2 is
signal cnt : unsigned(1 downto 0);
begin
process(cnt_rst,clk)
begin
if(cnt_rst='1') then cnt<="00";
elsif(clk'event and clk='1') then
if(cnt_en='1') then cnt<= cnt+"01";
else cnt<=cnt;
end if;
end if;

end process;

CNT_out<=cnt;

end architecture;
