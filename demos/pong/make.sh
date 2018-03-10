#!/bin/sh

set -e

./clean.sh

# TODO: create build.yosys file
yosys -p "read_verilog main.v; read_verilog VGA_Sync_Porch.v; read_verilog VGA_Sync_Pulses.v; read_verilog Sync_To_Count.v; read_verilog Debounce_Switch.v; read_verilog Pong_Top.v; read_verilog Pong_Paddle_Ctrl.v; read_verilog Pong_Ball_Ctrl.v; synth_ice40 -blif main.blif"
arachne-pnr -d 1k -P vq100 -p main.pcf main.blif -o main.asc
icetime -c 40 main.asc
icepack main.asc main.bin
iceprog main.bin 

