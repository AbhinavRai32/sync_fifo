`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 17:38:13
// Design Name: 
// Module Name: ur_ff_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module ur_ff_tb();

reg clk, rst;
wire loopback;

ur_ff uft(
    .clk(clk),
    .rst(rst),
    .rx_in(loopback),
    .tx_out(loopback)
);

always #5 clk = ~clk;

initial begin
     clk=0; rst = 1;
     #100 rst=0;
#50000 $finish;
end


endmodule
