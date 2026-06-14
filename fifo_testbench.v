`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 13:41:16
// Design Name: 
// Module Name: fifo_testbench
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


module fifo_testbench(

    );
    reg clk,rst,rd_en,wr_en;
    reg [7:0] datain;
    wire [7:0] dataout;
    reg [7:0] expected;
    wire almost_full,almost_empty,overflow,underflow;
    fifo_rtl frt(clk,rst,datain,rd_en,wr_en,dataout,almost_full,almost_empty,overflow,underflow);
    initial
    begin
    {clk,rst,rd_en,wr_en,datain}=0;
    end
      always #5 clk=~clk;
      initial
      begin
    
      #10 rst=1;
      #2 datain=8'b10101001;
      expected=datain;
      #10
      rst=0; wr_en=1;
      rd_en=0;
      
      #150
      wr_en=0;
      rd_en=1;
      #10
      if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     #1000
      datain=8'b11111100;
       expected=datain;
      #90 wr_en=0;
      rd_en=1;
      #10
       if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     
    #150wr_en=1;
     rd_en=1;
     #10
      if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     #100 rst=1;
     
      #100 $finish;
      
      
      
      
      
      
      end
endmodule