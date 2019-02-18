--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:59:40 02/13/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum_Verilog/NormOfFPNum/mux8x1_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux8x1
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
 
ENTITY mux8x1_tb IS
END mux8x1_tb;
 
ARCHITECTURE behavior OF mux8x1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux8x1
    PORT(
         iSel : IN  std_logic_vector(2 downto 0);
         iX7 : IN  std_logic_vector(1 downto 0);
         iX6 : IN  std_logic_vector(1 downto 0);
         iX5 : IN  std_logic_vector(1 downto 0);
         iX4 : IN  std_logic_vector(1 downto 0);
         iX3 : IN  std_logic_vector(1 downto 0);
         iX2 : IN  std_logic_vector(1 downto 0);
         iX1 : IN  std_logic_vector(1 downto 0);
         iX0 : IN  std_logic_vector(1 downto 0);
         oX : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iSel : std_logic_vector(2 downto 0) := (others => '0');
   signal iX7 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX6 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX5 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX4 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX3 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX2 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX1 : std_logic_vector(1 downto 0) := (others => '0');
   signal iX0 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal oX : std_logic_vector(1 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux8x1 PORT MAP (
          iSel => iSel,
          iX7 => iX7,
          iX6 => iX6,
          iX5 => iX5,
          iX4 => iX4,
          iX3 => iX3,
          iX2 => iX2,
          iX1 => iX1,
          iX0 => iX0,
          oX => oX
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 

         iX7 <= "11";
         iX6 <= "10";
         iX5 <= "01";
         iX4 <= "00";
         iX3 <= "11";
         iX2 <= "10";
         iX1 <= "01";
         iX0 <= "00";
			
			wait for 20 ns;
             iSel <= "111";
			wait for 20 ns;
             iSel <= "110";
			wait for 20 ns;
             iSel <= "101";
			wait for 20 ns;
             iSel <= "100";
			wait for 20 ns;
             iSel <= "011";
			wait for 20 ns;
             iSel <= "010";
			wait for 20 ns;
             iSel <= "001";
			wait for 20 ns;
             iSel <= "000";
      wait;
   end process;

END;
