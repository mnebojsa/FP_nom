--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:25 02/14/2019
-- Design Name:   
-- Module Name:   D:/MULTIPLAYER_PRACTICE/FP_norm/NormOfFPNum_Verilog/NormOfFPNum/NRM_tb.vhd
-- Project Name:  NormOfFPNum
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NRM
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
 
ENTITY NRM_tb IS
END NRM_tb;
 
ARCHITECTURE behavior OF NRM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NRM
    PORT(
         iCLK : IN  std_logic;
         iRST : IN  std_logic;
         iA : IN  std_logic_vector(39 downto 0);
         oNR : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iCLK : std_logic := '0';
   signal iRST : std_logic := '0';
   signal iA : std_logic_vector(39 downto 0) := (others => '0');

 	--Outputs
   signal oNR : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant iCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NRM PORT MAP (
          iCLK => iCLK,
          iRST => iRST,
          iA => iA,
          oNR => oNR
        );

   -- Clock process definitions
   iCLK_process :process
   begin
		iCLK <= '0';
		wait for iCLK_period/2;
		iCLK <= '1';
		wait for iCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
       variable iSign : std_logic;
       variable iExp : std_logic_vector(7 downto 0);
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for iCLK_period*10;

      -- insert stimulus here 
         iSign := '0';
         iEXP  := "00000001";
--
--			         |                        |  |
         
         iA    <= iSign & iEXP & "0010110011001100110011001001101";
      wait for 20 ns;			
--
--			         |                        |  |
         iA    <= iSign & iEXP & "1111111111111111111111111010010";
      wait for 20 ns;			
--
--			         |                        |  |
         iA    <= iSign & iEXP & "1111111111111111111111111110010";
			
      wait for 20 ns;
         iA    <= iSign & iEXP & "1110111111111111111111111110010";
			
      wait for 20 ns;
--
--			         |                        |  |
         iA    <= iSign & iEXP & "0000011111111111111111111110111";
			
      wait for 20 ns;			
--
--			         |                        |  |
         iA    <= iSign & iEXP & "0000000000000001111111111010010";

      wait for 20 ns;			
         iSign := '0';
         iEXP  := "11111000";
--
--			         |                        |  |
         iA    <= iSign & iEXP & "1111111111111111111111101000000";
      wait for 20 ns;
		
         iA    <= iSign & iEXP & "1111111111111111111111110100000";
      wait for 20 ns;	
         
         iA    <= iSign & iEXP & "1111111111111111111111111111111";
      wait for 20 ns;	

      wait for 20 ns;			
         iSign := '0';
         iEXP  := "11111010";
--
--			         |                        |  |
         iA    <= iSign & iEXP & "1111111111111111111111101000000";
      wait for 20 ns;
		
         iA    <= iSign & iEXP & "1111111111111111111111110100000";
      wait for 20 ns;	
         
         iA    <= iSign & iEXP & "1111111111111111111111111111111";
      wait for 20 ns;	
      wait;
   end process;

END;