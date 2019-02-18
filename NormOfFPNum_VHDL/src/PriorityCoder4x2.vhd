----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:36:46 02/07/2019 
-- Design Name: 
-- Module Name:    PriorityCoder - Behavioral 
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

entity PriorityCoder4x2 is
    port( iX   : in  std_logic_vector(3 downto 0);
          oZ   : out std_logic_vector(1 downto 0);
			 oAct : out std_logic );
end PriorityCoder4x2;

architecture DataFlow of PriorityCoder4x2 is

begin

    oZ(1) <= not(iX(3)) and not(iX(2));
	 oZ(0) <= not(iX(3)) and(    iX(2) or not(iX(1)));
	 
	 oAct  <= iX(3) or iX(2) or iX(1) or iX(0);
	 
end DataFlow;

