`timescale 1ns / 1ps

`define OPCODE_R_type 7'b0110011

//immediate
`define OPCODE_I_Arithmetic 7'b0010011
`define OPCODE_I_load 7'b0000011
`define OPCODE_I_control 7'b1100111

//Store Type
`define OPCODE_S_type 7'b0100011
//Branch Type
`define OPCODE_B_type 7'b1100011

module control(
    input [6:0] i_opcode,
    output reg o_RegWrite,
    output reg [1:0] o_ImmSrc,
    output reg o_ALUSrc,
    output reg o_MemWrite,
    output reg o_ResultSrc,
    output reg o_Branch,
    output reg [1:0]  o_ALUOp
    
    
    );
    
    
    always @(i_opcode)
    begin
        case(i_opcode)
        
        
            `OPCODE_R_type : begin
                o_RegWrite = 1'b1;
                o_ImmSrc = 2'bxx;
                o_ALUSrc = 1'b0;
                o_MemWrite = 1'b0;
                o_ResultSrc = 1'b0;
                o_Branch = 1'b0;
                o_ALUOp = 2'b10;
                
            
            end
            
            `OPCODE_I_Arithmetic : begin
                o_RegWrite = 1'b1;
                o_ImmSrc = 2'b00;
                o_ALUSrc = 1'b1;
                o_MemWrite = 1'b0;
                o_ResultSrc = 1'b0;
                o_Branch = 1'b0;
                o_ALUOp = 2'b10;
                
            
            end
            
            `OPCODE_I_load : begin
                o_RegWrite = 1'b1;
                o_ImmSrc = 2'b00;
                o_ALUSrc = 1'b1;
                o_MemWrite = 1'b0;
                o_ResultSrc = 1'b1;
                o_Branch = 1'b0;
                o_ALUOp = 2'b00;
                
            
            end
            
            `OPCODE_S_type : begin
                o_RegWrite = 1'b0;
                o_ImmSrc = 2'b01;
                o_ALUSrc = 1'b1;
                o_MemWrite = 1'b1;
                o_ResultSrc = 1'bx;
                o_Branch = 1'b0;
                o_ALUOp = 2'b00;
                
            
            end
            //TODO more opcodes
        endcase
    end
endmodule

