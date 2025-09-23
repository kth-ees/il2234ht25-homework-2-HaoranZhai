module shift_register_tb;
  
localparam N = 4;
  
  logic clk;
  logic rst_n;
  logic serial_parallel;
  logic load_enable;
  logic serial_in;
  logic [N-1:0] parallel_in;
  logic [N-1:0] parallel_out;
  logic serial_out;

  shift_register #(.N(N)) dut (
    .clk(clk),
    .rst_n(rst_n),
    .serial_parallel(serial_parallel),
    .load_enable(load_enable),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .parallel_out(parallel_out),
    .serial_out(serial_out)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst_n = 0;
    load_enable = 0;
    serial_parallel = 0;
    serial_in = 0;
    parallel_in = '0;

    #12 rst_n = 1;

    @(negedge clk);
    load_enable = 1;
    serial_parallel = 1;      
    parallel_in = 4'b1010;     
    @(negedge clk);
    load_enable = 0;

    repeat(2) @(negedge clk);

    serial_parallel = 0;       
    load_enable = 1;

    serial_in = 1; @(negedge clk);
    serial_in = 1; @(negedge clk);
    serial_in = 0; @(negedge clk);
    serial_in = 1; @(negedge clk);

    load_enable = 0;

    repeat(4) @(negedge clk);

    $finish;
  end

  initial begin
    $dumpfile("shift_register_tb.vcd");
    $dumpvars(0, shift_register_tb);
    $monitor("T=%0t | rst_n=%0b | mode=%0b | load_en=%0b | serial_in=%0b | parallel_in=%b | parallel_out=%b | serial_out=%b",
              $time, rst_n, serial_parallel, load_enable, serial_in, parallel_in, parallel_out, serial_out);
  end


endmodule
