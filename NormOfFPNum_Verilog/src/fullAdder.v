`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:28 02/12/2019 
// Design Name: 
// Module Name:    fullAdder 
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
module fullAdder(
    input  iA,
    input  iB,
    input  iC,
    output oFnc,
    output oC );

    wire iAandiB, iAandiC, iBandiC;

    xor(oFnc, iA, iB, iC);
    and(iAandiB, iA, iB);
    and(iAandiC, iA, iC);
    and(iBandiC, iB, iC);
     or(oC, iAandiB, iAandiC, iBandiC);	 
endmodule