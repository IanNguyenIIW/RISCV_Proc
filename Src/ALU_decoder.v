`timescale 1ns / 1ps


module ALU_decoder(
    input [1:0] i_ALUOp,
    input [2:0] i_funct3,
    input i_funct7,
    input i_op5,
    output reg [3:0] o_ALUControl
    );
    
    
    wire [1:0] combined;
    
    assign combined = {i_op5, i_funct7};
    always @(*)
    begin
    
        case(i_ALUOp)
            2'b00 : o_ALUControl = 4'b0000; //ADD for lw,sw
            
            2'b00 : o_ALUControl = 4'b0001; //SUB for beq
        
        
            2'b10 : begin
                case(i_funct3)
                
                    3'b000 : begin
                        if(combined == 2'b11) 
                            o_ALUControl = 4'b0001; //SUB
                        else
                            o_ALUControl = 4'b0000; //ADD
                    end
                    
                    3'b010 :
                        o_ALUControl = 4'b0101; //SLT
                    3'b110 :
                        o_ALUControl = 4'b0011; //OR
                    3'b111 :
                        o_ALUControl = 4'b0010; //AND
                    //TODO ADD XOR
                endcase
            end
        endcase
    end
endmodule
