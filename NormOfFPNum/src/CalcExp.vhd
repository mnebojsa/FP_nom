----------------------------------------------------------------------------------
-- Company : RT-RK
-- Engineer: Nebojsa Markovic 
-- 
-- Create Date:    15:05:54 02/07/2019 
-- Design Name:    
-- Module Name:    CalcExp - Behavioral  
 
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

entity CalcExp is
   port( iExp     : in  std_logic_vector(7 downto 0);
         iMSBPos  : in  std_logic_vector(4 downto 0);
         iRndFlag : in  std_logic;
         oExp     : out std_logic_vector(7 downto 0);
         oInf_n   : out std_logic;
         oInf_p   : out std_logic );
end CalcExp;

architecture Behavioral of CalcExp is

    component nBitAdder
        generic ( BitNuma : integer);
        port    ( iA     : in  std_logic_vector(BitNuma-1 downto 0);
                  iB     : in  std_logic_vector(BitNuma-1 downto 0);
                  iCarry : in  std_logic;
                  oRes   : out std_logic_vector(BitNuma-1 downto 0);
                  oCarry : out std_logic);
    end component;

    signal s_dotPos    : std_logic_vector(7 downto 0);
    signal s_EXP       : std_logic_vector(9 downto 0);
    signal s_Carry     : std_logic;

    signal s_2ndCMSBPos: std_logic_vector(9 downto 0);
    signal s_Dummy     : std_logic;
	 
    signal s_ResExp    : std_logic_vector(9 downto 0);
begin

    process(iRndFlag)
        variable v_dotPos : std_logic_vector(2 downto 0);
    begin
        if iRndFlag = '1' then
            v_dotPos := "101"; 
        else
            v_dotPos := "100";
        end if;
		  s_dotPos <= "00000" & v_dotPos;
    end process;

Inst_add_exp_4or5:
    nBitAdder
	 generic map(BitNuma => 8)
    port map( iA     => iEXP,
              iB     => s_dotPos,
              iCarry => '0',
              oRes   => s_EXP(7 downto 0),
              oCarry => s_Carry );

    s_EXP(8) <= s_Carry;
    s_EXP(9) <= '0';

    -- INVERT Position of MSB in order to get 2nd complement 
    s_2ndCMSBPos(0) <= not(iMSBPos(0));
    s_2ndCMSBPos(1) <= not(iMSBPos(1));
    s_2ndCMSBPos(2) <= not(iMSBPos(2));
    s_2ndCMSBPos(3) <= not(iMSBPos(3));
    s_2ndCMSBPos(4) <= not(iMSBPos(4));
	 s_2ndCMSBPos(9 downto 5) <= (others => '1');


Inst_sub_exp_MSB_pos:
    nBitAdder
	 generic map(BitNuma => 10)
    port map( iA     => s_EXP,
              iB     => s_2ndCMSBPos,
              iCarry => '1',
              oRes   => s_ResExp,
              oCarry => s_Dummy );

    oInf_n <= s_ResExp(9) and s_ResExp(8);
    oInf_p <= (    s_ResExp(9)  and not(s_ResExp(8)))  or
              (not(s_ResExp(8)) and     s_ResExp(8))   or
              (not(s_ResExp(8)) and not(s_ResExp(8)) and s_ResExp(7) and s_ResExp(6) and s_ResExp(5) and s_ResExp(4) and s_ResExp(3) and s_ResExp(2) and s_ResExp(1) and s_ResExp(0));			  

    with s_ResExp(9 downto 8) select oExp <=
	     s_ResExp(7 downto 0) when "00",
	     (others => '1') when others;
		  
end Behavioral;

