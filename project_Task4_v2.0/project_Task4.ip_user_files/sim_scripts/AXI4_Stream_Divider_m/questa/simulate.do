onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib AXI4_Stream_Divider_m_opt

do {wave.do}

view wave
view structure
view signals

do {AXI4_Stream_Divider_m.udo}

run -all

quit -force
