module eqCheck(Aneqz, equality, inA, inB);
    input [4:0] inA, inB;
    output Aneqz, equality;
    wire [4:0] AeqB;
    assign AeqB = inA ~^ inB;
    and isEq(equality, AeqB[0],AeqB[1],AeqB[2],AeqB[3],AeqB[4]);
    or isEqz(Aneqz, inA[0],inA[1],inA[2],inA[3],inA[4]);
endmodule
