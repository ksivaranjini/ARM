# SYNTHESIS OF CORTEX-M0

## **Abstract**

To build a basic SoC platform

## **Introduction**

In this project, the aim is to build a basic Soc platform. A verilog code which implements cortex M0 processor (from ARM) has 
been prototyped onto a FPGA. 

## **Softwares and Components used**
-	Keil simulator
-	Xilinx vivado 
-	Basys 3 Artix-7 FPGA board
-	Cadence tools- genus and innovus

## **Procedure**

This program is simulated in Keil μVision to create a code.hex file. This executable code.hex file 
is copied to FPGA project directory and is synthesized and implemented as per Basys3 FPGA board in xilinx vivado. From vivado, 
bitstream file is generated which is dumped onto a FPGA board and we observe the led output. In addition to this the layout of 
the processor is done on cadence tool.

## **Synopsis of the Code**

Initialize the interrupt vector. Two inputs are given say 55 (01010101) and AA (10101010). There are 8 LEDs namely 1 to 8. In 
the reset handler, turn on half of the LEDs i.e LED[2,4,6,8] and a counter is set which is used as a delay. Turn on the other 
half of LEDs ie LED[1,3,5,7]. And delay for another period and this repeats.

The code contains the following blocks
- cortexm0ds_logic.v - This is generating all the signals required for a processor.
- CORTEXM0INTEGRATION.v - This is integrating the required sets to make processor module
- AHBDCD.v  - The address decoder of the AHB bus. It has the input as address and the program decodes the program and creates the 
selector bits and mux selector bits
- AHBMUX.v  - The slave multiplexor of the AHB bus. It takes mux selector bits in the program it finds master-slave combination.
- AHB2BRAM.v - The on-chip memory (BRAM) used for the program memory of the processor
- AHB2LED.v – the LED peripheral module
- AHBLITE_SYS.v  - the top module.

## **SoC peripherals**

![soc peripheral](https://user-images.githubusercontent.com/42762473/49689505-23b3c080-fb48-11e8-8175-80657015085c.jpg)

## **Basys 3 Artix-7 Board:**

![basys](https://user-images.githubusercontent.com/42762473/49689534-768d7800-fb48-11e8-8116-63ac00d001db.jpg)

In this project,we have been using FPGA board.It has 1,800 Kbits of fast block RAM, 12-bit VGA output, 16 user leds, 16 user 
switches, 4-digit 7-segment display. For this project we used 8 LEDs, one reset and clock of 100MHz.

## **Cadence tool**
In the cadence tool, using genus we generated the gate level netlist file. this is given to another tool called innovus from which the pre layout synthesis is done. Then the power analysis, setup analysis and hold analysis is done. And post layout simulation was not as the CTS option was not available in the existing cadence tool.

As an extension work we tried to change the code, so it takes two inputs where first input < second input. At every clock cycle, 
the LED would blink in an incremental pattern till it reaches the second input. We could generate the code.hex file. But the 
synthesis is not done. 
