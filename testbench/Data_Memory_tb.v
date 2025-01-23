`timescale 1ns / 1ps

module Data_Memory_tb;

    // Testbench signals
    reg tb_clk;
    reg tb_rst;
    reg tb_we;
    reg [31:0] tb_addr;
    reg [31:0] tb_writeData;
    wire [31:0] tb_readData;

    // Instantiate the Data_Memory module
    Data_Memory uut (
        .i_clk(tb_clk),
        .i_rst(tb_rst),
        .i_we(tb_we),
        .i_addr(tb_addr),
        .i_writeData(tb_writeData),
        .o_readData(tb_readData)
    );

    // Clock generation
    always #5 tb_clk = ~tb_clk; // 10 ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        tb_clk = 0;
        tb_rst = 1;
        tb_we = 0;
        tb_addr = 0;
        tb_writeData = 0;

        // Apply reset
        #10 tb_rst = 0;

        // Write to memory
        #10 tb_we = 1;
        tb_addr = 32'h00000008; // Address
        tb_writeData = 32'hDEADBEEF; // Data
        #10 tb_we = 0;

        // Read from memory
        #10 tb_addr = 32'h00000008;

        // Observe the read data
        #10;

        // Finish simulation
        $finish;
    end
endmodule
