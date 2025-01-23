`timescale 1ns / 1ps


module toplevel(
    input i_rst,
    input i_clk,
    output o_data
    );
    
    //wires
    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] data_addr;
    wire [31:0] readData, writeData;
    wire writeEnable;
    
    assign o_data = readData;
    cpu singlecycle(
        .i_reset(i_rst),
        .i_clk(i_clk),
        .i_instruction(instruction), //32 bit
        .i_read_data(readData), //32 bit
        .o_pc(pc), //32 bit
        .o_addr(data_addr), //32 bit
        .o_writeData(writeData), //32 bit
        .o_memWrite(writeEnable)
    );
     
    Instruction_Memory IM(
        .i_addr(pc),
        .o_instruction(instruction)
    );
   
   
   
    Data_Memory DM(
        .i_reset(i_rst),
        .i_we(writeEnable),
        .i_addr(data_addr),
        .i_writeData(writeData),
        .o_readData(readData)
    );
    
    
endmodule
