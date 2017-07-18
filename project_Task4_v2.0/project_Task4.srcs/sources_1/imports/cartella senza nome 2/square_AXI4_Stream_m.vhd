----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2017 12:48:49
-- Design Name: 
-- Module Name: square_root_wrapped_m - Structural
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

entity AXI4_Stream_square_m is
    Port ( aresetn : in STD_LOGIC;
           aclk : in STD_LOGIC;
           s_axis_tdata : in STD_LOGIC_VECTOR (63 downto 0);
           s_axis_tvalid : in STD_LOGIC;
           s_axis_tready : out STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (63 downto 0);
           m_axis_tvalid : out STD_LOGIC;
           m_axis_tready : in STD_LOGIC);
end AXI4_Stream_square_m;

architecture Structural of AXI4_Stream_square_m is

    component square_control_unit_m is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           s_axis_tvalid : in STD_LOGIC;
           m_axis_tready : in STD_LOGIC;
           enable_buffer_in : out STD_LOGIC;
           enable_buffer_out : out STD_LOGIC;
           reset_buffer_in_n : out STD_LOGIC;
           reset_buffer_out_n : out STD_LOGIC;
           s_axis_tready : out STD_LOGIC;
           m_axis_tvalid : out STD_LOGIC);
    end component;
    
    component square_operative_unit_m is
        Port ( s_axis_tdata : in STD_LOGIC_VECTOR (63 downto 0);
               aresetn : in STD_LOGIC;
               aclk : in STD_LOGIC;
               enable_buffer_in : in STD_LOGIC;
               enable_buffer_out : in STD_LOGIC;
               reset_buffer_in_n : in STD_LOGIC;
               reset_buffer_out_n : in STD_LOGIC;
               m_axis_tdata : out STD_LOGIC_VECTOR(63 downto 0));
    end component;
    
    signal enable_buffer_in : std_logic :='0';
    signal enable_buffer_out : std_logic :='0';
    signal reset_buffer_in_n : STD_LOGIC:='1';
    signal reset_buffer_out_n : STD_LOGIC:='1';
    
begin

    CONTROL_UNIT_INST : square_control_unit_m port map( 
        aclk => aclk,
        aresetn => aresetn,
        s_axis_tvalid => s_axis_tvalid,
        m_axis_tready => m_axis_tready,
        enable_buffer_in => enable_buffer_in,
        enable_buffer_out => enable_buffer_out,
        s_axis_tready => s_axis_tready,
        reset_buffer_out_n => reset_buffer_out_n,
        reset_buffer_in_n => reset_buffer_in_n,
        m_axis_tvalid => m_axis_tvalid);
        
    OPERATIVE_UNIT_INST : square_operative_unit_m port map( 
        s_axis_tdata => s_axis_tdata,
        aresetn => aresetn,
        aclk => aclk,
        enable_buffer_in => enable_buffer_in,
        enable_buffer_out => enable_buffer_out,
        reset_buffer_out_n => reset_buffer_out_n,
        reset_buffer_in_n => reset_buffer_in_n,
        m_axis_tdata => m_axis_tdata);


end Structural;
