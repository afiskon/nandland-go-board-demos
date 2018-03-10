#!/bin/sh

set -e

./clean.sh

yosys -p "read_verilog UART_RX.v; read_verilog UART_TX.v; read_verilog Binary_To_7Segment.v; read_verilog main.v; synth_ice40 -blif main.blif"
arachne-pnr -d 1k -P vq100 -p main.pcf main.blif -o main.asc
icetime -c 40 main.asc
icepack main.asc main.bin
iceprog main.bin 

