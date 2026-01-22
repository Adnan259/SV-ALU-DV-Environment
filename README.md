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
B.Sc. in EEE | Digital Design & Verification Enthusiast