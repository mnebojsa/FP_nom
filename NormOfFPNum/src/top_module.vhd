----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:14:26 02/07/2019 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
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

entity top_module is
    port( iSign : in  std_logic;
	       iEXP  : in  std_logic_vector( 7 downto 0);
			 iY    : in  std_logic_vector(30 downto 0);
			 oSign : out std_logic;
			 oExp  : out std_logic_vector( 7 downto 0);
	       oFract: out std_logic_vector(23 downto 0);
			 oInf_n: out std_logic;
			 oInf_p: out std_logic);
end top_module;

architecture Behavioral of top_module is

    component CalcExp
        port( iExp     : IN  std_logic_vector(7 downto 0);
              iMSBPos  : IN  std_logic_vector(4 downto 0);
              iRndFlag : IN  std_logic;          
              oExp     : OUT std_logic_vector(7 downto 0);
              oInf_n   : OUT std_logic;
              oInf_p   : OUT std_logic);
    end component;

    component CalcFrac
        port( iY        : IN  std_logic_vector(23 downto 0);
		        iR        : IN  std_logic_vector( 2 downto 0);          
		        oCarry    : OUT std_logic;
		        oFraction : OUT std_logic_vector(23 downto 0) );
    end component;

    component CalcMSBPos
        port( iX   : IN  std_logic_vector(30 downto 0);          
              oPos : OUT std_logic_vector(4 downto 0);
              oAct : OUT std_logic );
    end component;

    signal s_pos    : std_logic_vector(4 downto 0);
	 signal s_dummy  : std_logic;
	 signal s_dummy0 : std_logic;
	 signal s_dummy1 : std_logic;
	 signal s_dummy2 : std_logic;
	 signal s_oCarry : std_logic;

    signal s_Rnd    : std_logic_vector( 2 downto 0);
    signal s_inFrc  : std_logic_vector(23 downto 0);

begin

Inst_CalcMSBPos:
    CalcMSBPos
	 port map( iX   => iY,
              oPos => s_pos,
              oAct => s_dummy);

-- FINISH THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    process(iY, s_pos)
	     variable v_L : integer range 0 to 31;
	 begin
	    s_inFrc <= (others => '0');
       s_Rnd   <= (others => '0');

       v_L     := to_integer(unsigned(s_pos));

      if v_L < 4 then
       -- 30 - v_L -1 first digit is the one after MSB 1
       -- MSB is possitioned on  30 - v_L, and the first digit after 
       -- is placed on 30 - v_L -1 		
          s_inFrc <= iY(30 - v_L -1 downto 7 - v_L -1);
          s_Rnd   <= iY( 7 - v_L -2 downto 4 - v_L -1);		 
       elsif v_L < 6 then
          s_inFrc                     <= iY(30 - v_L -1 downto 7 - v_L -1);
          s_Rnd(2 downto 2-(7 - v_L -2)) <= iY( 7 - v_L -2 downto 0);
          s_Rnd(7 - v_L -2 downto 0) <= (others => '0');			 
		 else
          s_inFrc(23 downto 23-(30 - v_L -1))     <= iY(30 - v_L -1 downto 0);
          s_inFrc(23 -(30 - v_L -1) -1 downto 0)  <= (others => '0');	
          s_Rnd                                <= (others => '0');			 
		 end if;
	 end process;

Inst_CalcFrac:
    CalcFrac
	 port map( iY        => s_inFrc,
              iR        => s_Rnd,
              oCarry    => s_oCarry,
              oFraction => oFract);	


Inst_CalcExp:
    CalcExp
	 port map( iExp     => iEXP,
              iMSBPos  => s_pos,
              iRndFlag => s_oCarry,
              oExp     => oExp,
              oInf_n   => oInf_n,
              oInf_p   => oInf_p);
	
    oSign <= iSign;
	 
end Behavioral;

