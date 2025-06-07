`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 23:02:30
// Design Name: 
// Module Name: modified_booth_multiplier_sync
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


module modified_booth_multiplier_sync (
    input clk,
    input [7:0] multiplicand,
    input [7:0] multiplier,
    output reg [15:0] product
);
    reg [7:0] mult_reg, mpd_reg;
    wire [15:0] product_wire;
    
    // Input registers
    always @(posedge clk) begin
        mult_reg <= multiplier;
        mpd_reg <= multiplicand;
    end
    
    // Combinational multiplier
    modified_booth_multiplier uut (
        .multiplicand(mpd_reg),
        .multiplier(mult_reg),
        .product(product_wire)
    );
    
    // Output register
    always @(posedge clk) begin
        product <= product_wire;
    end
endmodule
