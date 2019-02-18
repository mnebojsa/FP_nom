`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:27 02/13/2019 
// Design Name: 
// Module Name:    mux8x1 
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
module mux8x1(
    input  [2:0] iSel,
    input  [1:0] iX7,
    input  [1:0] iX6,
    input  [1:0] iX5,
    input  [1:0] iX4,
    input  [1:0] iX3,
    input  [1:0] iX2,
    input  [1:0] iX1,
    input  [1:0] iX0,
    output [1:0] oX );

    reg    [2:0] r_iSel;
    reg    [1:0] r_oX;

    always @(iSel, iX7, iX6, iX5, iX4, iX3, iX2, iX1, iX0) 
    begin
		  r_iSel = iSel;

        case (r_iSel)
            3'b000 : r_oX = iX0;
            3'b001 : r_oX = iX1;
            3'b010 : r_oX = iX2;
            3'b011 : r_oX = iX3;
            3'b100 : r_oX = iX4;
            3'b101 : r_oX = iX5;
            3'b110 : r_oX = iX6;
            3'b111 : r_oX = iX7;
				default: r_oX = 3'b0;
        endcase
    end

    assign oX = r_oX;

endmodule
