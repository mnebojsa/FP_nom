`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:01 02/12/2019 
// Design Name: 
// Module Name:    calcFrac 
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
module calcFrac #( parameter nBit = 22)(
    input  [nBit :0] iY,
    input  [2    :0] iR,
    output [nBit :0] oFraction,
    output           oCarry    );    
	 
    wire               w_iCarry;
    wire               w_oCarry;
	 wire               w_iCarry1;
    wire  [nBit :0]    w_Res0;
	 reg                wR1R2;				
	 reg                wR0R2;
    wire  [nBit :0]    w_Fraction;

    assign w_iCarry1 = (iR[2] & iR[1]) | (iR[2] & iR[0]);
    assign w_iCarry  = ( iY[0] == 1'b1)?iR[2]:w_iCarry1;
		  
add1 #( .nBit(nBit) )
    Inst_add1	 
       (.iY    (iY        [nBit :0]),  // input
        .iCarry(w_iCarry             ),  // input
        .oRes  (w_Res0    [nBit :0]),  // output
        .oCarry(w_oCarry             )); // output


    assign w_Fraction = ( w_oCarry == 1'b1)?{1'b0, w_Res0[nBit :1]}:w_Res0[nBit:0];	

    assign oCarry    = w_oCarry;						
    assign oFraction = w_Fraction;

endmodule
