#!/bin/bash
iverilog_compile.sh src/vga_controller*v*
gtkwave test.lxt &
