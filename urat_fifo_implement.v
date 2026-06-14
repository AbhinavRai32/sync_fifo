`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 16:57:54
// Design Name: 
// Module Name: urat_fifo_implement
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


module urat_fifo_implement(

    );

reg clk, rst;
reg rx_in;
wire tx_out;

ur_ff uft(
    .clk(clk),
    .rst(rst),
    .rx_in(rx_in),
    .tx_out(tx_out)
);

always #5 clk = ~clk;

// UART frame send karne ka task
// baud = 50 cycles, 1 cycle = 10ns, 1 bit = 500ns
task send_byte;
    input [7:0] data;
    integer i;
    begin
        // start bit
        rx_in = 0;
        #500;
        // 8 data bits - LSB first
        for(i = 0; i < 8; i = i+1) begin
            rx_in = data[i];
            #500;
        end
        // stop bit
        rx_in = 1;
        #500;
    end
endtask

initial begin
    clk = 0;
    rst = 1;
    rx_in = 1;  // idle state
    #100 rst = 0;
    #100;
    
    // byte 1 bhejo
    send_byte(8'hA9);
    #1000;
    
    // byte 2 bhejo
    send_byte(8'hFC);
    #1000;
    
    #5000 $finish;
end

endmodule

