`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:48:15
// Design Name: 
// Module Name: ling_csela_16bit
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


module ling_csela_16bit(
    input  [15:0] a,
    input  [15:0] b,
    input         cin,
    output [15:0] sum,
    output        cout
);
    wire c4, c8, c12;
    wire [3:0] sum1_0, sum1_1;
    wire [3:0] sum2_0, sum2_1;
    wire [3:0] sum3_0, sum3_1;
    wire c4_0, c4_1;
    wire c8_0, c8_1;
    wire c12_0, c12_1;

    ling_adder_4bit adder0 (
        .a(a[3:0]), .b(b[3:0]), .cin(cin), 
        .sum(sum[3:0]), .cout(c4)
    );
    
    ling_adder_4bit adder1_0 (
        .a(a[7:4]), .b(b[7:4]), .cin(1'b0), 
        .sum(sum1_0), .cout(c4_0)
    );
    ling_adder_4bit adder1_1 (
        .a(a[7:4]), .b(b[7:4]), .cin(1'b1), 
        .sum(sum1_1), .cout(c4_1)
    );
    assign sum[7:4] = c4 ? sum1_1 : sum1_0;
    assign c8 = c4 ? c4_1 : c4_0;
    
    ling_adder_4bit adder2_0 (
        .a(a[11:8]), .b(b[11:8]), .cin(1'b0), 
        .sum(sum2_0), .cout(c8_0)
    );
    ling_adder_4bit adder2_1 (
        .a(a[11:8]), .b(b[11:8]), .cin(1'b1), 
        .sum(sum2_1), .cout(c8_1)
    );
    assign sum[11:8] = c8 ? sum2_1 : sum2_0;
    assign c12 = c8 ? c8_1 : c8_0;
    
    ling_adder_4bit adder3_0 (
        .a(a[15:12]), .b(b[15:12]), .cin(1'b0), 
        .sum(sum3_0), .cout(c12_0)
    );
    ling_adder_4bit adder3_1 (
        .a(a[15:12]), .b(b[15:12]), .cin(1'b1), 
        .sum(sum3_1), .cout(c12_1)
    );
    assign sum[15:12] = c12 ? sum3_1 : sum3_0;
    assign cout = c12 ? c12_1 : c12_0;
endmodule
