module instrDecode(jt, bne, jal, rwe, jr, ALUinB, blt, sw, lw, pr2, setx, bex, r1, r2, w, aluop, shamt, targetExd, ImmedSignExd, addi, opcode, regALU, instruction, cko, ckx, cky, bid, clrp, nck);

input [31:0] instruction;
///*****
output [4:0] aluop, shamt, opcode;
///*****

wire [4:0] rd, rs, rt, aluop0;
output [31:0] ImmedSignExd, targetExd;

wire [16:0] Immed;
wire [26:0] target;

assign opcode = instruction[31:27];
assign rd = instruction[26:22];
assign rs = instruction[21:17];
assign rt = instruction[16:12];
assign shamt = instruction[11:7];
//if addi, aluop is 00000
assign aluop0 = addi ? 5'b0 : instruction[6:2];
// if lw, sw, aluop is 00000
wire isAdd;
assign isAdd = lw | sw;
assign aluop = isAdd? 5'b0 : aluop0;

assign Immed = instruction[16:0];
assign target = instruction[26:0];

// ExtensionI-type immediate field [16:0] (N) is signed and is sign-extended to a signed 32-bit integer
// JII-type target field [26:0] (T) is unsigned. PC and STATUS registers’ upper bits [31:27] are guaranteed to never be used
assign ImmedSignExd[16:0] = Immed[16:0]; 
genvar i;
generate
    for (i=17;i<32;i=i+1) begin: loopSignExtension
        assign ImmedSignExd[i] = Immed[16];
    end
endgenerate

assign targetExd[26:0] = target[26:0];
assign targetExd[31:27] = 5'b0;

// Decode opcode
wire [31:0] isa;
decoder32 decodeOp(isa, opcode, 1'b1);

// ouput signals
output jt, bne, jal, rwe, jr, ALUinB, blt, sw, lw, pr2, setx, bex;
output [4:0] r1, r2, w;
output addi;
output regALU;
wire [1:0] sRd, sRt;
wire sll_sra;
output cko, ckx, cky, bid, clrp, nck;

assign regALU = isa[0];
assign jt = isa[1];
assign bne = isa[2];
assign jal = isa[3];
assign jr = isa[4];
assign addi = isa[5];
assign blt = isa[6];
assign sw = isa[7];
assign lw = isa[8];
/////////////////////////////////////
// FOR MINESWEEPER
assign cko = isa[9];
assign ckx = isa[10];
assign cky = isa[11];
assign clrp = isa[12];
assign bid = isa[13];
assign nck = isa[14];
//
/////////////////////////////////////
assign setx = isa[21];
assign bex = isa[22];

assign sll_sra = ~aluop[4] & ~aluop[3] & aluop[2] & ~aluop[1] & regALU;
////////////////////////////////////
// Minesweeper Mod
or regWriteEnable(rwe, regALU, jal, addi, lw, setx, ckx, cky, cko, bid);
or useImmed(ALUinB, addi, sw, lw);
or selectRt(pr2, bne, jr, blt, sw);
//
////////////////////////////////////

assign sRd = {setx,jal};
assign sRt = {bex, pr2};
// prevent bypassing and branching register from misinterpreting
// actual r1, r2, w
// Set instruction that do not read/write reg to $0
wire noRs, noRt, noRd;
wire [4:0] grdrt, grdrd;
////////////////////////////////////
// Minesweeper Mod
assign noRs = jt | jal | jr | bex | setx |ckx | cky | cko | bid | clrp | nck;
assign noRt = addi | sll_sra | setx | lw | jt | jal |ckx | cky | cko | bid | clrp | nck;
or setRd0(noRd, sw, jt, jr, bne, blt, bex, clrp, nck);
//
////////////////////////////////////
assign grdrt = noRt ? 5'b0 : rt;
assign grdrd = noRd ? 5'b0 : rd;

mux4_5 selectRd(w, sRd, grdrd, 5'd31, 5'd30, 5'bx);
mux4_5 selectRt0(r2,sRt, grdrt, rd, 5'd30, 5'bx);

assign r1 = noRs ? 5'b0 : rs;

endmodule
