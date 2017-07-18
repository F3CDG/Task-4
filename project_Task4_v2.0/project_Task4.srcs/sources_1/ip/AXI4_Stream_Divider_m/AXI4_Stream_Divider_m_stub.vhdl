-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Sun Jul 16 21:15:40 2017
-- Host        : daniele-Inspiron-7559 running 64-bit Ubuntu 16.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub {/home/daniele/Sistemi_Embedded/Final_project/versione 3 - sqrt
--               daniele/project_Task4/project_Task4.srcs/sources_1/ip/AXI4_Stream_Divider_m/AXI4_Stream_Divider_m_stub.vhdl}
-- Design      : AXI4_Stream_Divider_m
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4_Stream_Divider_m is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_divisor_tvalid : in STD_LOGIC;
    s_axis_divisor_tready : out STD_LOGIC;
    s_axis_divisor_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_dividend_tvalid : in STD_LOGIC;
    s_axis_dividend_tready : out STD_LOGIC;
    s_axis_dividend_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_dout_tvalid : out STD_LOGIC;
    m_axis_dout_tready : in STD_LOGIC;
    m_axis_dout_tdata : out STD_LOGIC_VECTOR ( 103 downto 0 )
  );

end AXI4_Stream_Divider_m;

architecture stub of AXI4_Stream_Divider_m is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,s_axis_divisor_tvalid,s_axis_divisor_tready,s_axis_divisor_tdata[63:0],s_axis_dividend_tvalid,s_axis_dividend_tready,s_axis_dividend_tdata[63:0],m_axis_dout_tvalid,m_axis_dout_tready,m_axis_dout_tdata[103:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "div_gen_v5_1_11,Vivado 2016.4";
begin
end;
