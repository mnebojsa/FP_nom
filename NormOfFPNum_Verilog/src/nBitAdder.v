`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:52 02/12/2019 
// Design Name: 
// Module Name:    nBitAdder 
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
module nBitAdder #( parameter nBit = 10 )(
    input  [nBit -1:0] iA,
    input  [nBit -1:0] iB,
    input              iCarry,
    output [nBit -1:0] oRes,
    output             oCarry );

wire wCarry [nBit:0];

genvar i;

	 assign wCarry[0] = iCarry;

	 generate
		  for (i=0; i <= nBit -1; i=i+1) begin :
			   XFA
			   fullAdder FA_instance(
               .iA    (iA      [i  ] ),    // input
               .iB    (iB      [i  ] ),    // input
               .iC    (wCarry  [i  ] ),    // input
               .oFnc  (oRes    [i  ] ),    // output
               .oC    (wCarry  [i+1]));  // output
		  end 
	 endgenerate

    assign oCarry = wCarry[nBit];		  
endmodule