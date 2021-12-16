----------------------------------------------------------------------------------
----Gilberto Misrain Vicente Yoc    - 201503776
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
	port(
		clk_12 : in std_logic;
		reset : in std_logic;
		SWITCH_1, SWITCH_2, SWITCH_3 : in std_logic;
		rd_1, rd_2 : out std_logic;
		data : out std_logic_vector(7 downto 0);
		DIP_SWITCH : in std_logic_vector (7 downto 0);
		Enable:	out	std_logic_vector(2 downto 0);
		Display: out 	std_logic_vector(7 downto 0)
	);
end top;

architecture Behavioral of top is

	signal data_1, data_2 : std_logic_vector(7 downto 0);
	signal uart_1, uart_2 : std_logic;
	signal flag_u_1, flag_u_2 : std_logic;
begin

RX_1:
	entity work.uart_rx
			generic map(
				n_bits => 4,
				contador_bits => 312,
				contador_half_bits => 156
		)
		port map(
			clk => clk_12,
			rx_in => uart_1,
			read_data => rd_1,
			rx_data => data_1 				
		);

RX_2:
	entity work.uart_rx
		generic map(
				n_bits => 8,
				contador_bits => 625,
				contador_half_bits => 312
		)
		port map(
			clk => clk_12,
			rx_in => uart_2,
			read_data => rd_2,
			rx_data=> data_2
		);

MUX_1:
	entity work.mux
		port map(
			clk_12 => clk_12,
			reset => reset,
			data_1=> data_1,
			data_2=> data_2,
			SWITCH_1 => SWITCH_1,
			SWITCH_2 => SWITCH_2,
			flag_uart_1 => flag_u_1,
			flag_uart_2 => flag_u_2,
			led => data
		);
		
TX_1:
	entity work.uart_tx
			generic map(
				n_bits => 4,
			contador_bits => 312
		)
		port map(
	clk_12 => clk_12, 
	send_data => SWITCH_1,
	tx_data=> DIP_SWITCH, 
	tx_out => uart_1,
	reset =>	reset
		
		);
		
TX_2:
	entity work.uart_tx
			generic map(
			n_bits => 8,
			contador_bits => 625
		)
		port map(
	clk_12 => clk_12, 
	send_data => SWITCH_2, 
	tx_data=> DIP_SWITCH,  
	tx_out => uart_2,
	reset =>	reset		
		);
		
Control_display_1:
	entity work.Displays
		port map(
		clk_12 => clk_12,
		flag_1 => flag_u_1,
		flag_2 => flag_u_2,
		SWITCH_3 => SWITCH_3,
		Enable=>	Enable,
		Display=> Display	
		);

end Behavioral;