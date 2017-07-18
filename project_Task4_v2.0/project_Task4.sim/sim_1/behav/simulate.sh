#!/bin/bash -f
xv_path="/usr/Xilinx/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim Task4_automatic_tb_behav -key {Behavioral:sim_1:Functional:Task4_automatic_tb} -tclbatch Task4_automatic_tb.tcl -log simulate.log
