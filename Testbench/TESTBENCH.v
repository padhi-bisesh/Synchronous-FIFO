module TESTBENCH;
reg     clk;  
 reg     rst_n;  
 reg     wr;  
 reg     rd;  
 reg     [7:0] data_in;  
 
 wire     [7:0] data_out;  
 wire     fifo_empty;  
 wire     fifo_full;    
 wire     fifo_overflow;  
 wire     fifo_underflow;  

TOP DUT (
   .READ_DATA(data_out), .FULL(fifo_full), .EMPTY(fifo_empty), .OVERFLOW(fifo_overflow),   
   .UNDERFLOW(fifo_underflow),   
   .clk(clk), .rst(rst_n), .wr(wr), .rd(rd), .WRITE_DATA(data_in)  
   );  

integer i;
always #5 clk = ~clk;
initial begin
           $dumpfile("TESTBENCH.vcd");
            $dumpvars(0,TESTBENCH);  
           clk     = 1'b1;
           rst_n = 1'b1;  
           #0 rst_n     = 1'b0;
            #0 rst_n     = 1'b1;
           wr     = 1'b0;  
           rd     = 1'b0;  
           data_in     = 8'd0;  
      end
initial begin
    #1 wr = 0; rd = 0; data_in = 11;
    for (i = 0;i<17;i++) begin
        #10 wr = 1; rd = 0; data_in = i+1;
    end
    for (i = 0;i<10;i++) begin
        #10 wr = 0; rd = 1; data_in = i+1;
    end
    #10 $finish;
end
endmodule