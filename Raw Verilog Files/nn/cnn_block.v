`timescale 1ns / 1ps
`define FIXED_POINT 1
module cnn_block #(
    parameter n = 9'h00a,  //size of the input image/activation map
    parameter k = 9'h003,  //size of the convolution window
    parameter p = 9'h002,  //size of the pooling window
    parameter s = 1,       //stride value during convolution
    parameter ptype = 1,  //0 => average pooling , 1 => max_pooling
    parameter act_type = 0,//0 => ReLu activation function, 1=> Hyperbolic tangent activation function
    parameter N = 16,     //Bit width of activations and weights (total datapath width)
    parameter Q = 12,     //Number of fractional bits in case of fixed point representation
    parameter AW = 10,    //Needed in case of tanh activation function to set the size or ROM
    parameter DW = 16,    //Datapath width = N 
    parameter psqr_inv = 16'b0000010000000000 // = 1/p**2 in the (N,Q) format being used currently
    )(
    input clk,
    input global_rst,
    input ce,
    input [15:0] activation,
    input [(k*k)*16-1:0] weight1,
    output [15:0] data_out,
    output valid_op,
    output end_op,
    output [15:0] conv_out,
    output conv_valid,
    output conv_end
    );

    wire [N-1:0] conv_op;
    wire valid_conv,end_conv;
    wire valid_ip;
    wire [N-1:0] relu_op;
//    wire [N-1:0] tanh_op;
    wire [N-1:0] pooler_ip;
    wire [N-1:0] pooler_op;
    reg [N-1:0] pooler_op_reg;
    
    
    reg [(4*2)*16-1:0] weight_linear;
    reg [15:0] dense_out;
    
    convolver #(.n(n),.k(k),.s(s),.N(N),.Q(Q)) conv(//Convolution engine
            .clk(clk), 
            .ce(ce), 
//            .weight1(weight1), 
            .global_rst(global_rst), 
            .activation(activation), 
            .conv_op(conv_op), 
            .end_conv(end_conv), 
            .valid_conv(valid_conv)
        );
    assign conv_valid = valid_conv;
    assign conv_end = end_conv;
    assign conv_out = conv_op;
    
    assign valid_ip = valid_conv && (!end_conv);
    
    relu #(.N(N)) act(                             // ReLu Activation function
            .din_relu(conv_op),
            .dout_relu(relu_op)
        );
        
    
    assign pooler_ip = relu_op;
    
    pooler #(.N(N),.Q(Q),.m(n-k+1),.p(p),.ptype(ptype),.psqr_inv(psqr_inv)) pool( //Pooling Unit
            .clk(clk),
            .ce(valid_ip),
            .master_rst(global_rst),
            .data_in(pooler_ip),
            .data_out(pooler_op),
            .valid_op(valid_op),
            .end_op(end_op)
        );
        
   
    
//    linear # (.input_size(n-k+1),.output_size(2)) dense1(
//            .valid_op(valid_op),
//            .input_data(pooler_op),
//            .weight1(weight_linear),
//            .output_data(dense_out)
            
//        );
    
    

    assign data_out = pooler_op;
    
endmodule