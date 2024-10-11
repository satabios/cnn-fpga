`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2023 02:11:10 PM
// Design Name: 
// Module Name: linear
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module linear #(
    parameter input_size = 16,
    parameter N = 16,
    parameter output_size = 2
    
    )(
     input ce,
     input [input_size*16-1:0] input_data,
     input [input_size*output_size*16-1:0] weight1,
     output [15:0] output_data
    );
   
    wire [N-1:0] weight [0:input_size-1][0:output_size-1];

 
    
    generate
        genvar l;
        genvar k;
        for(l=0;l<input_size;l=l+1)begin
         for (k=0;k<output_size;k=k+1)
        begin
            assign weight [l][k] = weight1[N*l +: N]; 		
        end	
        end
    endgenerate
    
    
//    generate
  
//    for(l=0;l<input_size;l=l+1)begin
//     for (k=0;k<output_size;k=k+1)
//    begin
//        assign weight [l][]  		
//    end	
//    end
//    endgenerate
    
    
    
    
    
    
    endmodule
