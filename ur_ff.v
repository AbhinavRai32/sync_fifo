`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 17:34:52
// Design Name: 
// Module Name: ur_ff
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



module ur_ff (
    input clk,
    input rst,
    input rx_in,
    output tx_out
);
    wire rx_ready;
    wire [7:0] rx_data;
    wire [7:0] fifo_out;
    wire empty;

    urat_rx urx(
        .clk(clk),
        .rst(rst),
        .tx(rx_in),
        .datax(rx_data),
        .rx_ready(rx_ready)
    );

    fifo_rtl frtr(
        .clk(clk),
        .rst(rst),
        .datain(rx_data),
        .wr_en(rx_ready),
        .rd_en(!empty),
        .dataout(fifo_out),
        .empty(empty)
    );

    urat_tx utx(
        .clk(clk),
        .rst(rst),
        .datain(fifo_out),
        .tx_start(!empty),
        .tx(tx_out)
    );

endmodule

   
