`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2025 23:12:36
// Design Name: 
// Module Name: tb_modified_booth_multiplier
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




module tb_modified_booth_multiplier();
    reg clk;
    reg [7:0] multiplicand;
    reg [7:0] multiplier;
    wire [15:0] product;
    
    // Instantiate the multiplier
    modified_booth_multiplier_sync uut (
        .clk(clk),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
    
    // Generate 100MHz clock (period = 10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns
    end
    
    initial begin
        // Initialize waveform logging
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_modified_booth_multiplier);
        
        // Test Case 1: 27 * -15 = -405
        multiplicand = 27;      // Positive decimal
        multiplier = -15;       // Negative decimal
        #20;                    // Wait 2 clock cycles
        $display("27 * -15 = %d (Hex: %h)", product, product);
        
        // Test Case 2: 10 * 10 = 100
        multiplicand = 10;
        multiplier = 10;
        #10;                    // Wait 1 clock cycle
        $display("10 * 10 = %d", product);
        
        // Test Case 3: -10 * 10 = -100
        multiplicand = -10;
        multiplier = 10;
        #10;
        $display("-10 * 10 = %d", product);
        
        // Test Case 4: -128 * -128 = 16384
        multiplicand = -128;
        multiplier = -128;
        #10;
        $display("-128 * -128 = %d", product);
        
        // Test Case 5: -128 * 10 = -1280
        multiplicand = -128;
        multiplier = 10;
        #10;
        $display("-128 * 10 = %d", product);
        
        $finish;
    end
endmodule
