module TOP #(
parameter w_address = 4,
parameter w_data = 8)
(
    input clk,rst,
    input rd,wr,
    input [w_data-1:0] WRITE_DATA,

    output [w_data-1:0] READ_DATA,
    output FULL,EMPTY,OVERFLOW,UNDERFLOW

);
wire [w_address:0] read_pointer;
wire [w_address:0] write_pointer;
wire rd_en_ptr;
wire wr_en_ptr;

CONTROLLER i0 (
    .clk(clk),
    .rst(rst),
    .read_pointer(read_pointer),
    .write_pointer(write_pointer),
    .rd_en(rd),
    .wr_en(wr),
    .rd_en_ptr(rd_en_ptr),
    .wr_en_ptr(wr_en_ptr),
    .FULL(FULL),
    .EMPTY(EMPTY),
    .OVERFLOW(OVERFLOW),
    .UNDERFLOW(UNDERFLOW)
);

MEMORY i1 (
    .clk(clk),
    .wr_en_ptr(wr_en_ptr),
    .read_pointer(read_pointer),
    .write_pointer(write_pointer),
    .WRITE_DATA(WRITE_DATA),
    .READ_DATA(READ_DATA)
);

READPTR i2 (
    .clk(clk),
    .rst(rst),
    .rd_en_ptr(rd_en_ptr),
    .read_pointer(read_pointer)
);

WRITEPTR i3 (
    .clk(clk),
    .rst(rst),
    .wr_en_ptr(wr_en_ptr),
    .write_pointer(write_pointer)
);
endmodule