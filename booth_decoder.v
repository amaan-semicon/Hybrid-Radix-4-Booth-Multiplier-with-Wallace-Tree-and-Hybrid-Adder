`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:45:47
// Design Name: 
// Module Name: booth_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module booth_decoder #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] multiplicand,
    input  [2:0] op,
    output reg [(2*WIDTH)-1:0] pp
);
    wire signed [WIDTH:0] mcand_ext = {multiplicand[WIDTH-1], multiplicand};
    wire signed [WIDTH:0] mcand_neg = -mcand_ext;
    wire signed [WIDTH+1:0] mcand2x = {multiplicand[WIDTH-1], multiplicand, 1'b0};
    wire signed [WIDTH+1:0] mcand2x_neg = -mcand2x;

    always @(*) begin
        case(op)
            3'b000: pp = 0;
            3'b001: pp = {{(WIDTH){mcand_ext[WIDTH]}}, mcand_ext[WIDTH-1:0]};
            3'b010: pp = {{(WIDTH){mcand_neg[WIDTH]}}, mcand_neg[WIDTH-1:0]};
            3'b011: pp = {{(WIDTH-1){mcand2x[WIDTH+1]}}, mcand2x[WIDTH:0]};
            3'b100: pp = {{(WIDTH-1){mcand2x_neg[WIDTH+1]}}, mcand2x_neg[WIDTH:0]};
            default: pp = 0;
        endcase
    end
endmodule