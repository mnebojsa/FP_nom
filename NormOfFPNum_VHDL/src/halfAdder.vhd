----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:59 02/08/2019 
-- Design Name: 
-- Module Name:    halfAdder - Behavioral 
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

entity halfAdder is
    port( iA   : in  std_logic;
	       iB   : in  std_logic;
			 oFnc : out std_logic;
			 oC   : out std_logic );
end halfAdder;

architecture dataFlow of halfAdder is

begin

    oFnc <= iA xor iB;
	 oC   <=(iA and iB);
	 
end dataFlow;
