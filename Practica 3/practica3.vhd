----------------------------------------------------------------------------------
-- Practica_03_E6_B_03
-- 
--Gilberto Misrain Vicente Yoc - 201503776
--
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity practica3 is
	port(
		clk_12 : in std_logic; -- 12MHz
		HSync, VSync : out std_logic;
		Red, Green : out std_logic_vector(2 downto 0);
		Blue : out std_logic_vector(2 downto 1)
	);
end practica3;

architecture Behavioral of practica3 is
	signal clk_25 : std_logic;
begin

VGA_1:
	entity work.VGA
		port map(
			clk => clk_25,
			HSync => HSync,
			VSync => VSync,
			Red => Red,
			Green => Green,
			Blue => Blue
		);

Inst_VGA_clk:
	entity work.VGA_clk
		port map(
			CLKIN_IN => clk_12,
			CLKFX_OUT => clk_25
		);

end Behavioral;

