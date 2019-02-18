--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:11:08 02/07/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/priorityCoder4x2_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PriorityCoder4x2
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
USE ieee.numeric_std.ALL;
 
ENTITY priorityCoder4x2_tb IS
END priorityCoder4x2_tb;
 
ARCHITECTURE behavior OF priorityCoder4x2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PriorityCoder4x2
    PORT(
         iX : IN  std_logic_vector(3 downto 0);
         oZ : OUT  std_logic_vector(1 downto 0);
         oAct : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iX : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal oZ : std_logic_vector(1 downto 0);
   signal oAct : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PriorityCoder4x2 PORT MAP (
          iX => iX,
          oZ => oZ,
          oAct => oAct
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
          for ii in 0 to 16 loop
              iX <= std_logic_vector(to_unsigned(ii,4));
				  wait for 20 ns;
          end loop;
      wait;
   end process;

END;
