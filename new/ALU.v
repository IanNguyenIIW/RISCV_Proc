`timescale 1ns / 1ps

`define ADD 4'b0000
`define SUB 4'b0001
`define AND 4'b0010
`define OR 4'b0011
`define SLT 4'b0101 //SLT for "set if less than" when A < B, Result = 1 otherwise Result = 0
module ALU(
    input [3:0] i_ALUControl,
    input [31:0] i_SrcA,
    input [31:0] i_SrcB,
    output o_zero,
    output [31:0] o_ALUResult
    
    );
    reg [31:0] result;
    always@(*)
    begin
        case(i_ALUControl)
        
            `ADD : result = i_SrcA + i_SrcB;
           
            `SUB : result = i_SrcA - i_SrcB;
            
            `AND : result = i_SrcA & i_SrcB;
            
            `OR : result = i_SrcA | i_SrcB;
            
            `SLT : result = (i_SrcA < i_SrcB) ? 32'd1 : 32'd0;
            
            default: result = 32'd0;
            //TODO
            //XOR SLL SRL SRA SLT SLTU
        endcase
    end
    
    assign o_ALUResult = result;
    assign o_zero = (result == 0);
    
endmodule
