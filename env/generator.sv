class generator;
  transaction tr;
  mailbox #(transaction) mbx;  //// send to driver
  mailbox #(transaction) mbxref; // send to scoreboard
  event done;
  event sco_ev;
  
  function new(mailbox #(transaction) mbx,mailbox #(transaction) mbxref,event done,event sco_ev);
    tr = new();
    this.mbx = mbx;
    this.mbxref = mbxref;
    this.done = done;
    this.sco_ev = sco_ev;
  endfunction
  
  task run();
    for(int i=0;i<100;i++) begin
      assert(tr.randomize()) else $display("ERROR RANDOMIZATION");
      $display("-------------------------------------------");
      $display("[GEN] Data send to DRV");
      tr.display();
      mbx.put(tr.copy);
      mbxref.put(tr.copy);
      @(sco_ev);
    end
    ->done;
  endtask
endclass
      
      
      
      
  