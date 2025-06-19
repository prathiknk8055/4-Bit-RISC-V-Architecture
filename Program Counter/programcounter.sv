// Code for Program counter
module programcounter(input clk,reset,pc_en, input [3:0] pc_in,output reg [3:0] pc_out);
  always@(posedge clk or posedge reset)begin
    if(reset==1)begin
      pc_out<=1'd0;
    end
    else begin
      if(pc_en==1)begin
        pc_out<=pc_in;
      end
      else
        pc_out<=pc_out+1'd1;
    end
  end
endmodule
