----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:07:44 02/07/2019 
-- Design Name: 
-- Module Name:    Prioritycoder8x3 - Behavioral 
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

entity Prioritycoder8x3 is
    port( iX  : in  std_logic_vector(7 downto 0);
          oZ  : out std_logic_vector(2 downto 0);
          oAct: out std_logic );
end Prioritycoder8x3;

architecture Behavioral of Prioritycoder8x3 is

    component PriorityCoder4x2
        port( iX   : in  std_logic_vector(3 downto 0);
              oZ   : out std_logic_vector(1 downto 0);
              oAct : out std_logic );
    end component;

   signal s_ActiveL : std_logic;
   signal s_ActiveH : std_logic;

   signal s_oZL     : std_logic_vector(1 downto 0);
   signal s_oZH     : std_logic_vector(1 downto 0);

   signal s_oZ      : std_logic_vector(2 downto 0);
   signal s_oAct    : std_logic;

begin

Inst_PriorityCoder4x2_L:
    PriorityCoder4x2
    port map( iX   => iX(3 downto 0),
              oZ   => s_oZL,
              oAct => s_ActiveL);

Inst_PriorityCoder4x2_H:
    PriorityCoder4x2
    port map( iX   => iX(7 downto 4),
              oZ   => s_oZH,
              oAct => s_ActiveH);
				  
    process(s_oZL, s_ActiveL, s_oZH, s_ActiveH)
    begin
        if s_ActiveH = '1' then
            s_oAct <= '1';
            s_oZ   <= '0' & s_oZH;
        elsif s_ActiveL = '1' then
            s_oAct <= '1';
            s_oZ   <= '1' & s_oZL;
        else
            s_oAct <= '0';
            s_oZ   <= "000";
        end if;
    end process;

    oZ   <= s_oZ;
    oAct <= s_oAct;
end Behavioral;

