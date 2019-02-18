`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:42 02/12/2019 
// Design Name: 
// Module Name:    calcExp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module calcExp(
    input  [7:0] iExp,
    input  [4:0] iMSBPos,
    input        iRndFlag,
    output [7:0] oExp,
    output       oInf_n,
    output       oInf_p );

   //Used in RoundMum process
    reg    [2:0] v_dotPos;
    wire   [7:0] w_dotPos;
    wire   [9:0] w_EXP;
    wire         w_Carry;
	 wire   [9:0] w_2ndCMSBPos;
    wire   [9:0] w_ResExp;
    wire         w_Dummy;
    reg    [7:0] w_oExp;
    wire   [7:0] w_iExp;
    wire         w_oInf_p;
    wire         w_oInf_n;

    always @ (iRndFlag)
        v_dotPos = {1'b1, 1'b0, iRndFlag};
       
    assign w_dotPos = {1'b00000, v_dotPos};


nBitAdder #( .nBit(8) )
    Inst_add_exp_4or5	 
       (.iA    (iExp  [7:0]   ),  // input
        .iB    (w_dotPos      ),  // input
        .iCarry(1'b0          ),  // input
        .oRes  (w_EXP   [7:0] ),  // output
        .oCarry(w_Carry       )); // output

    assign w_EXP[8] = w_Carry;
    assign w_EXP[9] = 1'b0;

  //INVERT Position of MSB in order to get 2nd complement
    not(w_2ndCMSBPos[0], iMSBPos[0]);
    not(w_2ndCMSBPos[1], iMSBPos[1]);
    not(w_2ndCMSBPos[2], iMSBPos[2]);
    not(w_2ndCMSBPos[3], iMSBPos[3]);
    not(w_2ndCMSBPos[4], iMSBPos[4]);

    assign w_2ndCMSBPos[5] = 1'b1;
    assign w_2ndCMSBPos[6] = 1'b1;
    assign w_2ndCMSBPos[7] = 1'b1;
    assign w_2ndCMSBPos[8] = 1'b1;
    assign w_2ndCMSBPos[9] = 1'b1;

nBitAdder #( .nBit(10) )
    Inst_sub_exp_MSB_pos	 
       (.iA    (w_EXP        ),  // input
        .iB    (w_2ndCMSBPos ),  // input
        .iCarry(1'b1         ),  // input
        .oRes  (w_ResExp     ),  // output
        .oCarry(w_Dummy      )); // output


    and(w_oInf_n, w_ResExp[9], w_ResExp[8]);

    and(wAND0,  w_ResExp[9], ~w_ResExp[8]);
    and(wAND1, ~w_ResExp[9],  w_ResExp[8]);
    and(wAND2, ~w_ResExp[9], ~w_ResExp[8], w_ResExp[7], w_ResExp[6], w_ResExp[5], w_ResExp[4], w_ResExp[3], w_ResExp[2], w_ResExp[1], w_ResExp[0]);	 
	  or(w_oInf_p, wAND0, wAND1, wAND2);


    always @(w_ResExp, w_oInf_p, w_oInf_n) 
    begin
        if( w_oInf_p == 1'b1)
        begin
            w_oExp = 8'b11111111;
        end else if( w_oInf_n == 1'b1)
		  begin
            w_oExp = 8'b00000000;
        end	else
		  begin
            w_oExp = w_ResExp[7:0];		  
		  end
    end

    assign oExp = w_oExp;
	 assign oInf_n = w_oInf_n;
	 assign oInf_p = w_oInf_p;	 

endmodule
