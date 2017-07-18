// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Sun Jul 16 21:20:17 2017
// Host        : Gianni-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ c_addsub_0_sim_netlist.v
// Design      : c_addsub_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_0,c_addsub_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_10 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_10
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_addsub_v12_0_10_viv xst_addsub
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
DzPkXooupZs1zuf0eTQH3O9MzMf7H9T2P6EdaHWdnV/3yIntPQbg1o6qcGdcGBvvTFHX3TzKhh14
i29ccg/X/4fpVlFdKBE7MzQNbXc0gDWuujFDOlP2EzTEq5fuZslPLrCK2zIaN74HzibWWCObn/jc
IAkR3HJQBXeCTpqX1bufwbIgEvpGqkRE67jhtxTb1mUerJplimDgc/6T3hrYa+Z+e4Tcqk9+E24o
UyAoy5+Sfq4PaU0vkS3J20c39s/OpKP93caOolGRx5sq9QvuzsOmyExjdCf+KTKqohjwPqd21amq
BJoyGQaFDKW/eN+L2yzlL0I57GaIm6e/ptN0cg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
bm2Ax0CLO4Yfv7s3JyoyzMG3fIlkpghuwdKKFdvlSE8tCVRBDeJ7rcw3iX35Bq/607eNdIfFf0qT
A3ZAzho5W9Nx+63o4LqgubUNxvFvtphfD8102PGb+VTNtEeLMyGnOPz+lYTksnWQCJ8CQ4aJ0gjw
+aEhA43GZ+0Aq4T7yrZ9ukJGuvjVz6I5wgwT4jaNBcBxvTJ5jN665VzJUaVAhO5VHEZJTXqjDQca
WZxuTirxGsomII05M0la2EcSeqp47OlZMUchsclpn8ZCCrbZ1LIHrbxYT2jmCmDDkSBvmuK+pIsx
8Ka6kfEvj3H2liWFWvqZnanO9NyDUN0LJ2gfJQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 43296)
`pragma protect data_block
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
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
