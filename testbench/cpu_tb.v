`timescale 1ns / 1ps
`define STRLEN 32
`define HalfClockPeriod 60
`define ClockPeriod `HalfClockPeriod * 2

module cpu_tb();
    task check_output;
        input [31:0] actualOutput, ExpectedOutput;
        input [`STRLEN*8:0] testType;
        inout [7:0] passed;

        if (actualOutput == ExpectedOutput) begin
            $display("%s passed", testType);
            passed = passed + 1;
        end else begin
            $display("%s failed || actual: 0x%h expected: 0x%h", testType, actualOutput, ExpectedOutput);
        end
    endtask

    reg reset, clk;
    reg [31:0] startPC;
    wire [31:0] readData, instruction;
    wire [31:0] pc, address, writeData;
    wire memWrite;
    wire [31:0] result;
    reg [7:0] passed;

    cpu singlecycle(
        .i_reset(reset),
        .i_clk(clk),
        .i_instruction(instruction),
        .i_read_data(readData),
        .i_startPC(startPC),
        .o_pc(pc),
        .o_addr(address),
        .o_writeData(writeData),
        .o_WE(memWrite),
        .o_testresult(result)
    );

    Data_Memory DM(
        .i_clk(clk),
        .i_rst(reset),
        .i_we(memWrite),
        .i_addr(address),
        .i_writeData(writeData),
        .o_readData(readData)
    );

    Instruction_Memory IM(
        .i_addr(pc),
        .o_instruction(instruction)
    );

    // Clock generation
    initial clk = 0;
    always #`HalfClockPeriod clk = ~clk;

    // Main testbench process
    initial begin
        passed = 0;

        // Test Program 1
        startPC = 0;
        run_test(32'd0, "Program 1");

        // Test Program 2
        startPC = 32'h14;  // Starting address of Program 2
        run_test(32'd42, "Program 2");

        $display("Passed %d tests", passed);
        $stop;
    end

    task run_test(input [31:0] expected_result, input [`STRLEN*8:0] test_name);
        begin
            reset = 1;
            #(`ClockPeriod * 2);  // Hold reset for 2 cycles
            reset = 0;

            while (pc < 32'h10) begin
                @(posedge clk);
            end

            check_output(result, expected_result, test_name, passed);
        end
    endtask
endmodule
