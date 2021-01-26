
//`include "Carry8Bit.v"
//`include "sum16bit.sv"


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Nitesh 
// 
// Create Date:    1/17/19
// Design Name: Wallace 8 Bit    
// Module Name:     
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: some statements can be replaced with initial
// statements and vise versa
//
//////////////////////////////////////////////////////////////////////////////////

module Wallace8Bit (a, b, p);//kOut);

	input  [7:0] a ;
	input  [7:0] b ;

	wire   [7:0] m0;
	wire   [8:1] m1;
	wire   [9:2] m2;
	wire   [10:3] m3;
	wire   [11:4] m4;
	wire   [12:5] m5;
	wire   [13:6] m6;
	wire   [14:7] m7;

	//first csa op
	wire   [9:0] u1 ;
	wire   [9:2] v1;

	// second csa op
	wire   [12:3] u2;
	wire   [12:5] v2;

	// third csa op
	wire   [14:5] u4;
	wire   [14:7] v4;

	//fourth csa op
	wire   [12:0] u3;
	wire   [10:3] v3;

	// fifth csa op
	wire   [14:0] u5;
	wire   [13:4] v5;

	// sixth csa op
	wire   [14:0] u6;
	wire   [15:5] v6;

        assign m0 = a & {8{b[0]}};
        assign m1 = {a & {8{b[1]}}};//,{1'b0}};
        assign m2 = {a & {8{b[2]}}};//,{2{1'b0}}};
        assign m3 = {a & {8{b[3]}}};//,{3{1'b0}}};
        assign m4 = {a & {8{b[4]}}};//,{4{1'b0}}};
        assign m5 = {a & {8{b[5]}}};//,{5{1'b0}}};
        assign m6 = {a & {8{b[6]}}};//,{6{1'b0}}};
        assign m7 = {a & {8{b[7]}}};//,{7{1'b0}}};
	//output [7:0] u; 
	//output [8:0] v;
	
	// first csa
	//assign u1[0] = m0[0];
	//HalfAdder h1(m0[1],m1[1],u1[1],v1[2]);
	//Carry4bit c1(m0[7:2],m1[7:2],m2[7:2],u1[7:2],v1[8:3]);
	//HalfAdder h2(m1[8],m2[8],u1[8],v1[9]);
	//assign u1[9] = m2[9];
	//

	// second csa
	//assign u2[3] = m3[3];
	//HalfAdder h3(m3[4],m4[4],u2[4],v2[5]);
	//Carry4bit c1(m3[10:4],m4[10:4],m5[10:4],u2[10:4],v2[11:6]);
	//HalfAdder h4(m4[11],m5[11],u1[11],v1[12]);
	//assign u1[12] = m5[12];
	//

// first and second and third csa	
	
	Carry8Bit c1(m0,m1,m2,u1,v1);
	Carry8Bit c2(m3,m4,m5,u2,v2);
	Carry8Bit c3(v2,m6,m7,u4,v4);
	
	// fourth csa
	assign u3[1:0] = u1[1:0];
	HalfAdder h1(u1[2],v1[2],u3[2],v3[3]);
	FullAdder fa1(u1[3],v1[3],u2[3],u3[3],v3[4]);
	FullAdder fa2(u1[4],v1[4],u2[4],u3[4],v3[5]);
	FullAdder fa3(u1[5],v1[5],u2[5],u3[5],v3[6]);
	FullAdder fa4(u1[6],v1[6],u2[6],u3[6],v3[7]);
	FullAdder fa5(u1[7],v1[7],u2[7],u3[7],v3[8]);
	FullAdder fa6(u1[8],v1[8],u2[8],u3[8],v3[9]);
	FullAdder fa7(u1[9],v1[9],u2[9],u3[9],v3[10]);
	//HalfAdder h2(m1[8],m2[8],u1[8],v1[9]);
	assign u3[12:10] = u2[12:10];
	//i

	// for fifth csa
	assign u5[2:0] = u3[2:0];
	HalfAdder h2(u3[3],v3[3],u5[3],v5[4]);	
	HalfAdder h3(u3[4],v3[4],u5[4],v5[5]);	
	FullAdder fa8(u3[5],v3[5],u4[5],u5[5],v5[6]);
	FullAdder fa9(u3[6],v3[6],u4[6],u5[6],v5[7]);
	FullAdder fa10(u3[7],v3[7],u4[7],u5[7],v5[8]);
	FullAdder fa11(u3[8],v3[8],u4[8],u5[8],v5[9]);
	FullAdder fa12(u3[9],v3[9],u4[9],u5[9],v5[10]);
	FullAdder fa13(u3[10],v3[10],u4[10],u5[10],v5[11]);

	HalfAdder h4(u3[11],u4[11],u5[11],v5[12]);	
	HalfAdder h5(u3[12],u4[12],u5[12],v5[13]);
	assign u5[14:13] = u4[14:13];	


	// for sixth csa
	assign u6[3:0] = u5[3:0];
	HalfAdder h6(u5[4],v5[4],u6[4],v6[5]);	
	HalfAdder h7(u5[5],v5[5],u6[5],v6[6]);	
	HalfAdder h8(u5[6],v5[6],u6[6],v6[7]);	
	FullAdder fa14(u5[7],v5[7],v4[7],u6[7],v6[8]);
	FullAdder fa15(u5[8],v5[8],v4[8],u6[8],v6[9]);
	FullAdder fa16(u5[9],v5[9],v4[9],u6[9],v6[10]);
	FullAdder fa17(u5[10],v5[10],v4[10],u6[10],v6[11]);
	FullAdder fa18(u5[11],v5[11],v4[11],u6[11],v6[12]);
	FullAdder fa19(u5[12],v5[12],v4[12],u6[12],v6[13]);
	FullAdder fa20(u5[13],v5[13],v4[13],u6[13],v6[14]);
	HalfAdder h9(u5[14],v4[14],u6[14],v6[15]);

	output [1:0] kOut;
	output  [16:0] p;

	sum16bit s1({{1'b0},u6},{v6,{5{1'b0}}},2'b00,p);//,kOut);

endmodule
