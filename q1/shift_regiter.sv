module shift_register #(parameter N=4)
                      (input logic clk,
                       input logic rst_n,
                       input logic serial_parallel,
                       input logic load_enable,
                       input logic serial_in,
                       input logic [N-1:0] parallel_in,
                       output logic [N-1:0] parallel_out,
                       output logic serial_out);

//complete here
    logic [N-1:0] r ;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r           <= '0;
            serial_out  <= 1'b0;
            parallel_out<= '0;
        end else if (load_enable) begin
            if (serial_parallel == 1'b0) begin
                serial_out  <= r[N-1];
                r           <= {r[N-2:0], serial_in};
                parallel_out<= '0;      
            end else begin
                r           <= parallel_in;
                parallel_out<= parallel_in;
                serial_out  <= 1'b0;    
            end
        end
    end

endmodule



