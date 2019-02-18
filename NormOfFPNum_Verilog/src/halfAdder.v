`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:27 02/12/2019 
// Design Name: 
// Module Name:    halfAdder 
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
module halfAdder(
    input  iA,
    input  iB,
    output oFnc,
    output oC );

    xor(oFnc, iA, iB);
    and(  oC, iA, iB);

endmodule
