`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  transaction tr;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  mailbox #(transaction) mbx;  //// send to driver
  mailbox #(transaction) mbxref; // send to scoreboard
  mailbox #(transaction) mbx_ms; // mon to sco
  
  event done;
  event sco_ev;
  
  virtual alu_if aif;
  
  function new(virtual alu_if aif);
    mbx = new();
    mbxref = new();
    mbx_ms = new();
    gen = new(mbx,mbxref,done,sco_ev);
    drv = new(mbx,aif);
    mon = new(mbx_ms,aif);
    sco = new(mbx_ms,mbxref,sco_ev);
  endfunction
  
  
  task run();
      fork
        gen.run();
        drv.run();
        mon.run();
        sco.run();
        
      join_any
      wait(done.triggered);
      $finish();
  endtask 
  
endclass