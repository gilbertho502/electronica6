library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Displays is
	Port(
		--Señales de control; reset y señal de reloj.
		clk_12:		in		std_logic;
		SWITCH_3:	in		std_logic;
		flag_1, flag_2 : in std_logic;--SWITCH_3
		Enable:	out	std_logic_vector(2 downto 0);
		Display: out 	std_logic_vector(7 downto 0)
	);
end Displays;

architecture Behavioral of Displays is

	signal cont_multiplexacion:	integer range 0 to 12000000;
	signal estado_enable:	std_logic_vector(2 downto 0);

begin
	
	Enable <= estado_enable;
	process(clk_12)
		begin
		
		if (rising_edge(clk_12)) then
		if (SWITCH_3 = '0') then			
						if (flag_2 = '0') then 	
							
 								if(cont_multiplexacion = 1200) then
									cont_multiplexacion <= 0;
									if(estado_enable = "110") then
										estado_enable <= "101";
										Display <= "11110111";
									elsif(estado_enable = "101") then
										estado_enable <= "011";
										Display <= "11000001";
									elsif(estado_enable = "011") then
										estado_enable <= "110";
										Display <= "10100100";
									else
										estado_enable <= "110";
									end if;
								else
									cont_multiplexacion <= cont_multiplexacion + 1;
								end if;
							
						elsif (flag_1 = '0') then 
								if(cont_multiplexacion = 1200) then
									cont_multiplexacion <= 0;
									if(estado_enable = "110") then
										estado_enable <= "101";
										Display <= "11110111";
									elsif(estado_enable = "101") then
										estado_enable <= "011";
										Display <= "11000001";
									elsif(estado_enable = "011") then
										estado_enable <= "110";
										Display <= "11111001";
									else
										estado_enable <= "110";
									end if;
								else
									cont_multiplexacion <= cont_multiplexacion + 1;
								end if;	
								
						else 
						estado_enable <= "111";
						end if;
			
			else
			estado_enable <= "111";
			end if;
		end if;	
	end process;
end Behavioral;