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
    
    // Instantiate synchronous multiplier
    modified_booth_multiplier_sync uut (
        .clk(clk),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
    
    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test vectors and expected results
    reg [7:0] test_mpd [0:4];
    reg [7:0] test_mult [0:4];
    reg [15:0] expected [0:4];
    integer i;
    
    initial begin
        // Initialize test vectors
        test_mpd[0] = 8'h1B;    // 27
        test_mult[0] = 8'hF1;    // -15
        expected[0] = 16'hFE6B;  // -405
        
        test_mpd[1] = 8'h0A;     // 10
        test_mult[1] = 8'h0A;     // 10
        expected[1] = 16'h0064;  // 100
        
        test_mpd[2] = 8'hF6;     // -10
        test_mult[2] = 8'h0A;     // 10
        expected[2] = 16'hFF9C;  // -100
        
        test_mpd[3] = 8'h80;     // -128
        test_mult[3] = 8'h80;     // -128
        expected[3] = 16'h4000;  // 16384
        
        test_mpd[4] = 8'h80;     // -128
        test_mult[4] = 8'h0A;     // 10
        expected[4] = 16'hFB00;  // -1280
        
        // Initialize inputs
        multiplicand = 0;
        multiplier = 0;
        
        // Apply test vectors
        for (i = 0; i < 5; i = i+1) begin
            // Apply inputs at negative edge
            @(negedge clk);
            multiplicand = test_mpd[i];
            multiplier = test_mult[i];
            
            // Wait for one full clock cycle
            @(posedge clk);
            #1; // Small delay for signal stability
            
            // Check result after one clock cycle
            if (product === expected[i]) begin
                $display("[PASS] Test %0d: %0d * %0d = %0d (0x%h)", 
                         i, $signed(test_mpd[i]), $signed(test_mult[i]), 
                         $signed(product), product);
            end else begin
                $display("[FAIL] Test %0d: %0d * %0d = %0d (0x%h), Expected: %0d (0x%h)", 
                         i, $signed(test_mpd[i]), $signed(test_mult[i]), 
                         $signed(product), product, 
                         $signed(expected[i]), expected[i]);
            end
        end
        
        $finish;
    end
    
    // VCD dumping for debugging
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_modified_booth_multiplier);
    end
endmodule
