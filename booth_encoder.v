`timescale 1ns/1ps

//============================================================
// Booth Encoder (Radix-4)
//============================================================
module booth_encoder (
    input  [2:0] bits,
    output reg [2:0] op
);
  always @(*) begin
    case(bits)
      3'b000, 3'b111: op = 3'b000;  // 0X
      3'b001, 3'b010: op = 3'b001;  // +1X
      3'b011:         op = 3'b011;  // +2X
      3'b100:         op = 3'b100;  // -2X
      3'b101, 3'b110: op = 3'b010;  // -1X
      default:        op = 3'b000;
    endcase
  end
endmodule