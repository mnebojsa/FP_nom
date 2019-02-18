----------------------------------------------------------------------------------
-- Company : RT-RK
-- Engineer: Nebojsa Markovic 
-- 
-- Create Date:    13:07:41 02/07/2019 
-- Design Name:    
-- Module Name:    CalcMSBPos - Behavioral 
 
-- Description: 
--                 This module gets 31 bit number and returns distance of first
--                 logical 1 from MSB of the input data

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

entity CalcMSBPos is
    port( iX   : in  std_logic_vector(30 downto 0);
          oPos : out std_logic_vector( 4 downto 0);
			 oAct : out std_logic );
end CalcMSBPos;

architecture Behavioral of CalcMSBPos is

    type twoBArry is array (7 downto 0) of std_logic_vector(1 downto 0);

    component PriorityCoder4x2
        port( iX   : in  std_logic_vector(3 downto 0);
              oZ   : out std_logic_vector(1 downto 0);
              oAct : out std_logic );
    end component;

    component PriorityCoder8x3
        port( iX   : in  std_logic_vector(7 downto 0);
              oZ   : out std_logic_vector(2 downto 0);
              oAct : out std_logic );
    end component;

    component mux8x1
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
    end component;

    signal s_iX       : std_logic_vector(31 downto 0);
    signal s_iZ       : twoBArry;
    signal s_Act      : std_logic_vector( 7 downto 0);

    signal s_BlkPos   : std_logic_vector( 2 downto 0);
    signal s_dummy    : std_logic;
	 
	 signal s_4xBlkPos : std_logic_vector( 4 downto 0);
    signal s_offSet   : std_logic_vector( 1 downto 0);
begin

    s_iX <= iX & '0';

    PrCd_GEN:
    for I in 7 downto 0 generate
        Inst_In_PrCdr4x2:
            PriorityCoder4x2
                port map( iX   => s_iX(4*I +3 downto 4*I),
                          oZ   => s_iZ(I),
                          oAct => s_Act(I));
    end generate;


Inst_PriorityCoder8x3:
    PriorityCoder8x3
    port map( iX   => s_Act(7 downto 0),
              oZ   => s_BlkPos,
              oAct => s_dummy);

Inst_mux8x1:
    mux8x1
	 port map( iSel => s_BlkPos,
              iX7  => s_iZ(0),
              iX6  => s_iZ(1),
              iX5  => s_iZ(2),
              iX4  => s_iZ(3),
              iX3  => s_iZ(4),
              iX2  => s_iZ(5),
              iX1  => s_iZ(6),
              iX0  => s_iZ(7),
              oX   => s_offSet );

    -- MULTIPLY PriorityCoder8x3 WITH 4 to determin block with MSB b'1 
	 -- ADD the offest to the Block Possition
	 -- 4*s_BlkPos = s_BlkPos & "00" = B4B3B200
	 -- s_BlkPos + offset = B4B3B200 + 000B1B0 = B4B3B2B1B0
	 -- => 4*BlkPos + offset = s_BlkPos & s_offSet
    s_4xBlkPos <= s_BlkPos & s_offSet;

    oPos <= s_4xBlkPos;
    oAct <= s_dummy;

end Behavioral;

