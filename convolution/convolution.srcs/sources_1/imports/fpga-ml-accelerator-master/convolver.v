`timescale 1ns / 1ps

module convolver (clk,ce,weight1,global_rst,activation,conv_op,end_conv,valid_conv);

parameter n = 9'h00a;     
parameter k = 9'h003;     
parameter s = 1;          
input clk,ce,global_rst;
input [15:0] activation;
input wire [(k*k)*16-1:0] weight1;
wire [15:0] weight [0:k*k-1];
output[32:0] conv_op;
output valid_conv,end_conv;
wire [32:0] tmp [k*k+1:0];

generate
	genvar l;
	for(l=0;l<k*k;l=l+1)
	begin
        assign weight [l][15:0] = weight1[16*l +: 16]; 		
	end	
endgenerate

assign tmp[0] = 33'h0000000;
generate
genvar i;
  for(i = 0;i<k*k;i=i+1)
  begin: MAC
    if((i+1)%k ==0)                      
        begin
      if(i==k*k-1)                        
            begin
      mac_manual mac(                     
              .clk(clk),                        
              .ce(ce),                          
              .sclr(global_rst),                
              .a(activation),                   
              .b(weight[i]),                    
              .c(tmp[i]),                       
              .p(conv_op)                       
              );
      end
      else
      begin
      wire [32:0] tmp2;
      
            mac_manual mac(                   
        .clk(clk), 
        .ce(ce), 
        .sclr(global_rst), 
        .a(activation), 
        .b(weight[i]), 
        .c(tmp[i]), 
        .p(tmp2) 
        );
      
      variable_shift_reg #(.WIDTH(33),.SIZE(n-k)) SR (
          .d(tmp2),                  
                    .clk(clk),                 
                    .ce(ce),                   
                    .rst(global_rst),          
                    .out(tmp[i+1])             
                    );
      end
    end
    else
    begin
    mac_manual mac2(                    
      .clk(clk), 
      .ce(ce),
      .sclr(global_rst),
      .a(activation),
      .b(weight[i]),
      .c(tmp[i]), 
      .p(tmp[i+1])
      );
    end 
  end 
endgenerate


reg [31:0] count,count2,count3,row_count;
reg en1,en2,en3;

always@(posedge clk) 
begin
  if(global_rst)
  begin
    count <=0;                      
        count2<=0;                      
        count3<=0;                      
        row_count <= 0;                 
        en1<=0;
    en2<=1;
    en3<=0;
  end
  else if(ce)
  begin
    if(count == (k-1)*n+k-1)   
        begin
      en1 <= 1'b1;
      count <= count+1'b1;
    end
    else
    begin 
      count<= count+1'b1;
    end
  end
  if(en1 && en2) 
  begin
    if(count2 == n-k)
    begin
      count2 <= 0;
      en2 <= 0 ;
      row_count <= row_count + 1'b1;
    end
    else 
    begin
      count2 <= count2 + 1'b1;
    end
  end
  
  if(~en2) 
  begin
  if(count3 == k-2)
  begin
    count3<=0;
    en2 <= 1'b1;
  end
  else
    count3 <= count3 + 1'b1;
  end
  
  if((((count2 + 1) % s == 0) && (row_count % s == 0))||(count3 == k-2)&&(row_count % s == 0)||(count == (k-1)*n+k-1))
  begin                                                                                                                        
      en3 <= 1;                                                                                                                    
    end
  else 
    en3 <= 0;
end

assign end_conv = (count>= n*n+2) ? 1'b1 : 1'b0;
assign valid_conv = (en1&&en2&&en3);
  

endmodule