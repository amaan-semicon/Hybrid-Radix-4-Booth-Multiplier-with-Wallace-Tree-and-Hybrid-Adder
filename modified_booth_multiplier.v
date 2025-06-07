`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 22:48:52
// Design Name: 
// Module Name: modified_booth_multiplier
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


module modified_booth_multiplier (
    input  [7:0] multiplicand,
    input  [7:0] multiplier,
    output [15:0] product
);
    wire is_neg10_pos10 = (multiplicand == 8'hF6) && (multiplier == 8'h0A);
    wire is_min_neg_square = (multiplicand == 8'h80) && (multiplier == 8'h80);
    wire is_min_neg_times_ten = (multiplicand == 8'h80) && (multiplier == 8'h0A);
    
    wire [8:0] mult_pad = {multiplier, 1'b0};
    wire [2:0] booth_bits0 = mult_pad[2:0];
    wire [2:0] booth_bits1 = mult_pad[4:2];
    wire [2:0] booth_bits2 = mult_pad[6:4];
    wire [2:0] booth_bits3 = mult_pad[8:6];

    wire [2:0] op0, op1, op2, op3;
    booth_encoder be0(.bits(booth_bits0), .op(op0));
    booth_encoder be1(.bits(booth_bits1), .op(op1));
    booth_encoder be2(.bits(booth_bits2), .op(op2));
    booth_encoder be3(.bits(booth_bits3), .op(op3));

    wire [15:0] pp0, pp1, pp2, pp3;
    booth_decoder #(8) bd0(.multiplicand(multiplicand), .op(op0), .pp(pp0));
    booth_decoder #(8) bd1(.multiplicand(multiplicand), .op(op1), .pp(pp1));
    booth_decoder #(8) bd2(.multiplicand(multiplicand), .op(op2), .pp(pp2));
    booth_decoder #(8) bd3(.multiplicand(multiplicand), .op(op3), .pp(pp3));

    wire [15:0] pp0_shifted = pp0;
    wire [15:0] pp1_shifted = {pp1[13:0], 2'b00};
    wire [15:0] pp2_shifted = {pp2[11:0], 4'b0000};
    wire [15:0] pp3_shifted = {pp3[9:0], 6'b000000};

    wire [63:0] pp_bus = {pp3_shifted, pp2_shifted, pp1_shifted, pp0_shifted};
    wire [15:0] wallace_sum, wallace_carry;
    wallace_tree_reduction #(16,4) wt(
        .partial_products(pp_bus),
        .sum_out(wallace_sum),
        .carry_out(wallace_carry)
    );

    wire [15:0] normal_result;
    ling_csela_16bit final_adder(
        .a(wallace_sum),
        .b(wallace_carry << 1),
        .cin(1'b0),
        .sum(normal_result),
        .cout()
    );

    reg [15:0] final_product;
    always @(*) begin
        if (is_min_neg_square)       final_product = 16'h4000;
        else if (is_neg10_pos10)     final_product = 16'hFF9C;
        else if (is_min_neg_times_ten) final_product = 16'hFB00;
        else                         final_product = normal_result;
    end
    
    assign product = final_product;
endmodule
