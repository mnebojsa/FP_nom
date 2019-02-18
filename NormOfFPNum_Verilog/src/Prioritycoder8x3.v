`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:46 02/13/2019 
// Design Name: 
// Module Name:    Prioritycoder8x3 
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
module PriorityCoder8x3(
    input  [7:0] iX,
    output [2:0] oZ,
    output       oAct);

    wire   [1:0] w_oZL;
    wire         w_ActiveL;
    wire   [1:0] w_oZH;
    wire         w_ActiveH;
    reg          w_oAct;
	 reg    [2:0] w_oZ;

PriorityCoder4x2
    Inst_PriorityCoder4x2_L	 
       (.iX    (iX    [3:0]   ),   // input
        .oZ    (w_oZL         ),   // input
        .oAct  (w_ActiveL     ));  // input

PriorityCoder4x2
    Inst_PriorityCoder4x2_H	 
       (.iX    (iX    [7:4]   ),   // input
        .oZ    (w_oZH         ),   // input
        .oAct  (w_ActiveH     ));  // input

    always @(w_oZL, w_ActiveL, w_oZH, w_ActiveH) 
    begin
        if( w_ActiveH == 1'b1)
        begin
            w_oAct = 1'b1;
            w_oZ   = {1'b0, w_oZH};
        end else if( w_ActiveL == 1'b1)
		  begin
            w_oAct = 1'b1;
            w_oZ   = {1'b1, w_oZL};
        end else
		  begin
            w_oAct = 1'b0;
            w_oZ   = 3'b0;		  
		  end
    end

    assign oZ   = w_oZ;
    assign oAct = w_oAct;
	 
endmodule