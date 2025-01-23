`timescale 1ns / 1ps


module SignExtender(
    input [31:0] i_Instruction,
    input [1:0] i_ImmSrc,
    output reg [31:0] o_ImmExt
    );
    
    
    
    always @(*)
    begin
        case(i_ImmSrc)
        
            //Type I 
            2'b00 : o_ImmExt = {{20{i_Instruction[31]}}, i_Instruction[31:20]}; 
            //Type S
            2'b01 : o_ImmExt = {{20{i_Instruction[31]}}, i_Instruction[31:25], i_Instruction[11:7]};
            
            //Type B Branch offset 
            2'b10 : o_ImmExt = {{20{i_Instruction[31]}}, i_Instruction[7], i_Instruction[30:25], i_Instruction[11:8], 1'b0}; 
            
            default: o_ImmExt = 32'b0;
        
        endcase
    
    
    end
    
endmodule
