module CONTROLLER #(parameter w_address = 4)(
    input clk,rst,
    input [w_address:0] read_pointer,
    input [w_address:0] write_pointer,
    input rd_en,
    input wr_en,

    output rd_en_ptr,
    output wr_en_ptr,

    output FULL,
    output EMPTY,
    output reg OVERFLOW,
    output reg UNDERFLOW
);
wire opp_polarity;
wire [w_address-1:0] same_address;
assign opp_polarity = read_pointer[w_address]^write_pointer[w_address];
assign same_address = (read_pointer[w_address-1:0]==write_pointer[w_address-1:0]);

assign FULL = (opp_polarity)&(same_address);
assign EMPTY = (~opp_polarity)&(same_address);

assign rd_en_ptr = (~EMPTY) & rd_en;
assign wr_en_ptr = (~FULL) & wr_en;

assign demand_overflow = FULL & wr_en;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        OVERFLOW <= 0;
    end
    else if (rd_en_ptr) begin
        OVERFLOW <= 0;
    end
    else if (demand_overflow) begin
        OVERFLOW <= 1;
    end
end

assign demand_underflow = EMPTY & rd_en;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        UNDERFLOW <= 0;
    end
    else if (wr_en_ptr) begin
        UNDERFLOW <= 0;
    end
    else if (demand_overflow) begin
        UNDERFLOW <= 1;
    end
end
endmodule