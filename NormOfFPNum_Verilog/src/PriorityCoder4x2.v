`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:58 02/13/2019 
// Design Name: 
// Module Name:    PriorityCoder4x2 
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
module PriorityCoder4x2(
    input  [3:0] iX,
    output [1:0] oZ,
    output       oAct);

    assign oZ[1] = ~iX[3] & ~iX[2];
    assign oZ[0] = ~iX[3] & (iX[2] | ~iX[1]);
	 
	 assign oAct  = iX[3] | iX[2] | iX[1] | iX[0];
endmodule
