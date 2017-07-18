// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Sun Jul 16 21:20:18 2017
// Host        : Gianni-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {C:/Users/giann/Desktop/PROGETTO FINALE/versione 1 - tutto
//               xilinx/project_Task4/project_Task4.srcs/sources_1/ip/c_addsub_0/c_addsub_0_sim_netlist.v}
// Design      : c_addsub_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_0,c_addsub_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module c_addsub_0
   (A,
    B,
    CLK,
    SCLR,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [62:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [62:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) output [63:0]S;

  wire [62:0]A;
  wire [62:0]B;
  wire CLK;
  wire [63:0]S;
  wire SCLR;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "63" *) 
  (* c_add_mode = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "000000000000000000000000000000000000000000000000000000000000000" *) 
  (* c_b_width = "63" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "64" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_0_c_addsub_v12_0_10 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "1" *) 
(* C_A_WIDTH = "63" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "1" *) (* C_B_VALUE = "000000000000000000000000000000000000000000000000000000000000000" *) 
(* C_B_WIDTH = "63" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "64" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "c_addsub_v12_0_10" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module c_addsub_0_c_addsub_v12_0_10
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [62:0]A;
  input [62:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [63:0]S;

  wire \<const0> ;
  wire [62:0]A;
  wire [62:0]B;
  wire CLK;
  wire [63:0]S;
  wire SCLR;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "63" *) 
  (* c_add_mode = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "000000000000000000000000000000000000000000000000000000000000000" *) 
  (* c_b_width = "63" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "64" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_0_c_addsub_v12_0_10_viv xst_addsub
       (.A(A),
        .ADD(1'b0),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
EgsHeoOxdUxsX5gIKiaj0rabVidhYZrAC1ccO7uW1WWUY+5F26NMKfuRo2RbzpHAhKg6YWmehafX
vTPGaJRKHw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Z34YzyhCkqWVBd+wfHLLkUW/H60lDZ7DBcaAzQK4qK/8LgoJdsH6DZ43BtKjfZhNz/T8CrFXpTq4
lXACmrJsvh8DNPmvB7LaQhnP9Q1UWB/2BUP3fAUHMA2d2pKOqEj3XF5pbikvIPiyQENN7Kn513bC
CvwAQIx2bzxkiYX1MZc=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SSMUY5NrZw2M/7w7U4gsSjNRmWfRCxfALTKD8+8C1h91c8RWo9X4x7A5m9YG0Pa491k6Lxf7I0eD
goajxjfLKNI+buWpvfZlHEcU7678iPGqz4g94c5n80sa3TKcwpV6f+p7C93Rto4JgUHSigA3gLBN
DzpD+6xOS6P2mkrRsQs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Tbb//X7l5IJljgHR/Q0swC7OpOr9LwQv6rxLgPXOMJNm5TebIkTTeQKZBlg96/x0gqqgFX19ZASr
qWxh3YL/aoYejZTUMHYF7ktggRgHydykFFfRo8xGrq33bJ1LOeuIQOZyZjZTB9zCoo8CMX8wCtcA
0ovBA4GCY5VFNLy/1whSrZs8R7CLSdrlxUJTTCXjF0f+Tf8OyjSS2VGyZfJbmSNnFJJuItoBbUO0
6qdcZfL3eQrA6y/AWPiFhGILWhBAvVGEahvuOHYDa8S1IUccHMOxQJtq0Y1UqRNB/qNmlHUKL/iH
IEr89vPUXnsfHTV4I+xFieSKz2LwzLXsAys4Yw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kfJNFYIhzZvlPwb4KI2aCH6Fx40tZkxF1Q5EfJSPdq2JohdV53Dn2x9HbgUIqvISu5UuFwT8R+oV
/B66+AOKivg+iSCvhh+HSv/oQNtgHeIG5xMgV8d3jXD9G4abV/g3jySuWrjXT9Z0IqvTQjqmKOR2
9nVDANRSJiSyM0Y275L4ylvrdjL8Yim0M/e9k+N+kNYfcQAzQYd/lfTmcdkn74/0qt030HQ2LxSy
A+NwqYXBuB4VkkCPvigd/s63XQNHxeHfRZs7q0iWos8Jgu9uI1zA6ZN4O4Cts2V9BF+SRqJdzrLy
1t5mzK/i0gmdsb8ds3y4b3AMet8PeT7w9sZc/A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MzDVqgEdc7DZdlm2cItrUQlry/9kVuVoApPpWX7zga11t+tLgAqain8Fhjl9Q1hFV6Rwv6WUUyOW
dL6uK1Pj4Tc0mqHyEMvAW2tHA/QcK0pphBofEd8Sd2oRBJ0l+XghTz/o5eIVzoxDF0h6fERIgAw6
PZK1iaI5d5osnKGqaJVhxQWf/M3XiOn9jCOGskyvtqNiiXNki/oAWPJNgm3Hb599C3ugMxNKGT5x
H76UXyZbcrmrFSkYz6XydewUEOb2eruDdZtf4QmJWyJ+WqAHgjSB7kcn3UfysW1iW59u7oxSpMgU
oLKWKFtXGSzN2+DVJ91qu7hIDmX5Q2X//JK4Cg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
TUtQ74hYUcCnYjpa5niLquI78b7n5y2cmttbNJO+q2aqstX6/OVnHZTVDSTQNOt7E6c6FAVceMOM
GRn5cms5dNIm0K+PF8fnZaI4J/EaAC9HODO357pcm3lHfhKe7/5eHB5II1GUnl86v1MkysajrhmZ
s6ry+bID4tCZ+3vrD967Q8wU5DeHUe/pxAggCZSGzL/lc/VXwHZy+EF8JhqDcmRgkd/KCP+UWDE8
4y3pXrRw+yyNvvpjIwW/D1v6OXEDp8h5+UUqBGzl5un7eLMRSWlX2SjJ8w4Fje5CvsaS7Z2jq4XG
iUaf1XFu6NPVSqMSP9+EeiQltagqKxBJ89vqcA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
HVqWEqCvac0lT9uYJOtt6hMIRENM4iVOhkq8ySbIxCQVDbSKtYmisxFGac1te+ZKlI8bNC81LaV6
oku5RTYpMx4TMtg/5T6fU/jI+f1z4q+S6S2PowZcm0OGMgW0SnVTKIQdkDAvOQ2EEnPwJaWCLNDb
DS1bLO2Xs+ippPulsYY6V2aeWh30Shxhh/vlZg7tL5REusYsF+gZzzQ7FQ4Q5j+H7ma+PInMUMmX
sV7wyTT9dhddvBLZ53hg2RNspNklH37m/Ean+56G4mbDtA4WB1nf6xid7Uj/CiiWiYDIGJaWVs4M
tYst1Ad+LzYX1n4bbYzEAncICUag45+Tows1gg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 43264)
`pragma protect data_block
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
fA==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
