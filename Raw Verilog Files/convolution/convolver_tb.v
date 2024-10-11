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
    parameter clkp = 40;
	// Instantiate the Unit Under Test (UUT)
	convolver #(9'h004,9'h003,1) uut (
		.clk(clk), 
		.ce(ce), 
//		.weight1(weight1), 
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
		#100;
		
        clk = 0;
		ce = 0;
		weight1 = 0;
		activation = 0;
        global_rst =1;
        #50;
        global_rst =0;	
        #10;	
		ce=1;
//		weight1 = 144'h0008_0007_0006_0005_0004_0003_0002_0001_0000;
		// Initialize Inputs
		for(i=0;i<255;i=i+1) begin
		activation = i;
		#clkp; 
		end
	end 
      always #(clkp/2) clk=~clk;      
endmodule


////kernel(3x3)
//// [[0 1 2]
//// [3 4 5]
//// [6 7 8]] 

////activation map(4x4)
//// [[ 0  1  2  3]
//// [ 4  5  6  7]
//// [ 8  9 10 11]
//// [12 13 14 15]] 

////convolution output (signed decimal)

//// [[258 294]
//// [402 438]] 







