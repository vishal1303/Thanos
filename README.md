# Thanos
Programmable Multi-Dimensional Table Filters for Line Rate Network Functions

## Hardware code for ASIC area and timing
This repository contains the code for various hardware components (.sv files) of Thanos. Each .tcl file can be run in Synopsys Design Compiler RTL Synthesis tool to generate the area and timing for each hardware component (.area and .timing files in the repo contain the outputs of area and timing for one such run of the corresponding .tcl files). To run the .tcl files in Synopsys Design Compiler RTL Synthesis tool, run the following command.
```shell
$ dc_shell -f /path/to/tcl/file
```

## Running Thanos on an FPGA
To run Thanos on FPGA, we use [P4FPGA](https://dl.acm.org/doi/10.1145/3050220.3050234) code available [here](http://p4fpga.github.io). To integrate Thanos with P4FPGA, first compile P4FPGA code to generate intermediate system verilog code files, and then manually import the Thanos modules from this repository into those files.

## Thanos Simulator
Thanos simulator runs on top of modified [NDP](https://dl.acm.org/doi/10.1145/3098822.3098825) simulator and the code is available [here](https://github.com/vishal1303/NDP).
