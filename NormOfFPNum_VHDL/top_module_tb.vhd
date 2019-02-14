--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:16:43 02/08/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum/top_module_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_module
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
 
ENTITY top_module_tb IS
END top_module_tb;
 
ARCHITECTURE behavior OF top_module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         iSign  : IN  std_logic;
         iEXP   : IN  std_logic_vector(7 downto 0);
         iY     : IN  std_logic_vector(30 downto 0);
         oSign  : OUT std_logic;
         oExp   : OUT std_logic_vector(7 downto 0);
         oFract : OUT std_logic_vector(23 downto 0);
			oInf_n : out std_logic;
			oInf_p : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iSign : std_logic := '0';
   signal iEXP : std_logic_vector(7 downto 0) := (others => '0');
   signal iY : std_logic_vector(30 downto 0) := (others => '0');

 	--Outputs
   signal oSign : std_logic;
   signal oExp : std_logic_vector(7 downto 0);
   signal oFract : std_logic_vector(23 downto 0);
   signal oInf_n : std_logic;
   signal oInf_p : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          iSign => iSign,
          iEXP => iEXP,
          iY => iY,
          oSign => oSign,
          oExp => oExp,
          oFract => oFract,
			 oInf_n => oInf_n,
			 oInf_p => oInf_p
        );

   -- Stimulus process
   stim_proc: process

   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
         iSign <= '0';
         iEXP  <= "00000001";
--
--			         |                        |  |
         
         iY    <= "0010110011001100110011001001101";
      wait for 20 ns;			
--
--			         |                        |  |
         iY    <= "1111111111111111111111111010010";
      wait for 20 ns;			
--
--			         |                        |  |
         iY    <= "1111111111111111111111111110010";
			
      wait for 20 ns;
         iY    <= "1110111111111111111111111110010";
			
      wait for 20 ns;
--
--			         |                        |  |
         iY    <= "0000011111111111111111111110111";
			
      wait for 20 ns;			
--
--			         |                        |  |
         iY    <= "0000000000000001111111111010010";
      wait;
   end process;

END;
