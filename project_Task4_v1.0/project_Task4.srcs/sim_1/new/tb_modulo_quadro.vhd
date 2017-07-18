----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2017 18:20:05
-- Design Name: 
-- Module Name: tb_modulo_quadro - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_modulo_quadro is
--  Port ( );
end tb_modulo_quadro;

architecture Behavioral of tb_modulo_quadro is
component modulo_quadro is
    Port ( Re_Early : in STD_LOGIC_VECTOR (31 downto 0);
           Im_Early : in STD_LOGIC_VECTOR (31 downto 0);
           Re_Late : in STD_LOGIC_VECTOR (31 downto 0);
           Im_Late : in STD_LOGIC_VECTOR (31 downto 0);        
           Early2 : out STD_LOGIC_VECTOR (63 downto 0);
           Late2 : out STD_LOGIC_VECTOR (63 downto 0);
           clk : in STD_LOGIC);
end component;

signal clk : STD_LOGIC:='0';

signal  Re_Early :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal  Im_Early :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal  Re_Late :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal  Im_Late :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');        

signal  Early2 : STD_LOGIC_VECTOR (63 downto 0);
signal  Late2 : STD_LOGIC_VECTOR (63 downto 0);



constant clock_period: time:= 10 ns;
begin

-- Instantiate the Unit Under Test (UUT)
   uut: modulo_quadro PORT MAP (
          clk=>clk,
          Re_Early => Re_Early,
          Im_Early => Im_Early,
          Re_Late => Re_Late,
          Im_Late => Im_Late,
          Early2 =>Early2,
          Late2=>Late2
        );
              
  -- Clock process definitions
 clock_process :process
 begin
      clk <= '0';
      wait for clock_period/2;
      clk <= '1';
      wait for clock_period/2;
 end process;
       
      
         -- Stimulus process
 stim_proc: process
         begin        
            -- hold reset state for 100 ns.
            wait for 100 ns;
            Re_Early<=x"00000003";
            Im_Early<=x"00000004";
            
            Re_Late<=x"00000103";
            Im_Late<=x"00000204";
            wait for 100 ns;
            wait for clock_period*20;
            wait; 
         end process;





end Behavioral;
