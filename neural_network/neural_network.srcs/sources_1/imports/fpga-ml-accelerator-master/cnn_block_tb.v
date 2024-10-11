//`timescale 1ns / 1ps
//`define FIXED_POINT 1
//module cnn_block_tb;

//	// Inputs
//	reg clk;
//	reg ce;
//	reg [143:0] weight1;
//	reg global_rst;
//	reg [15:0] activation;
////	reg [575:0] activation1;
//	reg [15:0] input_data[35:0];

//	// Outputs
//	wire [15:0] acc_op,conv_out;
//	wire conv_valid,conv_end;
//	wire end_op;
//	wire valid_op;
//	integer i;
//    parameter clkp = 10;
//    integer ip_file,r3,op_file;
//	// Instantiate the Unit Under Test (UUT)
//	cnn_block #(.n('d6),.p('d2),.k('d3),.N('d16),.Q('d12),.ptype('d0),.s('d1),.psqr_inv(16'b0000010000000000)) uut (
//		.clk(clk), 
//		.ce(ce), 
//		.weight1(weight1), 
//		.global_rst(global_rst), 
//		.activation(activation), 
//		.data_out(acc_op), 
//		.valid_op(valid_op), 
//		.end_op(end_op),
//		.conv_out(conv_out),
//		.conv_valid(conv_valid),
//		.conv_end(conv_end)
//	);

//	initial begin
//		// Initialize Inputs
//		clk = 0;
//		ce = 0;
//		weight1 = 0;
//		global_rst = 0;
//		activation = 0;

//		// Wait 100 ns for global reset to finish
//		#100;
		
//        clk = 0;
//		ce = 0;
//		weight1 = 0;
//		activation = 0;
//        global_rst =1;
//        #60;
//        global_rst =0;	
//        #10;	
//		ce=1;
////		ip_file = $fopen("activations.txt","r");
//		op_file = $fopen("acc_out.txt","a");
//		`ifdef FIXED_POINT
//		weight1 = 144'b1111100110010111_0000001111010001_1111011010001101_1111101010010011_1111110101110100_1111110111101111_0000000110010110_1111000011010101_1111110111110100;
////		activation1 = 576'b1111100101101110_0000000011111010_1111011000100001_1111001000101101_0000100100101110_0000010100000000_0000010001100110_0000001001101011_1111000101000001_1111101101110100_0000111001000011_1111000111101100_0000101110100110_0000110000010010_1111000110100100_0000010011100000_0000000110100111_0000001100011110_1111111101111010_1111100100001111_1111100110000111_0000000111110111_1111110010101101_0000100100111101_1111110101100101_1111010010011011_1111010011010101_1111000111000101_0000011011111010_1111100101011011_1111011001011101_0000101010011010_0000001000101100_1111001010100011_0000000101110000_1111010100010111;
//		input_data[0]= 16'b1111100101101110;input_data[1]= 16'b0000000011111010;input_data[2]= 16'b1111011000100001;input_data[3]= 16'b1111001000101101;input_data[4]= 16'b0000100100101110;
//        input_data[5]= 16'b0000010100000000; input_data[6]= 16'b0000010001100110;input_data[7] = 16'b0000001001101011;
//        input_data[8]= 16'b1111000101000001; input_data[9]= 16'b1111101101110100;input_data[10]= 16'b0000111001000011;
//        input_data[11]= 16'b1111000111101100; input_data[12]= 16'b0000101110100110; input_data[13]= 16'b0000110000010010;input_data[14]= 16'b1111000110100100; input_data[15]= 16'b0000010011100000;
//        input_data[16]= 16'b0000000110100111;input_data[17]= 16'b0000001100011110;input_data[18]= 16'b1111111101111010;input_data[19]= 16'b1111100100001111; input_data[20]= 16'b1111100110000111;
//        input_data[21]= 16'b0000000111110111;input_data[22]= 16'b1111110010101101;input_data[23]= 16'b0000100100111101;input_data[24]= 16'b1111110101100101;input_data[25]= 16'b1111010010011011;
//        input_data[26]= 16'b1111010011010101;input_data[27]= 16'b1111000111000101;input_data[28]= 16'b0000011011111010;input_data[29]= 16'b1111100101011011;input_data[30]= 16'b1111011001011101;
//        input_data[31]= 16'b0000101010011010;input_data[32]= 16'b0000001000101100;input_data[33]= 16'b1111001010100011;input_data[34]= 16'b0000000101110000;input_data[35]= 16'b1111010100010111;
//		`else
//        weight1 = 144'h0008_0007_0006_0005_0004_0003_0002_0001_0000;
//		`endif
//		// Initialize Inputs
//		for(i=0;i<36;i=i+1) begin
//		`ifdef FIXED_POINT
////		r3 = $fscanf(ip_file,"%b\n",activation);
//        activation = input_data[i];
//    	`else
//		activation = i;
//		`endif
//		#clkp; 
//		end
//	end 
//      always #(clkp/2) clk = ~clk;  
      
//      always@(posedge clk) begin
//        if(conv_valid)
//            $display("conv_out: %b",conv_out);
//         if(valid_op)
//          $display("acc_op: %b",acc_op);

//        if(conv_end) begin
//        if(ce)
//        begin
//        $display("Final","%b%0d",acc_op, "end",0);
//        $finish;
//        end
//      end
//    end    
//endmodule


`timescale 1ns / 1ps
`define FIXED_POINT 1
module cnn_block_tb;

	// Inputs
	reg clk;
	reg ce;
	reg [143:0] weight1;
	reg global_rst;
	reg [15:0] activation;
//	reg [575:0] activation1;
	reg [15:0] input_data[35:0];
	
//	reg [4*16-1:0] linear_input_data;
	genvar linear_flag;

	// Outputs
	wire [15:0] acc_op,conv_out;
	wire conv_valid,conv_end;
	wire end_op;
	wire valid_op;
	integer i;
    parameter clkp = 2;
    integer ip_file,r3,op_file;
    

	// Instantiate the Unit Under Test (UUT)
	cnn_block #(.n('d6),.p('d2),.k('d3),.N('d16),.Q('d12),.ptype('d0),.s('d1),.psqr_inv(16'b0000010000000000)) uut (
		.clk(clk), 
		.ce(ce), 
		.weight1(weight1), 
		.global_rst(global_rst), 
		.activation(activation), 
		.data_out(acc_op), 
		.valid_op(valid_op), 
		.end_op(end_op),
		.conv_out(conv_out),
		.conv_valid(conv_valid),
		.conv_end(conv_end)
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
//		ip_file = $fopen("activations.txt","r");
		op_file = $fopen("acc_out.txt","a");
		`ifdef FIXED_POINT
		weight1 = 144'b1111100110010111_0000001111010001_1111011010001101_1111101010010011_1111110101110100_1111110111101111_0000000110010110_1111000011010101_1111110111110100;
//		activation1 = 576'b1111100101101110_0000000011111010_1111011000100001_1111001000101101_0000100100101110_0000010100000000_0000010001100110_0000001001101011_1111000101000001_1111101101110100_0000111001000011_1111000111101100_0000101110100110_0000110000010010_1111000110100100_0000010011100000_0000000110100111_0000001100011110_1111111101111010_1111100100001111_1111100110000111_0000000111110111_1111110010101101_0000100100111101_1111110101100101_1111010010011011_1111010011010101_1111000111000101_0000011011111010_1111100101011011_1111011001011101_0000101010011010_0000001000101100_1111001010100011_0000000101110000_1111010100010111;
		input_data[0]= 16'b1111100101101110;input_data[1]= 16'b0000000011111010;input_data[2]= 16'b1111011000100001;input_data[3]= 16'b1111001000101101;input_data[4]= 16'b0000100100101110;
        input_data[5]= 16'b0000010100000000; input_data[6]= 16'b0000010001100110;input_data[7] = 16'b0000001001101011;
        input_data[8]= 16'b1111000101000001; input_data[9]= 16'b1111101101110100;input_data[10]= 16'b0000111001000011;
        input_data[11]= 16'b1111000111101100; input_data[12]= 16'b0000101110100110; input_data[13]= 16'b0000110000010010;input_data[14]= 16'b1111000110100100; input_data[15]= 16'b0000010011100000;
        input_data[16]= 16'b0000000110100111;input_data[17]= 16'b0000001100011110;input_data[18]= 16'b1111111101111010;input_data[19]= 16'b1111100100001111; input_data[20]= 16'b1111100110000111;
        input_data[21]= 16'b0000000111110111;input_data[22]= 16'b1111110010101101;input_data[23]= 16'b0000100100111101;input_data[24]= 16'b1111110101100101;input_data[25]= 16'b1111010010011011;
        input_data[26]= 16'b1111010011010101;input_data[27]= 16'b1111000111000101;input_data[28]= 16'b0000011011111010;input_data[29]= 16'b1111100101011011;input_data[30]= 16'b1111011001011101;
        input_data[31]= 16'b0000101010011010;input_data[32]= 16'b0000001000101100;input_data[33]= 16'b1111001010100011;input_data[34]= 16'b0000000101110000;input_data[35]= 16'b1111010100010111;
		`else
        weight1 = 144'h0008_0007_0006_0005_0004_0003_0002_0001_0000;
		`endif
		// Initialize Inputs
		for(i=0;i<36;i=i+1) begin
		`ifdef FIXED_POINT
//		r3 = $fscanf(ip_file,"%b\n",activation);
        activation = input_data[i];
    	`else
		activation = i;
		`endif
		#clkp; 
		end
	end 
      always #(clkp/2) clk = ~clk;  
      
      
      
      always@(posedge clk) begin
        if(conv_valid)
            $display("conv_out: %b",conv_out);
         if(valid_op)
          $display("acc_op: %b",acc_op);
//          linear_input_data[ linear_flag: linear_flag+15] = acc_op;
//            linear_flag = linear_flag+ 16;
        if(conv_end) begin
        if(ce)
        begin
        $display("Final","%b%0d",acc_op, "end",0);
       
    




        $finish;
        end
      end
    end    
endmodule