`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:11:31 03/01/2018
// Design Name:   spi_ce
// Module Name:   E:/FPGA/26online_lever/sim/tb_online_lever.v
// Project Name:  online_lever
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spi_ce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_online_lever;

	// Inputs
	reg sclk;
	reg rst_n;
	reg key_flag;

	// Outputs
	wire cs_n;
	wire sck;
	wire sdi;

	// Instantiate the Unit Under Test (UUT)
	spi_ce uut (
		.sclk(sclk), 
		.rst_n(rst_n), 
		.key_flag(key_flag), 
		.cs_n(cs_n), 
		.sck(sck), 
		.sdi(sdi)
	);

	initial begin
		// Initialize Inputs
		sclk = 0;
		rst_n = 0;
		key_flag = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst_n = 1;
		key_flag = 1;
		#20;
		key_flag	=0;
		
	end
always	#10	sclk	=	~sclk;  
      
endmodule

