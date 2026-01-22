class scoreboard;
  transaction tr;
  transaction trref;
  mailbox #(transaction) mbx_ms;
  mailbox #(transaction) mbxref;
  event sco_ev;
  
  function new(mailbox #(transaction) mbx_ms, mailbox #(transaction) mbxref,event sco_ev);
    this.mbx_ms = mbx_ms;
    this.mbxref = mbxref;
    this.sco_ev = sco_ev;
  endfunction

  
  
  // -----------------------------
// Scoreboard tasks
// -----------------------------
  


// Task to check the ALU result
task test(input transaction trref, input transaction tr);
    case(trref.ALU_Sel)
        3'b000: if ((trref.A & trref.B) == tr.Result)
                    $display("Bitwise AND Result Matched");
                else
                    $error("Bitwise AND Result UNMatched");

        3'b001: if ((trref.A | trref.B) == tr.Result)
                    $display("Bitwise OR Result Matched");
                else
                    $error("Bitwise OR Result UNMatched");

        3'b010: if ((trref.A ^ trref.B) == tr.Result)
                    $display("Bitwise XOR Result Matched");
                else
                    $error("Bitwise XOR Result UNMatched");

        3'b011: if ((trref.A + trref.B) == tr.Result)
                    $display("ADDITION Result Matched");
                else
                    $error("ADDITION Result UNMatched");

        3'b100: if ((trref.A - trref.B) == tr.Result)
                    $display("SUBSTRACTION Result Matched");
                else
                    $error("SUBSTRACTION Result UNMatched");

        3'b101: if ((trref.A + 1) == tr.Result)
                    $display("INCREMENT Result Matched");
                else
                   $error("INCREMENT Result UNMatched");

        3'b110: if ((trref.A - 1) == tr.Result)
                    $display("DECREMENT Result Matched");
                else
                    $error("DECREMENT Result UNMatched");

        3'b111: if ((trref.A << 1) == tr.Result)
                    $display("LEFT SHIFT Result Matched");
                else
                    $error("LEFT SHIFT Result UNMatched");

        default: $display("ALU_SEL UNDEFINED");
    endcase
endtask
  


// Task to check Zero flag
task zero(input transaction tr);
    if ((tr.Result == 8'b0) && (tr.Zero == 1)||(tr.Result != 8'b0 && tr.Zero == 0))
        $display("Zero Flag Matched");
    else
        $error("Zero Flag UNMatched");
endtask


// Task to check Carry flag
task carry(input transaction trref, input transaction tr);
    reg [8:0] temp;
    reg car;
    case(trref.ALU_Sel)
        3'b000,3'b001,3'b010: car = 0;  // logical ops: no carry
        3'b011: begin  // ADD
            temp = trref.A + trref.B;
            car = temp[8];
        end
        3'b100: begin  // SUB
            temp = trref.A - trref.B;
            car = ~temp[8];
        end
        3'b101: begin  // INC
            temp =  trref.A + 1;
            car = temp[8];
        end
        3'b110: begin  // DEC
            temp = trref.A - 1;
            car = ~temp[8];
        end
      3'b111: car = trref.A[7];
        default: car = 0;
    endcase

    if (tr.Carry == car)
        $display("Carry Flag Matched");
    else
        $error("Carry Flag UNMatched");
endtask


// Task to check Overflow flag
task overflow(input transaction trref, input transaction tr);
    reg [7:0] temp;
    reg ovr;
    case(trref.ALU_Sel)
        3'b000,3'b001,3'b010: ovr = 0;  // logical ops: no overflow
        3'b011: begin // ADD
            temp = trref.A + trref.B;
            ovr = (~(trref.A[7] ^ trref.B[7])) & (trref.A[7] ^ temp[7]);
        end
        3'b100: begin // SUB
            temp = trref.A - trref.B;
            ovr = (trref.A[7] ^ trref.B[7]) & (trref.A[7] ^ temp[7]);
        end
        3'b101: begin // INC
            temp = trref.A + 1;
            ovr = (~trref.A[7]) & temp[7];
        end
        3'b110: begin // DEC
            temp = trref.A - 1;
            ovr = trref.A[7] & ~temp[7];
        end
        3'b111:
          //temp= trref.A<<1;
          ovr = trref.A[7] ^ trref.A[6];
        default: ovr = 0;
    endcase

    if (tr.Overflow == ovr)
        $display("Overflow Flag Matched");
    else
        $error("Overflow Flag UNMatched");
endtask


// Task to check Negative flag
  task negative(input transaction tr);
    if (tr.Negative == tr.Result[7])
        $display("Negative Flag Matched");
    else
        $error("Negative Flag UNMatched");
endtask

  ////////////////////// WHEN RESET NOT ASSERTED////////////////////
  task unreset(input transaction tr,input transaction trref);
      test(trref,tr);
      zero(tr);
      carry(trref,tr);
      overflow(trref,tr);
      negative(tr);
  endtask
    
    

 ///////////////////////////////////////// RESET ////////////////////////
  task reset(input transaction tr,input transaction trref);
    if (tr.reset) begin
      if((tr.Result==0) && (tr.Zero == 1) && (tr.Negative==0) && (tr.Carry==0) && (tr.Overflow==0))begin
        $display("Result Matched--Reset = 1");
      end
      else $error("Result UNMatched");
    end
    else unreset(tr,trref);
  endtask
      
  task run();
    int i = 1;
    forever begin
      mbx_ms.get(tr);
      mbxref.get(trref);
      $display("[SCO] DATA IN SCOREBOARD");
      tr.display();
       $display("------------------TEST RESULT-%0d------------------------",i);
      reset(tr,trref);
      $display("-------------------------------------------"); 
      i++;
      ->sco_ev;
    end
  endtask
      
      endclass
      
      
        
      
      