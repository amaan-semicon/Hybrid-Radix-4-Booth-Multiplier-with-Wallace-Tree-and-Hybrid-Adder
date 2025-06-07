`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:46:26
// Design Name: 
// Module Name: compressor_4to2
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


module compressor_4to2(
    input  [15:0] a, 
    input  [15:0] b, 
    input  [15:0] c, 
    input  [15:0] d,
    output [15:0] sum,
    output [15:0] carry
);
    assign sum = a ^ b ^ c ^ d;
    assign carry = ((a & b) | (a & c) | (a & d) | 
                   (b & c) | (b & d) | 
                   (c & d));
endmodule
