`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:33 02/13/2019 
// Design Name: 
// Module Name:    CalcMSBPos 
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
module CalcMSBPos(
    input  [30:0] iX  ,
    output [ 4:0] oPos,
    output        oAct);

    wire   [31:0] w_iX;

	 wire   [ 1:0] w_iZ[7:0];
	 wire   [ 7:0] w_Act;
	 wire   [ 2:0] w_BlkPos;
	 wire          w_dummy;
	 wire   [ 1:0] w_offSet;
	 wire   [ 4:0] w_4xBlkPos;

genvar i;

    assign w_iX = {iX ,1'b0};

	 generate
		  for (i=7; i >= 0; i= i-1) begin :
			   PrCd_GEN
			   PriorityCoder4x2 Inst_In_PrCdr4x2(
               .iX    (w_iX   [4*i +3:4*i] ),  // input
               .oZ    (w_iZ   [i  ]        ),  // output
               .oAct  (w_Act  [i  ]        ));  // output
		  end 
	 endgenerate
	 
PriorityCoder8x3
    Inst_PriorityCoder8x3	 
       (.iX    (w_Act    [7:0]),  // input
        .oZ    (w_BlkPos [2:0]),  // input
        .oAct  (w_dummy       )); // output

mux8x1
    Inst_mux8x1	 
       (.iX7    (w_iZ     [0] ),  // input
        .iX6    (w_iZ     [1] ),  // input
        .iX5    (w_iZ     [2] ),  // input
        .iX4    (w_iZ     [3] ),  // input
        .iX3    (w_iZ     [4] ),  // input
        .iX2    (w_iZ     [5] ),  // input		  
        .iX1    (w_iZ     [6] ),  // input
        .iX0    (w_iZ     [7] ),  // input
        .iSel   (w_BlkPos [2:0]),  // input
        .oX     (w_offSet [1:0])); // output

    // MULTIPLY PriorityCoder8x3 WITH 4 to determin block with MSB b'1 
	 // ADD the offest to the Block Possition
	 // 4*s_BlkPos = s_BlkPos & "00" = B4B3B200
	 // s_BlkPos + offset = B4B3B200 + 000B1B0 = B4B3B2B1B0
	 // => 4*BlkPos + offset = s_BlkPos & s_offSet
    assign w_4xBlkPos = {w_BlkPos, w_offSet[1:0]};

    assign oPos = w_4xBlkPos;
    assign oAct = w_dummy;

endmodule
