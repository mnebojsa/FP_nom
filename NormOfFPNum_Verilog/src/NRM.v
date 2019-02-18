`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:01 02/13/2019 
// Design Name: 
// Module Name:    NRM 
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
module NRM #( parameter oWIDTH = 32 )(
    input              iCLK,
    input              iRST,
    input  [     39:0] iA,
    output [oWIDTH-1:0] oNR );


    wire [ 4:0]        w_pos;
	 wire               w_MSBAct;
	 reg  [oWIDTH-10:0] w_inFrc;
	 reg  [ 2:0]        w_Rnd;
    wire               w_oCarry;
    wire [oWIDTH-10:0] w_oFrac;
    wire [7        :0] w_oExp;
    reg  [7        :0] ww_oExp;
	 wire               w_oInf_n;
	 wire               w_oInf_p;
	 wire [    39*2:0]  w_input;
	 
	 
CalcMSBPos
    Inst_CalcMSBPos	 
       (.iX    (iA      [30:0]),  // input
        .oPos  (w_pos   [ 4:0]),  // output
        .oAct  (w_MSBAct       )); // output

    assign w_input = {iA, 39'b0};

    always @(w_input, w_pos) 
    begin: B1
	 
       w_Rnd   =   3'b0;
       w_inFrc =  22'b0;
		 
       if( w_pos < 30)
       begin
       // 30 - v_L -1 first digit is the one after MSB 1
       // MSB is possitioned on  30 - v_L, and the first digit after 
       // is placed on 30 - v_L -1 
           w_inFrc  = w_input[30 -   w_pos            -1 +39 -: oWIDTH-9];
           w_Rnd    = w_input[30 -(oWIDTH-10) - w_pos -2 +39 -: 3];
       end else
		 begin
           w_inFrc = 22'b0;
           w_Rnd   =  3'b0;
		 end
    end


calcFrac#( .nBit(oWIDTH-10) )
    Inst_CalcFrac	 
       (.iY        (w_inFrc  [oWIDTH-10:0]),  // input
        .iR        (w_Rnd    [ 2       :0]),  // input 
        .oCarry    (w_oCarry              ),  // output
        .oFraction (w_oFrac  [oWIDTH-10:0])); // output


calcExp
    Inst_CalcExp	 
       (.iExp       (iA       [38      :31]),  // input
        .iMSBPos    (w_pos    [ 4      : 0]),  // input 
        .iRndFlag   (w_oCarry              ),  // input 
        .oExp       (w_oExp    [ 7      :0]),  // output
        .oInf_n     (w_oInf_n              ),  // output
        .oInf_p     (w_oInf_p              )); // output

		  
    assign oNR[oWIDTH -1]          = iA[39];
    assign oNR[oWIDTH -2:oWIDTH-9] = w_oExp;
    assign oNR[oWIDTH-10:      0]  = (w_oInf_n == 1'b1 || w_oInf_p == 1'b1)?(22'b0):w_oFrac;  // instead of 22'b oWIDTH-9 should stand
                                                                                              //still to solve
endmodule
