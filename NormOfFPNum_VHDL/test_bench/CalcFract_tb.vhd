--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:05:04 02/07/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/CalcFract_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CalcFrac
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
 
ENTITY CalcFract_tb IS
END CalcFract_tb;
 
ARCHITECTURE behavior OF CalcFract_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CalcFrac
    PORT(
         iY : IN  std_logic_vector(22 downto 0);
         iR : IN  std_logic_vector(2 downto 0);
         oCarry : OUT  std_logic;
         oFraction : OUT  std_logic_vector(22 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iY : std_logic_vector(22 downto 0) := (others => '0');
   signal iR : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal oCarry : std_logic;
   signal oFraction : std_logic_vector(22 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CalcFrac PORT MAP (
          iY => iY,
          iR => iR,
          oCarry => oCarry,
          oFraction => oFraction
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
         iY <= "00000010100000000101110";

             iR <= "010";
			wait for 20 ns;
             iR <= "100";
			wait for 20 ns;
             iR <= "101";

      wait for 30 ns;	
         iY <= "11111111111111111111111";

             iR <= "010";
			wait for 20 ns;
             iR <= "100";
			wait for 20 ns;
             iR <= "101";				 
      wait;
   end process;

END;
