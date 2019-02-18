--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:18:14 02/13/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum_Verilog/NormOfFPNum/PriorityCoder4x2_tb.vhd
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
--USE ieee.numeric_std.ALL;
 
ENTITY PriorityCoder4x2_tb IS
END PriorityCoder4x2_tb;
 
ARCHITECTURE behavior OF PriorityCoder4x2_tb IS 
 
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
      wait for 20 ns;
          iX <= "1010";
      wait for 20 ns;
          iX <= "0110";
      wait for 20 ns;
          iX <= "0010";
      wait for 20 ns;
          iX <= "0001";
      wait for 20 ns;
          iX <= "0000";
      wait;
   end process;

END;
