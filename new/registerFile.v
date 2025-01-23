`timescale 1ns / 1ps


module registerFile(
    input i_clk,
    input i_WE3,
    input [4:0] i_A1_addr,
    input [4:0] i_A2_addr,
    input [4:0] i_A3_addr,
    input [31:0] i_WD3_data,
    output [31:0] o_RD1,
    output [31:0] o_RD2
    );
    
    
    reg [31:0] registers [31:0]; //first dimension is the data width, second dimension is # of registers 32 x 32
    
    assign o_RD1 = !i_A1_addr ? 0 : registers[i_A1_addr]; //read the register from the addr assign to 0 if addr == 0
    assign o_RD2 = !i_A2_addr ? 0 : registers[i_A2_addr];
    
    
    always @(posedge i_clk)
    begin
        if(i_WE3 && i_A3_addr) //checks if write signal(WE3) and valid write addr
        registers[i_A3_addr] <= i_WD3_data;
    end
    
    
    
endmodule
