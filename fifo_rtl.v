`timescale 1ns / 1ps



module fifo_rtl #(
    parameter depth = 16,
    parameter width = 8
)(
    input                   clk,
    input                   rst,
    input  [width-1:0]      datain,
    input                   rd_en,
    input                   wr_en,
    output reg [width-1:0]  dataout,
    output wire almost_full,
    output wire almost_empty,
    output reg overflow,
    output reg underflow,
    output wire empty,full,
    output wire [4:0] wptr_out,rptr_out
);
    
localparam ADDR_BITS = $clog2(depth);     // 16 → 4
localparam PTR_BITS  = ADDR_BITS + 1;     // 4+1 = 5 (extra MSB trick!)

//reg [PTR_BITS-1:0]  wptr, rptr;           // 5-bit pointers
reg [4:0] wptr,rptr;
assign  wptr_out = wptr ;
assign  rptr_out = rptr ;
reg [width-1:0]     mem [0:depth-1];      // memory array
wire [ADDR_BITS-1:0]wptrd=wptr[PTR_BITS-2:0];                // lower bit of wptr and rptr where data is stored and msb tells u status of full and empty
wire [ADDR_BITS-1:0]rptrd=rptr[PTR_BITS-2:0];

assign empty = (wptr==rptr);              // condition for empty
assign full = (wptr[PTR_BITS-1]!=rptr[PTR_BITS-1]&&wptrd==rptrd); // condition for full
wire [PTR_BITS-1:0] occupancy = wptr - rptr;

localparam AF_THRESH = depth-4;
localparam AE_THRESH = 4;
assign almost_full  = (occupancy >= AF_THRESH);
assign almost_empty = (occupancy <= AE_THRESH);
always@(posedge clk)
begin
//reset condition
if(rst)
begin
dataout<=0;
wptr<=0;
rptr<=0;
overflow<=0;
underflow<=0;
end

//read and write simultaneously with full and empty =0
else if(wr_en&&rd_en&&!full&!empty)
begin
mem[wptr[ADDR_BITS-1:0]]<=datain;
wptr<=wptr+1'b1;
 dataout<=mem[rptr[ADDR_BITS-1:0]];
rptr<=rptr+1'b1;
end
// read and write simultaneously with full only
else if (rd_en&&wr_en&&full&&!empty)
begin
mem[wptr[ADDR_BITS-1:0]]<=datain;
wptr<=wptr+1'b1;
 dataout<=mem[rptr[ADDR_BITS-1:0]];
rptr<=rptr+1'b1;
end
// read and write with empty only block reading 
else if (wr_en&&rd_en&&!full&&empty)
begin
mem[wptr[ADDR_BITS-1:0]]<=datain;
wptr<=wptr+1'b1;

end
//write condition 
else if(wr_en&&!full)
begin
mem[wptr[ADDR_BITS-1:0]]<=datain;
wptr<=wptr+1'b1;
end
//read condition
else if(rd_en&&!empty)
begin
 dataout<= mem[rptr[ADDR_BITS-1:0]];
rptr<=rptr+1'b1;
end
//overflo/underflow sticky flags
else if(wr_en&&full)
overflow<=1;
else if(rd_en&&empty)
underflow<=1;


end

endmodule
