`timescale 1ns / 1ps

module fifo_testbench(

    );
    reg clk,rst,rd_en,wr_en;
    reg [7:0] datain;
    wire [7:0] dataout;
    reg [7:0] expected;
    wire almost_full,almost_empty,overflow,underflow,empty,full;
    wire [4:0] wptr_out,rptr_out;
 //wire almost_full,almost_empty,empty,full;
    fifo_rtl frt(clk,rst,datain,rd_en,wr_en,dataout,almost_full,almost_empty,overflow,underflow,empty,full,wptr_out,rptr_out);
    initial
    begin
    {clk,rst,rd_en,wr_en,datain}=0;
    end
      always #10 clk=~clk;
      initial
      begin
 //data1
       @(posedge clk)#10 rst=1;
     @(posedge clk)  #10 rst=0 ;datain=8'b10101001;
      expected=datain;
      wr_en=1;
     @(posedge clk)  #1
       wr_en=0;
      rd_en=0;
      
    @(posedge clk)   #1
     
     wr_en=0; if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
 //data 2
    @(posedge clk)  #8
      datain=8'b11111100;
       expected=datain;
       wr_en=1;
  @(posedge clk)     #10  wr_en=0;
    @(posedge clk)   #10
      if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
 //data3
        @(posedge clk)   #10 
      datain=8'b00000100;
       expected=datain;
       wr_en=1;
       @(posedge clk) #10  wr_en=0;
    @(posedge clk)   #10
       if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         //data4
    @(posedge clk)       #10 
      datain=8'b11110110;
       expected=datain;
       wr_en=1;
    @(posedge clk)   #10  wr_en=0;
      rd_en=0;
//      #10 wr_en=0; rd_en=1;
    @(posedge clk)   #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
 //data5
       @(posedge clk)    #10
      datain=8'b11110001;
       expected=datain;
       wr_en=1;
    @(posedge clk)   #10 wr_en=0;
      rd_en=0;
//  @(posedge clk)     #10 wr_en=0; rd_en=1;
    @(posedge clk)   #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
 //data6
       @(posedge clk)    #10 
      datain=8'b11110000;
       expected=datain;
       wr_en=1;
    @(posedge clk)   #10  wr_en=0;
      rd_en=0;
//     @(posedge clk)  #10 wr_en=0; rd_en=1;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
//data 7
      @(posedge clk)    #10
      datain=8'b10011100;
       expected=datain;
       wr_en=1;
     @(posedge clk)   #10 wr_en=0;
      rd_en=0;
//     @(posedge clk)   #10 wr_en=0;
//      rd_en=1;
     @(posedge clk)   #20
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
//data8
       @(posedge clk)    #10
      datain=8'b10101100;
       expected=datain;
       wr_en=1;
    @(posedge clk)   #10 wr_en=0;
      rd_en=0;
     @(posedge clk)  #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
//data9
   @(posedge clk)        #10
      datain=8'b11111111;
       expected=datain;
       wr_en=1;
    @(posedge clk)   #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data10
 @(posedge clk)          #10
      datain=8'b00111100;
       expected=datain;
       wr_en=1;
  @(posedge clk)     #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
        if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data11
  @(posedge clk)         #10
      datain=8'b11001100;
       expected=datain;
       wr_en=1;
   @(posedge clk)    #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data12
    @(posedge clk)       #10
      datain=8'b11110100;
       expected=datain;
       wr_en=1;
   @(posedge clk)    #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data13
  @(posedge clk)         #10
      datain=8'b11111101;
       expected=datain;
       wr_en=1;
  @(posedge clk)     #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #20
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     
     //data14
  @(posedge clk)     #10
      datain=8'b01111101;
       expected=datain;
       wr_en=1;
   @(posedge clk)    #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
         //data15
  @(posedge clk)         #10
      datain=8'b01010101;
       expected=datain;
       wr_en=1;
   @(posedge clk)    #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
       if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     
     //data16
  @(posedge clk)     #10
      datain=8'b11111101;
       expected=datain;
       wr_en=1;
 @(posedge clk)      #10 wr_en=0;
      rd_en=0;
   @(posedge clk)    #10
        if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
      //data17   
   @(negedge clk)     #10
      datain=8'b10101101;
       expected=datain;
       wr_en=1;
 
   @(posedge clk)    #10 wr_en=0;
      rd_en=0;
  @(posedge clk)     #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
     //read mode activated
     //data1
  @(posedge clk) #90 datain=8'b10110010;
  expected=datain;
     @(posedge clk)  #10
       wr_en=1;
      rd_en=1;
       @(posedge clk)  #10
       wr_en=0;
      rd_en=0;
    @(posedge clk)   #10
    if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
 //data 2
    @(posedge clk)  #10 datain=8'b01101110;
      expected=datain;
     rd_en=1; wr_en=1;
  @(posedge clk)     #10  wr_en=0;
      rd_en=0;
    @(posedge clk)   #10
      if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
 //data3
        @(posedge clk)   #10 datain=8'b11010111;
         expected=datain;
  rd_en=1; wr_en=1;
       @(posedge clk) #10  
      rd_en=0;wr_en=0;
    @(posedge clk)   #10
       if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data4
    @(posedge clk)       #10 datain=8'b01110010;
     expected=datain;
     rd_en=1;wr_en=1;
    @(posedge clk)   #10  
      rd_en=0;wr_en=0;
    @(posedge clk)   #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
 //data5
       @(posedge clk)    #10 datain=8'b00001111;
        expected=datain;
     rd_en=1; wr_en=1;
    @(posedge clk)   #10
      rd_en=0;wr_en=0;
    @(posedge clk)   #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
 //data6
       @(posedge clk)    #10 datain=8'b10010001;
      expected=datain;
       rd_en=1;wr_en=1;
    @(posedge clk)   #10  
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data 7
      @(posedge clk)    #10 datain=8'b10100011;
      expected=datain;
       rd_en=1; wr_en=1; 
     @(posedge clk)   #10 ;
      rd_en=0;wr_en=0;

     @(posedge clk)   #20
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
//data8
       @(posedge clk)    #10 datain=8'b01011010;
        expected=datain;
       rd_en=1; wr_en=1;
    @(posedge clk)   #10;
      rd_en=0;wr_en=0;
     @(posedge clk)  #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
//data9
   @(posedge clk)        #10 datain=8'b10001101;
    expected=datain;
       rd_en=1; wr_en=1;
    @(posedge clk)   #10 ;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data10
 @(posedge clk)          #10 datain=8'b00101111;
  expected=datain;
       rd_en=1; wr_en=1;
  @(posedge clk)     #10 ;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
        if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data11
  @(posedge clk)         #10 datain=8'b01110010;
   expected=datain;
       rd_en=1; wr_en=1;
   @(posedge clk)    #10 ;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data12
    @(posedge clk)       #10 datain=8'b11100000;
     expected=datain;
       rd_en=1;  wr_en=1;
   @(posedge clk)    #10
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data13
  @(posedge clk)         #10 datain=8'b01001011;
   expected=datain;
       rd_en=1;  wr_en=1;
  @(posedge clk)     #10 
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     
 //data14
  @(posedge clk)     #10 datain=8'b11000101;
   expected=datain;
       rd_en=1;  wr_en=1;
   @(posedge clk)    #10;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
 //data15
  @(posedge clk)         #10 datain=8'b00111001;
       expected=datain;
       rd_en=1;  wr_en=1;
   @(posedge clk)    #10 ;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
       if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
     
     //data16
  @(posedge clk)     #10 datain=8'b10000111;
   expected=datain;
       rd_en=1;  wr_en=1;
 @(posedge clk)      #10 ;
      rd_en=0;wr_en=0;
   @(posedge clk)    #10
        if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);
         
//data17   
   @(negedge clk)     #10
       rd_en=1;
  expected=datain;
  wr_en=1;
   @(posedge clk)    #10;datain=8'b00011010;
      rd_en=0;wr_en=0;
  @(posedge clk)     #10
         if(dataout==expected)
        $display("PASS: expected=%h, got=%h", expected, dataout);
        else
         $display("FAIL: expected=%h, got=%h", expected, dataout);

      #10 $finish;
      end
endmodule
