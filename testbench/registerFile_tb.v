`timescale 1ns / 1ps

`define STRLEN 32
module registerFile_tb();

    
    task check_output;
        input[31:0] actualOutput, ExpectedOutput;
        input [`STRLEN*8:0] testType;
        inout [7:0] 	  passed;
        
        if(actualOutput == ExpectedOutput)
        begin
            $display("%s passed", testType);
            passed = passed + 1;
        end
        else $display("%s failed || actual: 0x%h expected: 0x%h", testType, actualOutput, ExpectedOutput);
        
    endtask
    reg clk;
    reg WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    wire [31:0] RD1, RD2;
    reg [7:0] 	  passed;
    
    
    registerFile DUT(
        .i_clk(clk),
        .WE3(WE3),
        .i_A1_addr(A1),
        .i_A2_addr(A2),
        .i_A3_addr(A3),
        .i_WD3_data(WD3),
        .o_RD1(RD1),
        .o_RD2(RD2)
    );
    
    
    initial 
    begin
    
    WE3 = 0;
    A1 = 0;
    A2 = 0;
    A3 = 0;
    WD3 = 0;
    passed = 0;
    clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b0,5'd0,5'd0,5'd0,32'd0};
    
    #10
    //test if zero register works
    check_output(RD1, 32'd0, "test 1", passed);
    check_output(RD2, 32'd0, "test 2", passed);
    #10; clk = 0; #10;clk = 1;
    check_output(RD1, 32'd0, "test 3", passed);
    check_output(RD2, 32'd0, "test 4", passed);
    #10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd1,32'd1};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd2,32'd2};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd3,32'd3};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd4,32'd4};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd5,32'd5};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd6,32'd6};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd7,32'd7};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd8,32'd8};#10; clk = 0; #10;clk = 1;
   
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd9,32'd9};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd10,32'd10};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd11,32'd11};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd12,32'd12};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd13,32'd13};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd14,32'd14};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd15,32'd15};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd16,32'd16};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd17,32'd17};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd18,32'd18};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd19,32'd19};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd20,32'd20};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd21,32'd21};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd22,32'd22};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd23,32'd23};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd24,32'd24};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd25,32'd25};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd26,32'd26};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd27,32'd27};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd28,32'd28};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd29,32'd29};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd30,32'd30};#10; clk = 0; #10;clk = 1;
    {WE3, A1, A2, A3, WD3} = {1'b1,5'd0,5'd0,5'd31,32'd31};#10; clk = 0; #10;clk = 1;
    
    {WE3, A1, A2, A3, WD3} = {1'b0,5'd30,5'd31,5'd0,32'd0};#10; clk = 0; #10;clk = 1;
    
    check_output(RD1, 32'd30, "test 5", passed);
    check_output(RD2, 32'd31, "test 6", passed);
    
    
    
    
    
    
    
    
    
    
    
    
    end

endmodule
