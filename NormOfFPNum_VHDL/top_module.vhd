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
use IEEE.NUMERIC_STD.ALL;

--entity top_module is
--    port( iSign : in  std_logic;
--	       iEXP  : in  std_logic_vector( 7 downto 0);
--			 iY    : in  std_logic_vector(30 downto 0);
--			 oSign : out std_logic;
--			 oExp  : out std_logic_vector( 7 downto 0);
--	       oFract: out std_logic_vector(23 downto 0);
--			 oInf_n: out std_logic;
--			 oInf_p: out std_logic);
--end top_module;

entity NRM is
    generic( oWIDTH : integer := 24);  -- oWIDTH = 32/24/16
    port   ( iCLK  : in  std_logic;
	          iRST  : in  std_logic;
			    iA    : in  std_logic_vector(      39 downto 0);
	          oNR   : out std_logic_vector(oWIDTH-1 downto 0));
end NRM;

architecture Behavioral of NRM is

    component CalcExp
        port( iExp     : in  std_logic_vector(7 downto 0);
              iMSBPos  : in  std_logic_vector(4 downto 0);
              iRndFlag : in  std_logic;          
              oExp     : out std_logic_vector(7 downto 0);
              oInf_n   : out std_logic;
              oInf_p   : out std_logic);
    end component;

    component CalcFrac
    generic(FrWidth : integer);
        port( iY        : in  std_logic_vector(FrWidth downto 0);
		        iR        : in  std_logic_vector( 2 downto 0);          
		        oCarry    : out std_logic;
		        oFraction : out std_logic_vector(FrWidth downto 0) );
    end component;

    component CalcMSBPos
        port( iX   : in  std_logic_vector(30 downto 0);          
              oPos : out std_logic_vector(4 downto 0);
              oAct : out std_logic );
    end component;

    signal s_pos    : std_logic_vector(4 downto 0);
	 signal s_dummy  : std_logic;
	 signal s_oCarry : std_logic;

    signal s_Rnd    : std_logic_vector(        2 downto 0);
    signal s_inFrc  : std_logic_vector(oWIDTH-10 downto 0);

    signal s_oExp   : std_logic_vector(        7 downto 0);
	 signal s_oFrac  : std_logic_vector(oWIDTH-10 downto 0);
	 
	 signal s_oInf_n : std_logic;
	 signal s_oInf_p : std_logic;
begin

Inst_CalcMSBPos:
    CalcMSBPos
	 port map( iX   => iA(30 downto 0),
              oPos => s_pos,
              oAct => s_dummy);

    process(iA(30 downto 0), s_pos)
	     variable v_L : integer range 0 to 31;
	 begin
	    s_inFrc <= (others => '0');
       s_Rnd   <= (others => '0');

       v_L     := to_integer(unsigned(s_pos));
		 
--32bit_output: if oWIDTH = 32 generate 
       if v_L < 36 - oWIDTH then
       -- 30 - v_L -1 first digit is the one after MSB 1
       -- MSB is possitioned on  30 - v_L, and the first digit after 
       -- is placed on 30 - v_L -1 		
          s_inFrc  <= iA( 30 - v_L -1               downto (30 - (oWIDTH-10)) - v_L -1);
          s_Rnd    <= iA((30 -(oWIDTH-10)) - v_L -2 downto (30 - (oWIDTH-10)) - v_L -4);		 
       elsif v_L < 36 - oWIDTH +2 then
          s_inFrc                                         <= iA(30 - v_L -1 downto (30 - (oWIDTH-10)) - v_L -1);
          s_Rnd(2 downto 2-((30 - (oWIDTH-10)) - v_L -2)) <= iA((30 - (oWIDTH-10)) - v_L -2 downto 0);
          s_Rnd(2-((30 - (oWIDTH-10)) - v_L -3) downto 0) <= (others => '0');			 
		 else
          s_inFrc((oWIDTH-10) downto (oWIDTH-10)-(30 - v_L -1))    <= iA(30 - v_L -1 downto 0);
          s_inFrc((oWIDTH-10) -(30 - v_L -1) -1 downto 0) <= (others => '0');	
          s_Rnd                                  <= (others => '0');			 
		 end if;
--end generate 32bit_output;
	 end process;

Inst_CalcFrac:
    CalcFrac
	 generic map( FrWidth => oWIDTH-10)
	 port map( iY        => s_inFrc,
              iR        => s_Rnd,
              oCarry    => s_oCarry,
              oFraction => s_oFrac);	

Inst_CalcExp:
    CalcExp
	 port map( iExp     => iA(38 downto 31),
              iMSBPos  => s_pos,
              iRndFlag => s_oCarry,
              oExp     => s_oExp,
              oInf_n   => s_oInf_n,
              oInf_p   => s_oInf_p);
	
    oNR(oWIDTH  -1)                 <= iA(39);
    oNR(oWIDTH  -2 downto oWIDTH-9) <= s_oExp;
	 oNR(oWIDTH -10 downto        0) <= s_oFrac;

end Behavioral;

