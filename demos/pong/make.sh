#!/bin/sh

set -e

./clean.sh

yosys < make.yosys
arachne-pnr -d 1k -P vq100 -p main.pcf main.blif -o main.asc
icetime -c 40 main.asc
icepack main.asc main.bin
iceprog main.bin 

