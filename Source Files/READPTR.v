module READPTR #(parameter w_address = 4)(
    input clk,rst,
    input rd_en_ptr,
    // extra bit to detect full / empty states
    output reg [w_address:0] read_pointer
);

always @(posedge clk or negedge rst)begin
    if(!rst) begin
        read_pointer <= 5'd0;
    end
    else if(rd_en_ptr) begin
        read_pointer <= read_pointer + 1;
    end
end


endmodule