class driver;
  transaction tr;
  mailbox #(transaction) mbx;  //// get from generator
  event sco_ev;
  virtual alu_if aif;
  
  function new(mailbox #(transaction) mbx,virtual alu_if aif);
   // tr = new();
    this.aif = aif;
    this.mbx = mbx;
    
  endfunction
  
  task run();
    forever begin
      mbx.get(tr);
      @(posedge aif.clk);
      //aif.reset <= tr.aif;
      aif.A <= tr.A;
      aif.B <= tr.B;
      aif.ALU_Sel <= tr.ALU_Sel;
      $display("-------------------------------------------");
      //$display("[DRV] RCV DATA");
      //tr.display();
      //->sco_ev;
    end
  endtask
endclass
      
    