/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB,                  // I: Data from port B of RegFile

    ///////////////////////////
    // For minesweeper
    pressed,
    x_game,
    y_game,
    VGAid,
    pr_reset,
    nowCheck
    //
	///////////////////////////
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

    ///////////////////////////
    // For minesweeper
    input pressed;
    input[9:0] x_game;
    input[8:0] y_game;
    output pr_reset, nowCheck;
    input [31:0] VGAid;
    //
	///////////////////////////
	/* YOUR CODE STARTS HERE */
    //WIRES
    //wire [4:0] D_ctrl_reaRegA, D_ctrl_reaRegB; 
    wire latchClock;
    assign latchClock = clock;
    wire stallDX, X_lw, DXeq0, DXeq1, DRsneqz, DRtneqz, D_sw, stall_datahazard;
    wire [31:0] X1_PC, X1_A, X1_B, X1_IR, X2_PC, X2_B, X2_IR, B_Imm, X2_O, X_target;
    wire useImm, isNotEqual, isLessThan, overflow;
    wire [4:0] aluop, ctrl_shiftamt, X_opcode, X_ctrl_reaRegA, X_ctrl_reaRegB, X_writeAddr;
    wire [31:0] ALUdataA;
    wire As1, As0, XMeq, XRsneqz, XWeq;
    wire [31:0] ALUdataB;
    wire Bs1, Bs0, XMeq0, XRtneqz, XWeq0;

    wire [31:0] M1_O, M1_B, M1_IR, M2_O, M2_IR, M2_D;
    wire [4:0]  M1_Rd;
    wire M_sw;
    wire Ds, M_Rtneqz, MWeq;
    wire [4:0] M_ctrl_reaRegB;
    
    wire [31:0] W1_O, W1_D, W1_IR, W_writeData, writeData;
    wire [4:0] writeAddr, W_writeAddr;
    wire W_lw, W_rwe;

    wire W_isMULTDIV, W_regALU, W_setx;
    wire [31:0] writeData0, W_Target, multdivFinal;
    wire [4:0] W_aluop, muldivNormAddr;

    //-------------------------------------------------
    // ******** Stage 1 **********
    // PC Register
    wire [31:0] pcIn, pcOut, pcADDOne;
    wire [31:0] fetch_IR;
    register32 programCounter(pcOut, pcIn, clock, 1'b1, reset);
    cla_adder pcOne(.out(pcADDOne), .overflow(), .A(pcOut), .B(32'b1), .carry_in(1'b0)); 
    //***Stall logic***//
    /*for now, pc+1*/ assign pcIn = stallPC? pcOut : X_PCfinal; 
    //***Stall logic***//


    // Feed to ROM, get data
    assign address_imem = pcOut;
    assign fetch_IR = q_imem;

    //---------------------------- FD Latch -------------------------------//
    wire [31:0] D1_IR, D1_PC, D2_PC, D2_IR, finalF_IR;
    wire FD_enable, stallFD;
    /**For now, D2 in = D1 out**/ assign D2_PC = D1_PC;
    assign stallFD = stall_datahazard | stall_multdiv;
    assign FD_enable  = stallFD ? 1'b0 : 1'b1;
    assign finalF_IR = branch_flush ? 32'b0 : fetch_IR; 
    FD latch1(D1_PC, D1_IR, pcADDOne, finalF_IR, latchClock, reset, FD_enable);
    // Feed addr to Regfile, get data
    instrDecode FDdecode(.jt(), .bne(), .jal(), .rwe(), .jr(), .ALUinB(), .blt(), .sw(D_sw), .lw(), .pr2(), .setx(), .bex(), .r1(ctrl_readRegA), .r2(ctrl_readRegB), .w(), .aluop(), .shamt(), .targetExd(), .ImmedSignExd(), .addi(), .opcode(), .regALU(), .instruction(D1_IR), .cko(), .ckx(), .cky());
    //***Stall logic***//
    eqCheck DXstallA(.Aneqz(DRsneqz), .equality(DXeq0), .inA(ctrl_readRegA), .inB(X_writeAddr));
    eqCheck DXstallB(.Aneqz(DRtneqz), .equality(DXeq1), .inA(ctrl_readRegB), .inB(X_writeAddr));
    assign stall_datahazard = X_lw & ((DRsneqz & DXeq0) | ((DRtneqz & DXeq1) & ~D_sw));

    //----------------------------- DX Latch -----------------------------//

    //***Stall logic***//
    assign stallDX = stall_datahazard | stall_multdiv | branch_flush;
    assign stallPC = stall_datahazard | stall_multdiv;

    assign D2_IR = stallDX ? 32'b0: D1_IR;
    //***Stall logic***//
    DX latch2(X1_PC, X1_A, X1_B, X1_IR, D2_PC, data_readRegA, data_readRegB, D2_IR, latchClock, reset);
    ///**For now, D2 in = D1 out**/ assign X2_PC = X1_PC;
    /**For now, D2 in = D1 out**/ assign X2_B = input2;
    wire X_add, X_addi, X_sub, X_subsig, regALU, X_bne, X_blt, X_jt, X_jal, X_bex, X_jr, X_setx;
    wire X_cko, X_ckx, X_cky, X_bid, X_clrp; 
    instrDecode DXdecode(.jt(X_jt), .bne(X_bne), .jal(X_jal), .rwe(), .jr(X_jr), .ALUinB(useImm), .blt(X_blt), .sw(), .lw(X_lw), .pr2(), .setx(X_setx), .bex(X_bex), .r1(X_ctrl_reaRegA), .r2(X_ctrl_reaRegB), .w(X_writeAddr), .aluop(aluop), .shamt(ctrl_shiftamt), .targetExd(X_target), .ImmedSignExd(B_Imm), .addi(X_addi), .opcode(X_opcode), .regALU(regALU), .instruction(X1_IR), .cko(X_cko), .ckx(X_ckx), .cky(X_cky), .bid(X_bid), .clrp(X_clrp));
    nor ovrgate1(X_add, aluop[0],aluop[1],aluop[2],aluop[3],aluop[4]);
    nor ovrgate2(X_subsig, aluop[1],aluop[2],aluop[3],aluop[4]);
    and ovrgate3(X_sub, X_subsig, aluop[0]);
    assign pr_reset = X_clrp ? 1'b1 : 1'b0;
    //MULTDIV
    //***Stall logic***//
    wire isMULTDIV, multdivRDY, multdiveException, isMult, isDiv, enStallReg, inOperation;
    wire [31:0] muldivResult;
    assign isMULTDIV = (~aluop[4] & ~aluop[3] & aluop[2] & aluop[1] & regALU);
    xor StallRWE(enStallReg, isMULTDIV, multdivRDY);
    dffe_ref stallReg(.q(inOperation), .d(isMULTDIV), .clk(latchClock), .en(enStallReg), .clr());
    assign stall_multdiv = inOperation | isMULTDIV;
    //assign stall_multdiv = isMULTDIV | (~multdivRDY);
    assign isMult = isMULTDIV & ~aluop[0];
    assign isDiv = isMULTDIV & aluop[0];
    multdiv MainMultdiv(.data_operandA(ALUdataA), .data_operandB(ALUdataB), .ctrl_MULT(isMult), .ctrl_DIV(isDiv), .clock(clock), .data_result(muldivResult), .data_exception(multdiveException), .data_resultRDY(multdivRDY));
    //------------------- PW Latch -------------------//
    wire [31:0] W_muldivResult, W_multdivIR;
    wire [4:0] muldivWriteAddr, PW_aluop;
    wire PW_rwe, PW_ismul;
    PW muldivLatch(.PW_Pin(muldivResult), .PW_Pout(W_muldivResult), .PW_IRin(X1_IR), .PW_IRout(W_multdivIR), .PW_IRen(isMULTDIV), .PW_Pen(multdivRDY), .clock(latchClock), .reset(reset));
    instrDecode PWdecode(.jt(), .bne(), .jal(), .rwe(PW_rwe), .jr(), .ALUinB(), .blt(), .sw(), .lw(), .pr2(), .setx(), .bex(), .r1(), .r2(), .w(muldivNormAddr), .aluop(PW_aluop), .shamt(), .targetExd(), .ImmedSignExd(), .addi(), .opcode(), .regALU(), .instruction(W_multdivIR));
    assign PW_ismul = ~PW_aluop[0];

    //*******ALU********//
    wire [31:0] input2, aluResult;
    
    //***Bypassing***//
    // ALUinA
    
    eqCheck XMbypass(.Aneqz(XRsneqz), .equality(XMeq), .inA(X_ctrl_reaRegA), .inB(M1_Rd));
    eqCheck XWbypass(.Aneqz(), .equality(XWeq), .inA(X_ctrl_reaRegA), .inB(writeAddr));
    assign As0 = XRsneqz & XMeq;
    assign As1 = XRsneqz & XWeq;
    mux_4 pickA(.out(ALUdataA), .select4({As1, As0}), .in0(X1_A), .in1(M2_O), .in2(W_writeData), .in3(M2_O));
    // ALUinB
    
    eqCheck XM0bypass(.Aneqz(XRtneqz), .equality(XMeq0), .inA(X_ctrl_reaRegB), .inB(M1_Rd));
    eqCheck XW0bypass(.Aneqz(), .equality(XWeq0), .inA(X_ctrl_reaRegB), .inB(writeAddr));
    assign Bs0 = XRtneqz & XMeq0;
    assign Bs1 = XRtneqz & XWeq0;
    mux_4 pickB(.out(input2), .select4({Bs1, Bs0}), .in0(X1_B), .in1(M2_O), .in2(W_writeData), .in3(M2_O));
    mux_2 selectIn2(ALUdataB, useImm, input2, B_Imm);
    /////////////////////////////////////
    // FOR MINESWEEPER
    wire[31:0] ALUdataBMS, ALUdataBMS0;
    wire game_s0, game_s1;
    assign game_s0 = X_cko | X_cky;
    assign game_s1 = X_ckx | X_cky;
    mux_4 selecfromVGA(.out(ALUdataBMS0), .select4({game_s1, game_s0}), .in0(ALUdataB), .in1({31'b0,pressed}), .in2({22'b0,x_game}), .in3({23'b0,y_game}));
    assign ALUdataBMS = X_bid ? VGAid : ALUdataBMS0;
    alu mainALU(.data_operandA(ALUdataA), .data_operandB(ALUdataBMS), .ctrl_ALUopcode(aluop), .ctrl_shiftamt(ctrl_shiftamt), .data_result(aluResult), .isNotEqual(isNotEqual), .isLessThan(isLessThan), .overflow(overflow));
    // overflow check:
    wire [31:0] X2_nostall_IR, X2_Ofinal0, X2_Ofinal;
    wire s1, s2, add_op;
    nor ovrgate1(add_op, X_opcode[0],X_opcode[1],X_opcode[2],X_opcode[3],X_opcode[4]);
    assign s1 = ((X_add & add_op) | X_sub) & overflow;
    assign s2 = (X_addi | X_sub) & overflow;
    mux_4 selectRstatusVal(.out(X2_O), .select4({s2,s1}), .in0(aluResult), .in1(32'd1), .in2(32'd2), .in3(32'd3));
    assign X2_Ofinal0 = X_jal ? X1_PC : X2_O;
    assign X2_Ofinal = X_setx ? X_target : X2_Ofinal0;
    // /**For now, D2 in = D1 out**/ assign X2_IR [21:0] = X1_IR[21:0];
    // /**For now, D2 in = D1 out**/ assign X2_IR [31:27] = X1_IR[31:27];
    assign X2_nostall_IR [21:0] = X1_IR[21:0];
    assign X2_nostall_IR [31:27] = X1_IR[31:27];
    assign X2_nostall_IR[26:22] = overflow ? 5'd30 : X1_IR[26:22];

    //***Branch Recovery***//
    wire branchS0, branchS1;
    wire [31:0] X_pcAdd1N, X_PCfinal;
    assign branchS0 = X_jr | (X_bne & isNotEqual) | (X_blt & ~isLessThan & isNotEqual);
    assign branchS1 = (X_jt | X_jal | (X_bex & isNotEqual)) | X_jr;
    cla_adder branchAdd(.out(X_pcAdd1N), .overflow(), .A(X1_PC), .B(B_Imm), .carry_in(1'b0));
    mux_4 choosePC(.out(X_PCfinal), .select4({branchS1,branchS0}), .in0(pcADDOne), .in1(X_pcAdd1N), .in2(X_target), .in3(X2_O));
    // flush
    wire branch_flush;
    assign branch_flush = branchS0 | branchS1;


    

    //----------------------------- XM Latch -------------------------------//
    //***Stall logic***//
    assign X2_IR = stall_multdiv ? 32'b0 : X2_nostall_IR;
    //***Stall logic***//
    XM latch3(M1_O, M1_B, M1_IR, X2_Ofinal, X2_B, X2_IR, latchClock, reset);
    
    /**For now, D2 in = D1 out**/ assign M2_O = M1_O;
    instrDecode XMdecode(.jt(), .bne(), .jal(), .rwe(), .jr(), .ALUinB(), .blt(), .sw(M_sw), .lw(), .pr2(), .setx(), .bex(), .r1(), .r2(M_ctrl_reaRegB), .w(M1_Rd), .aluop(), .shamt(), .targetExd(), .ImmedSignExd(), .addi(), .opcode(), .regALU(), .instruction(M1_IR), .cko(), .ckx(), .cky());
    //***Bypassing***//
    eqCheck MWbypass(.Aneqz(M_Rtneqz), .equality(MWeq), .inA(M_ctrl_reaRegB), .inB(writeAddr));
    //assign Ds = M_Rtneqz & MWeq & W_lw;
    assign Ds = M_Rtneqz & MWeq;
    assign data = Ds ? writeData : M1_B;

    assign address_dmem = M1_O;
    assign wren = M_sw;
    assign M2_D = q_dmem;
    
    //----------------------------- MW Latch ------------------------------//
    //***Stall logic***//
    //assign M2_IR = stall_multdiv ? 32'b0 : M1_IR;
    assign M2_IR = M1_IR;
    //***Stall logic***//
    wire W_nck;
    MW latch4(.W_O(W1_O), .W_D(W1_D), .W_IR(W1_IR), .M_O(M2_O), .M_D(M2_D), .M_IR(M2_IR), .clock(latchClock), .reset(reset));
    instrDecode MWdecode(.jt(), .bne(), .jal(), .rwe(W_rwe), .jr(), .ALUinB(), .blt(), .sw(), .lw(W_lw), .pr2(), .setx(W_setx), .bex(), .r1(), .r2(), .w(W_writeAddr), .aluop(), .shamt(), .targetExd(W_Target), .ImmedSignExd(), .addi(), .opcode(W_aluop), .regALU(W_regALU), .instruction(W1_IR), .cko(), .ckx(), .cky(), .nck(W_nck));
    assign W_isMULTDIV = (~W_aluop[4] & ~W_aluop[3] & W_aluop[2] & W_aluop[1] & W_regALU);
    mux_2 selectwData(.out(W_writeData), .select2(W_lw), .in0(W1_O), .in1(W1_D));
    /**For now, D2 in = D1 out**/ 
    mux_4 selectmulDdata(.out(multdivFinal), .select4({PW_ismul,multdiveException}), .in0(muldivResult), .in1(32'd5), .in2(muldivResult), .in3(32'd4));
    assign muldivWriteAddr = multdiveException? 5'd30 : muldivNormAddr;
    assign writeAddr = multdivRDY ?  muldivWriteAddr : W_writeAddr; 
    assign ctrl_writeEnable = multdivRDY ? PW_rwe : (W_rwe & ~W_isMULTDIV);
    assign ctrl_writeReg = writeAddr;
    assign writeData = multdivRDY ? multdivFinal : W_writeData;
    assign data_writeReg = writeData;

    /////////////////////////
    //game logic
    assign nowCheck = W_nck ? 1'b1 : 1'b0;
    /////////////////////////











	/* END CODE */

endmodule
