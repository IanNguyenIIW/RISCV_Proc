`timescale 1ns / 1ps


module cpu(
    input i_reset,
    input i_clk,
    input [31:0] i_instruction,
    input [31:0] i_read_data,
    input [31:0] i_startPC,
    output reg [31:0] o_pc,
    output [31:0] o_addr,
    output [31:0] o_writeData,
    output o_WE,
    output [31:0] o_testresult
    );
    //instruction
    wire [4:0] RS1, RS2, RD;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [11:0] imm;
    
    //control/decoder wire
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    wire [1:0] ImmSrc;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    wire Zero;
    wire PCSrc;
    assign PCSrc = Zero && Branch;
    //Register File
    wire [31:0] RD1, RD2;
    //Sign Extender
    wire [31:0] ImmExt;
    //ALU wire
    wire [31:0] ALUresult;
    wire [31:0] SrcB;
    //assign instruction
    assign RS1 = i_instruction[19:15];
    assign RS2 = i_instruction[24:20];
    assign RD = i_instruction[11:7];
    
    assign opcode = i_instruction[6:0];
    assign funct3 = i_instruction[14:12];
    assign imm = i_instruction[31:20];
    
    
    //Sign Extender
    
    //muxes
    wire [31:0] result_regData;
    assign result_regData = ResultSrc ? i_read_data : ALUresult;
    assign SrcB = ALUSrc ? ImmExt : RD2;
    
    //Program Counter 
    
    initial o_pc = 32'h0;
    
    
    assign o_testresult = result_regData;
    
    //Data memory
    assign o_addr = ALUresult;
    assign o_writeData = RD2;
    assign o_WE = MemWrite;
    
    
    
    always @(posedge i_clk or posedge i_reset)
    begin
       if (i_reset)
        o_pc <= i_startPC;
    else
        o_pc <= PCSrc ? (o_pc + ImmExt) : (o_pc + 4);
    
    end
    
    
    
    ALU alu(
        .i_ALUControl(ALUControl),
        .i_SrcA(RD1),
        .i_SrcB(SrcB),
        .o_zero(Zero),
        .o_ALUResult(ALUresult)
    );
    
    
    
    registerFile rf(
        .i_clk(i_clk),
        .i_WE3(RegWrite),
        .i_A1_addr(RS1),
        .i_A2_addr(RS2),
        .i_A3_addr(RD),
        .i_WD3_data(result_regData),
        .o_RD1(RD1),
        .o_RD2(RD2)
    );
    
    
    SignExtender signExt(
        .i_Instruction(i_instruction),
        .i_ImmSrc(ImmSrc),
        .o_ImmExt(ImmExt)
    );
    

    
    control cpu_control(
        .i_opcode(i_instruction[6:0]),
        .o_RegWrite(RegWrite),
        .o_ImmSrc(ImmSrc),
        .o_ALUSrc(ALUSrc),
        .o_MemWrite(MemWrite),
        .o_ResultSrc(ResultSrc),
        .o_Branch(Branch),
        .o_ALUOp(ALUOp)
        
    );
    
    ALU_decoder decode(
        .i_ALUOp(ALUOp),
        .i_funct3(i_instruction[14:12]),
        .i_funct7(i_instruction[30]),
        .i_op5(i_instruction[5]),
        .o_ALUControl(ALUControl)
    );
    
    
    
endmodule
