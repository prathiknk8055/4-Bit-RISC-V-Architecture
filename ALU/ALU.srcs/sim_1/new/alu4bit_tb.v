`timescale 1ns/1ps

module alu_tb;
    reg [3:0] mode;
    reg [3:0] operand1;
    reg [3:0] operand2;
    wire [7:0] result;
    wire [3:0] flag;

    alu4bit dut (mode,operand1,operand2,result,flag);

    task show_result;
        begin
            $display("MODE: %2d | OPERAND1: %d | OPERAND2: %d | RESULT: %b (%0d) | FLAG = {S:%b, C:%b, O:%b, SGN:%b}",
                      mode, operand1, operand2, result, result, flag[3], flag[2], flag[1], flag[0]);
        end
    endtask

    initial begin
        // Mode 0: ADD
        mode = 4'd0; operand1 = 4'd8; operand2 = 4'd9; #5; show_result(); // 8+9 = 17, overflow
        // Mode 1: SUB erand            erand
        mode = 4'd1; operand1 = 4'd3; operand2 = 4'd7; #5; show_result(); // 3-7 = -4 (signed)
        // Mode 2: Passerand op1        erand
        mode = 4'd2; operand1 = 4'd5; operand2 = 4'd0; #5; show_result();
        // Mode 3: Passerand op2        erand
        mode = 4'd3; operand1 = 4'd0; operand2 = 4'd6; #5; show_result();
        // Mode 4: AND erand
        mode = 4'd4; operand1 = 4'b1100; operand2 = 4'b1010; #5; show_result(); // 1000
        // Mode 5: OR  erand               erand
        mode = 4'd5; operand1 = 4'b0101; operand2 = 4'b0011; #5; show_result(); // 0111
        // Mode 6: XOR erand               erand
        mode = 4'd6; operand1 = 4'b1010; operand2 = 4'b0110; #5; show_result(); // 1100
        // Mode 7: MUL erand
        mode = 4'd7; operand1 = 4'd5; operand2 = 4'd4; #5; show_result(); // 20
        // Mode 8: EQ  erand            erand
        mode = 4'd8; operand1 = 4'd5; operand2 = 4'd5; #5; show_result(); // Should be 00000001
        mode = 4'd8; operand1 = 4'd5; operand2 = 4'd6; #5; show_result(); // Should be 00000000
        // Mode 9: SWAP
        mode = 4'd9; operand1 = 4'hA; operand2 = 4'h3; #5; show_result(); // Result: 00111010
        // Mode 10: SHL
        mode = 4'd10; operand1 = 4'd3; operand2 = 4'd0; #5; show_result(); // 3 << 1 = 6
        // Mode 11: XNOR
        mode = 4'd11; operand1 = 4'b1010; operand2 = 4'b1100; #5; show_result(); // ~0110 = 1001
        // Mode 12: SHR
        mode = 4'd12; operand1 = 4'd8; operand2 = 4'd0; #5; show_result(); // 8 >> 1 = 4
        // Mode 13: NAND
        mode = 4'd13; operand1 = 4'b1111; operand2 = 4'b1100; #5; show_result(); // ~(1100) = 0011
        // Mode 14: NOR
        mode = 4'd14; operand1 = 4'b1001; operand2 = 4'b0110; #5; show_result(); // ~(1111) = 0000
        // Mode 15: Clear
        mode = 4'd15; operand1 = 4'd0; operand2 = 4'd0; #5; show_result(); // Result = 0
        $finish;
    end

endmodule
