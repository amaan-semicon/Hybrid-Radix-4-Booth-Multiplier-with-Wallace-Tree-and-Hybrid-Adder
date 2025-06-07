`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:47:33
// Design Name: 
// Module Name: ling_adder_4bit
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


module ling_adder_4bit(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);
    wire [3:0] p, g;
    wire [4:0] h, c;

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = cin;
    assign h[0] = g[0] | (p[0] & c[0]);
    assign h[1] = g[1] | (p[1] & h[0]);
    assign h[2] = g[2] | (p[2] & h[1]);
    assign h[3] = g[3] | (p[3] & h[2]);

    assign c[1] = h[0];
    assign c[2] = h[1];
    assign c[3] = h[2];
    assign c[4] = h[3];

    assign sum = p ^ c[3:0];
    assign cout = c[4];
endmodule
