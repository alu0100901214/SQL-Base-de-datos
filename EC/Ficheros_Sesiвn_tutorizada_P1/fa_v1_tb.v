
`timescale 1 ns / 10 ps;

module fa_v1_tb;

reg test_a, test_b, c_in;

wire test_sum, test_carry;

fa_v1 fa1(test_sum, test_carry, test_a, test_b, test_c_in);

initial
begin
  $monitor("tiempo=%0d a=%b b=%b c_in=%b suma=%b acarreo=%b", $time, test_a, test_b, test_c_in, test_sum, test_carry);
  $dumpfile("fa_v1_tb.vcd");
  $dumpvars;

  test_c_in = 1'b0;
  //vector de test 0
  test_a = 1'b0;
  test_b = 1'b0;
  #20;

  //vector de test 1
  test_a = 1'b0;
  test_b = 1'b1;
  #20;

  //vector de test 2
  test_a = 1'b1;
  test_b = 1'b0;
  #20;
  //vector de test 3
  test_a = 1'b1;
  test_b = 1'b1;
  #20;
  
  test_c_in = 1'b1;
  //vector de test 0
  test_a = 1'b0;
  test_b = 1'b0;
  #20;

  //vector de test 1
  test_a = 1'b0;
  test_b = 1'b1;
  #20;

  //vector de test 2
  test_a = 1'b1;
  test_b = 1'b0;
  #20;
  //vector de test 3
  test_a = 1'b1;
  test_b = 1'b1;
  #20;
  $finish;  //fin simulacion

