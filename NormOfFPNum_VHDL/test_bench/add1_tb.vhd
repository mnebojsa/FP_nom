--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:29:38 02/08/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/add1_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: add1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY add1_tb IS
END add1_tb;
 
ARCHITECTURE behavior OF add1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT add1
    PORT(
         iY : IN  std_logic_vector(23 downto 0);
         iCarry : IN  std_logic;
         oRes : OUT  std_logic_vector(23 downto 0);
         oCarry : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iY : std_logic_vector(23 downto 0) := (others => '0');
   signal iCarry : std_logic := '0';

 	--Outputs
   signal oRes : std_logic_vector(23 downto 0);
   signal oCarry : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: add1 PORT MAP (
          iY => iY,
          iCarry => iCarry,
          oRes => oRes,
          oCarry => oCarry
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
      wait for 100 ns;	
      -- insert stimulus here 
      iY <= "111111111111111111111111";
		iCarry <= '0';
		
		wait for 20 ns;
      iY <= "111111111111111111111111";
		iCarry <= '1';

		wait for 20 ns;
      iY <= "000000000000000000000001";
		iCarry <= '0';	

		wait for 20 ns;
      iY <= "000000000000000000000001";
		iCarry <= '1';	

		wait for 20 ns;
      iY <= "000000000000000000000000";
		iCarry <= '0';	

		wait for 20 ns;
      iY <= "000000000000000000000000";
		iCarry <= '1';			
      wait;
   end process;

END;
