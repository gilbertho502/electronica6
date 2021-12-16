library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
	port(

		clk_12 : in std_logic;
		reset : in std_logic;
		SWITCH_1, SWITCH_2 : in std_logic;
		flag_uart_1, flag_uart_2 : out std_logic;
		data_1, data_2 : in std_logic_vector(7 downto 0);
		led : out std_logic_vector(7 downto 0)
	);
end mux;

architecture Behavioral of mux is
	type uart_signal  is (nothing , uart_1, uart_2 ); -- FSM uart_rx
	signal estados : uart_signal;
	signal flag_1, flag_2 : std_logic := '1';

begin
flag_uart_1 <= flag_1;
flag_uart_2 <= flag_2;


process (reset, clk_12)
begin

		if (rising_edge(clk_12)) then
		
				case estados is 
				   when nothing => 
					flag_1 <= '1';
					flag_2 <= '1';
							if (SWITCH_1 = '0') then

								estados <= uart_1;	
							elsif (SWITCH_2 = '0') then

								estados <= uart_2;
							else
								estados <= nothing;
							end if;
							
				   when uart_1 => 	
					
					flag_1 <= '0';
					flag_2 <= '1';
					led <= data_1;
							if (SWITCH_2 = '0') then
								estados <= uart_2;							
							elsif reset = '0' then
								estados <= nothing;			
							else
								estados <= uart_1;
							end if;								
								

					when uart_2 =>
					flag_2 <= '0';
					flag_1 <= '1';
					led <= data_2;
					
							if (SWITCH_1 = '0') then
								estados <= uart_1;							
							elsif reset = '0' then
								estados <= nothing;		
							else
								estados <= uart_2;
							end if;								

				when others =>
					estados <= nothing;
			end case;	
			
		end if;
end process;

end Behavioral;


