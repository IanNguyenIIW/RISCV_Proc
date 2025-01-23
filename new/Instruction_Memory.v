`timescale 1ns / 1ps


module Instruction_Memory(
        input [31:0] i_addr,
        output [31:0] o_instruction
    );
    
    
    
    reg [31:0] memory [0:10]; 
    initial begin
        $readmemb("test1.mem", memory); // Load memory with instructions
    end
    
    assign o_instruction = memory[i_addr[11:2]];
endmodule
