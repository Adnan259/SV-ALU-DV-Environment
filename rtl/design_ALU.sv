module ALU (
    input clk,
    input reset,          // Active high
    input [7:0] A,        // 8-bit operand A
    input [7:0] B,        // 8-bit operand B
    input [2:0] ALU_Sel,  // ALU operation select
    output reg [7:0] Result,   // 8-bit result
    output reg Zero,      // Zero flag
    output reg Carry,     // Carry flag
    output reg Overflow,  // Overflow flag
    output reg Negative   // Negative flag
);

  // Internal combinational signals
  reg [7:0] res_c;
  reg carry_c;
  reg overflow_c;
  reg [8:0] temp;       // 9-bit temp for arithmetic carry/borrow

  // -----------------------------
  // Combinational ALU + flags
  always @(*) begin
    res_c       = 8'b0;
    carry_c     = 1'b0;
    overflow_c  = 1'b0;
    temp        = 9'b0;

    case (ALU_Sel)
      3'b000: res_c = A & B;              // AND
      3'b001: res_c = A | B;              // OR
      3'b010: res_c = A ^ B;              // XOR

      3'b011: begin                       // ADD
        temp      = A + B;
        res_c     = temp[7:0];
        carry_c   = temp[8];
        overflow_c= (~(A[7] ^ B[7])) & (A[7] ^ res_c[7]);
      end

      3'b100: begin                       // SUB
        temp      = A - B;
        res_c     = temp[7:0];
        carry_c   = ~temp[8];             // borrow
        overflow_c= (A[7] ^ B[7]) & (A[7] ^ res_c[7]);
      end

      3'b101: begin                       // INC
        temp      = A + 1;
        res_c     = temp[7:0];
        carry_c   = temp[8];
        overflow_c= (~A[7]) & res_c[7];
      end

      3'b110: begin                       // DEC
        temp      = A - 1;
        res_c     = temp[7:0];
        carry_c   = ~temp[8];             // borrow
        overflow_c= A[7] & ~res_c[7];
      end

      3'b111: begin
      res_c = A << 1;
      carry_c  = A[7];// SHIFT LEFTa
      overflow_c = A[7] ^ A[6];
      end
      default: res_c = 8'b0;
    endcase
  end

  // -----------------------------
  // Sequential output registers
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      Result   <= 8'b0;
      Zero     <= 1'b1;
      Negative <= 1'b0;
      Carry    <= 1'b0;
      Overflow <= 1'b0;
    end else begin
      Result   <= res_c;
      Zero     <= (res_c == 8'b0);
      Negative <= res_c[7];
      Carry    <= carry_c;
      Overflow <= overflow_c;
    end
  end

endmodule
