#### Final report incoming. I'm putting on the final touches.

### Note:
The only code I wrote is the system verilog code and the verilog header files. HThere is a 'comes with the box' pll from Altera, but likewise that should be ignored. 

# QWAC

A neural processing unit based off of Microsoft's Brainwave, with some things added and other things changed. Please read the final report for more information concerning the differences and similarities. 

## Build Instructions

This repo contains the testbenches and the build files. The testbenches are written in and conform to a Xilix vivado format due to the ease of simulation and debugging in the Vivado IDE. These can be found in `project_1.srcs` folder. The build instructions are located everywhere else, and conform to Altera's Quartus IDE. While debugging and testing are easier in Vivado, I only had access to an Altera FPGA (specifically the DE10-Nano board that hosts the Cyclone V 5CSBA6U23I7NDK FPGA. 


As Quartus is more visual than Vivado, there are a lot of visual and programming files assosiated with Quartus. 

Build instructions are to load up the SystemVerilog code into your favortite IDE and program, test, debug, etc. from there. 

## How it works

Please see the final report

## How well is it tested?

This is still very much a work in progress, and frankly was a lot to attempt to do. As of right now, the only thing that works is MatVec multiplying hard-coded matrices and vectors. It is done fast! (within a couple hundred clock cycles). The memory is not connected, an API is not written, and there is nothing that allows for this to be used in a real-world situation of machine learning. 

## TODO

There needs to be a cpp file written to allow for communication between the FPGA and the host computer. This will use FTDI's D2XX drivers. Furthermore, some sort of bios will need to be written for the FPGA to know when/what to compute on.

There needs to be a way to connect the memory (project\_1.srcs/sources\_1/new/on\_chip\_mem.sv) and the hardware implementing the rest of the API (project\_1.srcs\sources\_1/new/vv\_ops.sv) into the chip and to make it communicate with the MatVecMultiplier.

What is descriped in two small paragraphs is a lot of work!

## Special Thanks

This project comes out of UC Berkeley's EE290: Hardware for Machine Learning class, and I would like to shout out to the professor Sophia Shao and the GSIs Hasan Genc and Alon Amid. I honestly learned so much and even though this is far from complete, I genuinely learned a lot!
