`timescale 1ns / 1ps

module convolver_tb;

	// Inputs
	reg clk;
	reg ce;
	reg [143:0] weight1;
	reg global_rst;
	reg [15:0] activation;

	// Outputs
	wire [31:0] conv_op;
	wire end_conv;
	wire valid_conv;
	integer i;
    parameter clkp = 2;
	// Instantiate the Unit Under Test (UUT)
//	Max Input Size = d20

//    wire inp_size = 9'h016;
//    wire kernel_size = 9'h003;

	convolver #(9'h016,9'h003,1) uut (
		.clk(clk), 
		.ce(ce), 
		.weight1(weight1), 
		.global_rst(global_rst), 
		.activation(activation), 
		.conv_op(conv_op), 
		.end_conv(end_conv), 
		.valid_conv(valid_conv)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		ce = 0;
		weight1 = 0;
		global_rst = 0;
		activation = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
        clk = 0;
		ce = 0;
		weight1 = 0;
		activation = 0;
        global_rst =1;
        #10;
        global_rst =0;	
        #10;	
		ce=1;
		weight1 = 144'h0008_0007_0006_0005_0004_0003_0002_0001_0000;
		// Initialize Inputs
		for(i=0;i<(20*20);i=i+1) begin
		activation = i;
		#clkp; 
		end
	end 
      always #(clkp/2) clk=~clk;      
endmodule






//kernel
// [[0 1 2]
// [3 4 5]
// [6 7 8]] 

//activation map
// [[ 0  1  2  3]
// [ 4  5  6  7]
// [ 8  9 10 11]
// [12 13 14 15]] 

//convolution output
// [[258 294]
// [402 438]] 