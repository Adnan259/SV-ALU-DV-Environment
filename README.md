# SV-ALU-DV-Environment

This is a **SystemVerilog project** demonstrating an 8-bit ALU with a **UVM-like verification environment**.  
It includes the ALU design, testbench, and verification environment classes to perform automated checks of results and flags.

---

## Features

- 8-bit ALU supporting operations:  
  - AND, OR, XOR, ADD, SUB, INC, DEC, SHIFT LEFT
- Flags:  
  - Zero, Carry, Overflow, Negative
- Complete verification environment:  
  - Transaction class  
  - Generator  
  - Driver  
  - Monitor  
  - Scoreboard  
  - Environment class  

---

---

## ALU Operations

| ALU_Sel | Operation     | Description                | Flags Affected                      |
|---------|--------------|----------------------------|--------------------------------------|
| 000     | AND           | Bitwise AND of A & B       | Zero, Negative                      |
| 001     | OR            | Bitwise OR of A & B        | Zero, Negative                      |
| 010     | XOR           | Bitwise XOR of A & B       | Zero, Negative                      |
| 011     | ADD           | Addition A + B             | Zero, Negative, Carry, Overflow     |
| 100     | SUB           | Subtraction A - B          | Zero, Negative, Carry, Overflow     |
| 101     | INC           | Increment A by 1           | Zero, Negative, Carry, Overflow     |
| 110     | DEC           | Decrement A by 1           | Zero, Negative, Carry, Overflow     |
| 111     | SHIFT LEFT    | Logical shift left of A    | Zero, Negative, Carry, Overflow     |

> **Note:** Carry for shift left is generated from the MSB that is shifted out. Overflow is A[7] ^ A[6] for logical shift.

---

## Flags Description

- **Zero (Z):** Set to 1 if result is 0.  
- **Carry (C):** Set if an arithmetic carry/borrow occurs or MSB shifted out in shift operations.  
- **Overflow (V):** Set if signed overflow occurs in arithmetic operations.  
- **Negative (N):** Set if the MSB of the result is 1.  

---

## Verification Environment

The verification environment consists of:

1. **Transaction class:** Holds input and output data for ALU.  
2. **Generator:** Creates random input transactions.  
3. **Driver:** Drives transactions to the ALU interface.  
4. **Monitor:** Observes ALU outputs and captures results.  
5. **Scoreboard:** Compares expected results (reference model) with ALU outputs, including flag checking.  

- All flags and operations are verified for correctness.  
- Scoreboard prints pass/fail messages for each transaction.  

---

## Folder Structure

SV-ALU-DV-Environment  
├─ rtl/             → ALU design files (design_ALU.sv)  
├─ interface/       → Interface files (alu_if.sv)  
├─ tb/              → Testbench top files (testbench_top.sv)  
├─ env/             → Verification environment files  
│     ├─ environment.sv  
│     ├─ transaction.sv  
│     ├─ generator.sv  
│     ├─ driver.sv  
│     ├─ monitor.sv  
│     └─ scoreboard.sv  
├─ README.md        → Project description  
└─ .gitignore       → Ignored simulation/log files  

---

## Online Simulation

You can run this ALU and verification environment **online** using [EDA Playground](https://www.edaplayground.com/x/aDND).

- Includes: ALU design, testbench, and verification environment  
- Supports: SystemVerilog simulation  

---

## Simulation Instructions

1. Open `tb_top.sv` in your simulator (EDA Playground, Questa, VCS, etc.)  
2. Compile all files in the order:  
   1. `rtl/design_ALU.sv`  
   2. `interface/alu_if.sv`  
   3. `env/transaction.sv`  
   4. `env/generator.sv`  
   5. `env/driver.sv`  
   6. `env/monitor.sv`  
   7. `env/scoreboard.sv`  
   8. `env/environment.sv`  
   9. `tb/testbench_top.sv`
3. Run simulation to see ALU operations and flag checks automatically printed in the console.  

---

## Notes

- `.gitignore` included to ignore simulation outputs (logs, VCD, WLF files).  
- Flags are automatically verified in the **scoreboard**.  
- Designed for **educational and demonstration purposes**.  

---

## Author

**Adnan Sami Anirban** 
-Email: adnananirban259@gmail.com

B.Sc. in EEE | Digital Design & Verification Enthusiast
