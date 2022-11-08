module MEMORY #(
parameter w_address = 4,
parameter w_data = 8,
parameter L_fifo = 16) (
    input clk,
    input wr_en_ptr,
    input [w_address:0] read_pointer,
    input [w_address:0] write_pointer,
    input [w_data-1:0] WRITE_DATA,

    output [w_data-1:0] READ_DATA
);

reg [w_data-1:0] Memory [0:L_fifo-1];

always @(posedge clk) begin
    if(wr_en_ptr) begin
        Memory[write_pointer[w_address-1:0]] <= WRITE_DATA;
    end
end

assign READ_DATA = Memory[read_pointer[w_address-1:0]];
endmodule