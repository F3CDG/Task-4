// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Sun Jul 16 21:20:18 2017
// Host        : Gianni-Desktop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/giann/Desktop/PROGETTO FINALE/versione 1 - tutto
//               xilinx/project_Task4/project_Task4.srcs/sources_1/ip/c_addsub_0/c_addsub_0_stub.v}
// Design      : c_addsub_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_addsub_v12_0_10,Vivado 2016.3" *)
module c_addsub_0(A, B, CLK, SCLR, S)
/* synthesis syn_black_box black_box_pad_pin="A[62:0],B[62:0],CLK,SCLR,S[63:0]" */;
  input [62:0]A;
  input [62:0]B;
  input CLK;
  input SCLR;
  output [63:0]S;
endmodule
