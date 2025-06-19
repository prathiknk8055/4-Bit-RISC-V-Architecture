module programcounter_tb;
  reg clk,reset,pc_en;
  reg [3:0] pc_in;
  wire [3:0] pc_out;
  
  programcounter dut(clk,reset,pc_en,pc_in,pc_out);
  
  always #5 clk=~clk;
  
  initial begin
    $dumpfile("programcounter.vcd");
    $dumpvars(0,programcounter_tb);
    $monitor("time= %0t,reset=%b,pc_enable= %b, pc_input=%d,pc_output=%d",$time,reset,pc_en,pc_in,pc_out);
    clk=1'd0;reset=1'd1;#20;
    reset=1'd0;pc_en=1'd0;#30;
    pc_in=4'b0111;pc_en=2'b01;#10
    reset=1'd0;pc_en=1'd0;#30;
    pc_in=4'b0011;pc_en=2'b01;#10
    reset=1'd0;pc_en=1'd0;#30;
    $finish;
  end
endmodule