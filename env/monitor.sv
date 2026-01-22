class monitor;
  transaction tr;
  virtual alu_if aif;
  mailbox #(transaction) mbx_ms;
  
  function new(mailbox #(transaction) mbx_ms,virtual alu_if aif);
    tr = new();
    this.aif = aif;
    this.mbx_ms = mbx_ms;  
  endfunction
  
  task run();
    forever begin
      repeat(3) @(posedge aif.clk);
      tr.reset = aif.reset;
      tr.A = aif.A;
      tr.B = aif.B;
      tr.ALU_Sel = aif.ALU_Sel;
      tr.Result = aif.Result;
      tr.Zero = aif.Zero;
      tr.Carry = aif.Carry;
      tr.Overflow = aif.Overflow;
      tr.Negative = aif.Negative;
      mbx_ms.put(tr);
    end
  endtask
  
endclass
  
      
      
      
      
      
      
      