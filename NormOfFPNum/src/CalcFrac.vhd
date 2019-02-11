----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:27:43 02/07/2019 
-- Design Name: 
-- Module Name:    CalcFrac - Behavioral 
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

entity CalcFrac is
    port( iY       : in  std_logic_vector(23 downto 0);
	       iR       : in  std_logic_vector( 2 downto 0);
          oCarry   : out std_logic;
			 oFraction: out std_logic_vector(23 downto 0) );
end CalcFrac;

architecture Behavioral of CalcFrac is

    component add1
        port( iY     : in  std_logic_vector(23 downto 0);
              iCarry : in  std_logic;          
              oRes   : out std_logic_vector(23 downto 0);
              oCarry : out std_logic );
    end component;

    signal s_oCarry : std_logic;
	 signal s_iCarry : std_logic;
    signal s_Res0   : std_logic_vector(23 downto 0);
    signal s_Res1   : std_logic_vector(23 downto 0);
begin


    with iY(0) select s_iCarry <=
	       iR(2)                                  when '1',
	     ((iR(2) and iR(1)) or (iR(2) and iR(0))) when others;	  

Inst_add1:
    add1
    port map( iY     => iY,
              iCarry => s_iCarry,
              oRes   => s_Res0,
              oCarry => s_oCarry);

    with s_oCarry select oFraction <=
	     ('0' & s_Res0(23 downto 1)) when '1',
		                     s_Res0 when others;

    oCarry <= s_oCarry;							
end Behavioral;

