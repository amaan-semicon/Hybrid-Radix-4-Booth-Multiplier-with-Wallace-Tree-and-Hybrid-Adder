`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:47:00
// Design Name: 
// Module Name: wallace_tree_reduction
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

module wallace_tree_reduction #(
    parameter PP_WIDTH = 16,
    parameter NUM_PP = 4
)(
    input  [NUM_PP*PP_WIDTH-1:0] partial_products,
    output [PP_WIDTH-1:0] sum_out,
    output [PP_WIDTH-1:0] carry_out
);
    wire [PP_WIDTH-1:0] pp0 = partial_products[0*PP_WIDTH +: PP_WIDTH];
    wire [PP_WIDTH-1:0] pp1 = partial_products[1*PP_WIDTH +: PP_WIDTH];
    wire [PP_WIDTH-1:0] pp2 = partial_products[2*PP_WIDTH +: PP_WIDTH];
    wire [PP_WIDTH-1:0] pp3 = partial_products[3*PP_WIDTH +: PP_WIDTH];

    compressor_4to2 compress(
        .a(pp0),
        .b(pp1),
        .c(pp2),
        .d(pp3),
        .sum(sum_out),
        .carry(carry_out)
    );
endmodule
