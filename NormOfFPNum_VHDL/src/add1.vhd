----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:43 02/07/2019 
-- Design Name: 
-- Module Name:    add1 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add1 is
    generic(addSize : integer);
    port( iY     : in  std_logic_vector(addSize downto 0);
	       iCarry : in std_logic;
			 oRes   : out std_logic_vector(addSize downto 0);
			 oCarry : out std_logic );
end add1;

architecture Behavioral of add1 is
    component halfAdder
	     port( iA   : in  std_logic;
		        iB   : in  std_logic; 
		        oFnc : out std_logic;
		        oC   : out std_logic );
    end component;
	
	 
	 signal s_iB  : std_logic_vector(addSize+1 downto 0);		 
	 signal sFnc  : std_logic_vector(addSize downto 0);	 
	
begin
	
	 s_iB(0)  <= iCarry;
	 
GEN_ADD_Level_3: 
    for I in 0 to addSize generate
        ADDX : halfAdder
		  port map(iA   => iY(I),
		           iB   => s_iB(I),
		           oFnc => sFnc(I),
		           oC   => s_iB(I+1) );
        end generate GEN_ADD_Level_3;


    oRes   <= sFnc;
    oCarry <= s_iB(addSize+1); 
	 
end Behavioral;

