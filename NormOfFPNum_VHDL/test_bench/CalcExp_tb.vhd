--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:08:19 02/07/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/CalcExp_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CalcExp
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
 
ENTITY CalcExp_tb IS
END CalcExp_tb;
 
ARCHITECTURE behavior OF CalcExp_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CalcExp
    PORT(
         iExp : IN  std_logic_vector(7 downto 0);
         iMSBPos : IN  std_logic_vector(4 downto 0);
         iRndFlag : IN  std_logic;
         oExp : OUT  std_logic_vector(7 downto 0);
         oInf_n : OUT  std_logic;
         oInf_p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iExp : std_logic_vector(7 downto 0) := (others => '0');
   signal iMSBPos : std_logic_vector(4 downto 0) := (others => '0');
   signal iRndFlag : std_logic := '0';

 	--Outputs
   signal oExp : std_logic_vector(7 downto 0);
   signal oInf_n : std_logic;
   signal oInf_p : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CalcExp PORT MAP (
          iExp => iExp,
          iMSBPos => iMSBPos,
          iRndFlag => iRndFlag,
          oExp => oExp,
          oInf_n => oInf_n,
          oInf_p => oInf_p
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
      wait for 20 ns;
         iExp     <= "10000000";
         iMSBPos  <= "00011";
         iRndFlag <= '0';

      wait for 20 ns;
         iExp     <= "10000000";
         iMSBPos  <= "00011";
         iRndFlag <= '1';

      wait for 20 ns;
         iExp     <= "00000000";
         iMSBPos  <= "00111";
         iRndFlag <= '0';

      wait for 20 ns;
         iExp     <= "11111110";
         iMSBPos  <= "00011";
         iRndFlag <= '0';

      wait;
   end process;

END;
