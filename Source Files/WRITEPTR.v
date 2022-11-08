module WRITEPTR #(parameter w_address = 4)(
    input clk,rst,
    input wr_en_ptr,
    // extra bit to detect full / empty states
    output reg [w_address:0] write_pointer
);

always @(posedge clk or negedge rst)begin
    if(!rst) begin
        write_pointer <= 5'd0;
    end
    else if(wr_en_ptr) begin
        write_pointer <= write_pointer + 1;
    end
end
endmodule