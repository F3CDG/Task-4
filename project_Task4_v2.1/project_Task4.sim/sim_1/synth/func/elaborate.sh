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
ExecStep $xv_path/bin/xelab -wto 944380bbb0d0493e83ec2f6b5b7eb474 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot Task4_tb_func_synth xil_defaultlib.Task4_tb -log elaborate.log
