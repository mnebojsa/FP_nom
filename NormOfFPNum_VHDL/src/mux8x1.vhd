----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:44:52 02/07/2019 
-- Design Name: 
-- Module Name:    mux8x1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux8x1 is
    port( iSel : in  std_logic_vector(2 downto 0);
          iX7  : in  std_logic_vector(1 downto 0);
          iX6  : in  std_logic_vector(1 downto 0);
          iX5  : in  std_logic_vector(1 downto 0);
          iX4  : in  std_logic_vector(1 downto 0);
          iX3  : in  std_logic_vector(1 downto 0);
          iX2  : in  std_logic_vector(1 downto 0);
          iX1  : in  std_logic_vector(1 downto 0);
          iX0  : in  std_logic_vector(1 downto 0);
          oX   : out std_logic_vector(1 downto 0) );
end mux8x1;

architecture Behavioral of mux8x1 is

begin

    with iSel select oX <= 
	     iX7  when "111",
	     iX6  when "110",
	     iX5  when "101",
	     iX4  when "100",
	     iX3  when "011",
	     iX2  when "010",
	     iX1  when "001",
	     iX0  when "000",
	     "00" when others;
end Behavioral;

