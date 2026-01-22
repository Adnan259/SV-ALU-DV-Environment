`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
    bit reset;               //Active hign;
    randc bit [7:0] A;       // 8-bit operand A
    randc bit [7:0] B;       // 8-bit operand B
    randc bit [2:0] ALU_Sel; // ALU operation select
    bit [7:0] Result;       // 8-bit result
    bit Zero;              // Zero flag
    bit Carry;             // Carry flag
    bit Overflow;          // Overflow flag
    bit Negative;		   // Negative flag
  
  function transaction copy();
    copy = new();
   // copy.reset = this.reset;
    copy.A = this.A;
    copy.B = this.B;
    copy.ALU_Sel = this.ALU_Sel;
    copy.Result = this.Result;
    copy.Zero = this.Zero;
    copy.Carry = this.Carry;
    copy.Overflow = this.Overflow;
    copy.Negative = this.Negative;
  endfunction
  
  function void display();
    $display("Reset: %0d\t A: %0d\t B: %0d\t ALU_Sel: %0d\t Result: %0d\nZero: %0d\t Carry: %0d\t Overflow: %0d\t Negative: %0d",reset,A,B,ALU_Sel,Result,Zero,Carry,Overflow,Negative);
  endfunction
  
endclass

`endif
    
    
  