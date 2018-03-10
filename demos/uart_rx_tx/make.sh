#!/bin/sh

set -e

./clean.sh

yosys -p "synth_ice40 -blif main.blif" main.sv UART_TX.v
arachne-pnr -d 1k -P vq100 -p main.pcf main.blif -o main.asc
icetime -c 40 main.asc
icepack main.asc main.bin
iceprog main.bin 

