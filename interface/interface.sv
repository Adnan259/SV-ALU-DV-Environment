`ifndef INTEFACE_SV
`define INTEFACE_SV

interface alu_if(input bit clk, input bit reset);
  logic [7:0] A;
  logic [7:0] B;
  logic [2:0] ALU_Sel;
  logic [7:0] Result;
  logic Zero;
  logic Carry;
  logic Overflow;
  logic Negative;
  
endinterface
`endif