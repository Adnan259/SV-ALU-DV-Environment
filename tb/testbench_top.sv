`include "environment.sv"
`include "interface.sv"


module tb;
  environment env;
  bit clk;
  bit reset;
  
  initial begin 
    clk = 0;
    reset = 0; 
  end
  
  always #10 clk = ~clk;
  always #90 reset = ~reset;
  
  
  
  alu_if aif(clk,reset);
  
  ALU DUT(
    	  .clk(clk),
          .reset(reset),
          .A(aif.A),
          .B(aif.B),
          .ALU_Sel(aif.ALU_Sel),
          .Result(aif.Result),
          .Zero(aif.Zero),
          .Carry(aif.Carry),
          .Overflow(aif.Overflow),
          .Negative(aif.Negative)
  );
  
  initial begin
    env = new(aif);
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  
  
endmodule