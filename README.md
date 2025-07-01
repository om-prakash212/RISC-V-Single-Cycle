Single-Cycle RISC-V Processor (Verilog HDL)

This project implements a Single-Cycle RISC-V Processor using Verilog HDL, simulating the core concepts of RISC-V architecture with a clean modular design. The processor supports all basic instruction formats (R, I, S, B, U, J) and is verified using ModelSim waveform analysis.

Features: 

* Implements RV32I Base Instruction Set
* Modular design: ALU, Control Unit, Register File, Instruction & Data Memory, Sign Extension, PC logic
* Simulated using ModelSim with clock-by-clock waveform validation
* Supports:
Arithmetic & Logic (ADD, SUB, AND, OR, SLT)
Load/Store (LW, SW)
Branch & Jump (BEQ, JAL)
Immediate operations (ADDI, ANDI, ORI)
* Testbench to verify correct instruction execution
* Easily extensible to pipelined or multicycle designs
* Modules

Single_Cycle_Top.v – Top-level processor integration
ALU.v – Arithmetic and logical operations
Control_Unit.v – Main decoder and ALU decoder
Register_File.v – 32x32-bit register set
Instruction_Memory.v – Preloaded memory using memfile.hex
Data_Memory.v – Load and store handler
Sign_Extend.v – Immediate field expansion
PC.v, PC_Adder.v – Program counter logic


