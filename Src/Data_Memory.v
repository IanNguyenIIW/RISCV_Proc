`timescale 1ns / 1ps

module Data_Memory(
    input i_clk,
    input i_rst,
    input i_we,
    input [31:0] i_addr,
    input [31:0] i_writeData,
   
    output reg [31:0] o_readData
    
    
);

    // Memory: 10,000 words
    reg [31:0] memory [9999:0];
    integer i;
    
    
    
   
    
    
    
    // Initial block to load memory and initialize it
    initial begin
        for (i = 0; i <= 1023; i = i + 1) begin
            memory[i] = 32'b0; // Blocking assignment in initial block
        end
        $readmemh("data.mem", memory); // Load memory from file
    end

    // Sequential logic for write operations
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            // Reset memory contents to 0
            for (i = 0; i <= 1023; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (i_we) begin
            memory[i_addr[11:2]] <= i_writeData; // Write data to memory
        end
        
        o_readData <= memory[i_addr[11:2]]; 
    end
 
   
    
    
        
endmodule
