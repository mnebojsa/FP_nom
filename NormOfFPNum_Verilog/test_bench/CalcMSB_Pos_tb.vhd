--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:37:14 02/07/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/CalcMSBPos_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CalcMSBPos
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
 
ENTITY CalcMSBPos_tb IS
END CalcMSBPos_tb;
 
ARCHITECTURE behavior OF CalcMSBPos_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CalcMSBPos
    PORT(
         iX   : in  std_logic_vector(30 downto 0);
         oPos : out std_logic_vector( 4 downto 0);
			oAct : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iX : std_logic_vector(30 downto 0) := (others => '0');

 	--Outputs
   signal oPos : std_logic_vector(4 downto 0);
   signal oAct : std_logic;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CalcMSBPos PORT MAP (
          iX => iX,
          oPos => oPos,
			 oAct => oAct
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here
      wait for 20 ns;		
          iX <= "0100100011111111001100111110001";
		wait for 20 ns;
          iX <= "0100100011111111001100111110001";
		wait for 20 ns;
          iX <= "0000001011111111001100111110001";
		wait for 20 ns;
          iX <= "0000000001111111001100111110001";
		wait for 20 ns;
          iX <= "0000000000000001001100111110001";
		wait for 20 ns;
          iX <= "0000000000000000001100111110001";
		wait for 20 ns;
          iX <= "0000000000000000000000111110001";
		wait for 20 ns;
          iX <= "0000000000000000000000000100001";
		wait for 20 ns;
          iX <= "0000000000000000000000000000001";
		wait for 20 ns;
          iX <= "0000000000000000000000000000000";
		wait for 20 ns;
      wait;
   end process;

END;
