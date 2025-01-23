`timescale 1ns / 1ps

`define STRLEN 32
module ALU_tb();

    
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
    
    task check_zero;
        input out;
        input [`STRLEN*8:0] testType;
        inout [7:0] 	  passed;
        
        if(!out)
        begin
            $display("%s passed", testType);
            passed = passed + 1;
        end
        else $display("%s failed: ZERO test ", testType);
        
    endtask
    reg [2:0] ctrl;
    reg [31:0] SrcA, SrcB;
    wire [31:0] result;
    wire result_zero;
    
    reg [7:0] 	  passed;
    
    
    ALU DUT(
        .i_ALUControl(ctrl),
        .i_SrcA(SrcA),
        .i_SrcB(SrcB),
        .o_zero(result_zero),
        .o_ALUResult(result)
    );
    
    
    initial 
    begin
    
    ctrl = 0;
    SrcA = 0;
    SrcB = 0;
    passed = 0;
    
    
    
    
    #10
    //Addition positive
    {ctrl, SrcA, SrcB} = {3'b0,32'd3,32'd3};
    check_output(result, 32'd0, "test 1 ADD", passed);
    
    {ctrl, SrcA, SrcB} = {3'b0,32'd1890,32'd2014};
    check_output(result, 32'd0, "test 2 ADD", passed);
    
    
    
    
    
    
    
    
    
    
    
    
    end

endmodule
