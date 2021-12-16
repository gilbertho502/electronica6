
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tx is

generic(
	contador_bits : integer := 104 -- 12MHz/115200 bps
	--contador_half_bits : integer := 625 --(12MHz/9600 bps)
);

port(
	clk : in std_logic; -- Entrada de reloj
	send_data : in std_logic; -- enviar datos 
	tx_data : in std_logic_vector(4 downto 0); --Data enviado (8 bits)
	tx_out : out std_logic; --Salida de datos uart_tx
	reset: in std_logic
);
end Tx;

architecture Behavioral of Tx is
	type uart_tx is (idle, start, data, stop); --FSM uart_rx
	signal estados : uart_tx;
	signal contador : integer range 0 to contador_bits - 1 := 0;
	signal indice : integer range 0 to 7 := 0;
signal reg_1_0, reg_2_0 : std_logic ;
signal pulso_boton0 : std_logic ;	
	
begin
--Detector de flancos
process (reset, clk)
begin
   if reset = '0' then 
		reg_1_0 <= '0';
	elsif rising_edge(clk) then
		reg_1_0 <= send_data;
	end if;	
end process;

process (reset, clk)
begin
   if reset = '0' then 
		reg_2_0 <= '0';
	elsif rising_edge(clk) then
		reg_2_0 <= reg_1_0;
	end if;	
end process;

pulso_boton0 <= '1' when (reg_1_0 = '0' and reg_2_0 = '1') else '0';

recepcion:
	process (clk)
	begin 
		if (rising_edge(clk)) then 
			case estados is 
				
				
				when idle =>
					contador <= 0;
					indice <= 0;
					tx_out <= '1';
					--led_0 <= '1';
					if ( pulso_boton0 = '1') then 	
						tx_out <= '0';  --pone en 0 el bit start
						estados <= start; 
					else
						estados <= idle;
					end if;
				

				when start =>
					if (contador = contador_bits -1) then
						tx_out <= tx_data(indice);
						estados <= data;  
					else
						contador <= contador + 1;
						estados <= start;
					end if;
					

				when data =>				
					if (contador = contador_bits - 1) then
						contador <= 0;
						tx_out <= tx_data(indice);
						if (indice = 7) then 
							indice <= 0;
							--tx_out <= '0';
							estados <= stop;
						else 
							indice <= indice + 1;							
							--tx_out <= tx_data(indice);
							estados <= data;					
						end if;
					else 
					--	tx_out <= tx_data(indice);					
						contador <= contador +1;
						estados <= data;

					end if;


				when stop =>
					if (contador = contador_bits -1) then 
						contador <= 0;
						estados <= idle;
						--led_0 <= '0';
					else 
						contador	<= contador +1;
						estados <= stop;
					end if;
				when others =>
					estados <= idle;
			end case;
		end if;
		
	
	end process;
end Behavioral;


