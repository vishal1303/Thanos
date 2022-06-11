# Thanos
Programmable Multi-Dimensional Table Filters for Line Rate Network Functions

## Hardware code for ASIC area and timing
This repository contains the code for various hardware components of Thanos. Each .tcl file can be run to generate the area and timing for each hardware component (.area and .timing files contain the outputs of area and timing for one such run of the corresponding .tcl files).

## Running Thanos on an FPGA
To run Thanos on FPGA, we use [P4FPGA](https://dl.acm.org/doi/10.1145/3050220.3050234) code available [here](http://p4fpga.github.io). To integrate Thanos with P4FPGA, first compile P4FPGA code to generate intermediate system verilog code files, and manually add the Thanos modules from this repository into those files.

## Thanos Simulator
Thanos simulator runs on top of [NDP](https://dl.acm.org/doi/10.1145/3098822.3098825) simulator and is available [here](https://github.com/vishal1303/NDP)
