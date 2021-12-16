-----------------------------------------------------------------------------
--Gilberto Misrain Vicente Yoc - 201503776
--Eduardo Alexander Xiquin Castro - 201403911
--Yeffrey Jared Veliz Arteaga - 201709175
----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY practica_04_TB IS
END practica_04_TB;

ARCHITECTURE behavior OF practica_04_TB IS  
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ROM_MEM
		PORT(
         addr :     IN  std_logic_vector(5 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0)
		);
    END COMPONENT;
   --Inputs
	signal addr : std_logic_vector(5 downto 0) := (others => '0');
	signal cont: integer range 0 to 64 := 0;
 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: ROM_MEM PORT MAP (
          addr => addr,
          data_out => data_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		while (cont < 64) loop
			addr <= std_logic_vector(to_unsigned(cont, 6));
			wait for 16.7 ns; -- Para poder tener los 20MHz, se utilizo una regla de tres
			cont <= cont+1;  --   ya que 10ns es a 12Mhz, entonces se busco cuanto tiempo se 
		end loop;				-- necesita para los 20Mhz
      wait;
   end process;
END;