`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:01 02/12/2019 
// Design Name: 
// Module Name:    add1 
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
module add1 #( parameter nBit = 22 )(
    input  [nBit :0] iY,
    input              iCarry,
    output [nBit :0] oRes,
    output             oCarry);



    wire [nBit +1   :0] w_iB;
    wire [nBit      :0] w_oRes;
    genvar i;


	 assign w_iB[0] = iCarry;
	 
	 generate
		  for (i=0; i <= nBit ; i=i+1) begin :
			   ADDX
			   halfAdder HA_instance(
               .iA    (iY      [i  ] ),    // input
               .iB    (w_iB    [i  ] ),    // input
               .oFnc  (w_oRes  [i  ] ),    // output
               .oC    (w_iB    [i+1] ));   // output
		  end 
	 endgenerate

    assign oRes   = w_oRes;
    assign oCarry = w_iB[nBit+1];

endmodule
