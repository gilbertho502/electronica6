----------------------------------------------------------------------------------
-- 
--Gilberto Misrain Vicente Yoc - 201503776
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity practica3 is
	port(
		clk_12 : in std_logic; -- 12MHz
		HSync, VSync : out std_logic;
		Red, Green : out std_logic_vector(2 downto 0);
		Blue : out std_logic_vector(2 downto 1);
		pin : in std_logic_vector (7 downto 0);
		r : in std_logic;
		g : in std_logic;
		b : in std_logic;
		send_data : in std_logic; -- enviar datos 
		tx_data : in std_logic_vector(4 downto 0); --Data enviado (8 bits)
		tx_out : out std_logic; --Salida de datos uart_tx
		reset: in std_logic
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
			Blue => Blue,
			pin => pin,
			r => r,
			g => g,
			b => b
		);

Inst_VGA_clk:
	entity work.VGA_clk
		port map(
			CLKIN_IN => clk_12,
			CLKFX_OUT => clk_25
		);

Inst_TX:
	entity work.Tx
		port map(
			clk => clk_25,
			send_data => send_data,
			tx_data => tx_data,
			tx_out => tx_out,
			reset => reset
		);
		
		
end Behavioral;

