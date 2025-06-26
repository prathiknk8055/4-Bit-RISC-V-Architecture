`timescale 1ns / 1ps
module alu4bit(
input [3:0] mode,
input [3:0] operand1,
input [3:0] operand2,
output reg [7:0] result,
output reg [3:0] flag  //{result,carry,overflow,sign}
    );
    reg carry;
    reg overflow;
    reg sign;
    reg show; //shows whether output is there(1) or not(0)
    wire [4:0] addop;
    wire [4:0] subop;
    assign addop = operand1+operand2;
    assign subop = operand1-operand2;    
    always @(*)begin
    result = 8'b0;
    carry = 1'b0;
    overflow = 1'b0;
    sign = 1'b0;
    show = 1'b0;
    case(mode)
    4'd0:begin
         result = addop;
         carry = addop[4];
         overflow = addop > 5'd15;
    end
    4'd1:begin
    result = subop;
    carry = subop[4];
    overflow = subop>5'd15;
    sign = subop[4];
    end
    4'd2: result={4'b0000,operand1};
    4'd3: result = {4'b0000,operand2};
    4'd4: result = {4'b0000, operand1 & operand2}; // AND
    4'd5: result = {4'b0000, operand1 | operand2}; // OR
    4'd6: result = {4'b0000, operand1 ^ operand2}; // XOR
    4'd7: begin
    result = operand1 * operand2;
    carry = 0;
    overflow = (result > 8'hFF);
    end    
    4'd8: result = {7'b0000000, (operand1 == operand2)}; // Equality check
    4'd9: result = {operand2, operand1}; // Swap
    4'd10: result = {4'b0000, ~(operand1 ^ operand2)}; // XNOR
    4'd11: result = {4'b0000, operand1 << 1}; // Shift Left
    4'd12: result = {4'b0000, operand1 >> 1}; // Shift Right
    4'd13: result = {4'b0000, ~(operand1 & operand2)}; // NAND
    4'd14: result = {4'b0000, ~(operand1 | operand2)}; // NOR
    4'd15: result = 8'b00000000; // Clear    
    endcase
    show =| result;
    sign = result[7];
    flag = {show,carry,overflow,sign};
    end
endmodule
