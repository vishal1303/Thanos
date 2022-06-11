`include "/home/dynamo/a/vshriva/Desktop/params/param_64.sv"

module bfpu
(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in_1,
    input valid_in_1,
    input [BIT_VEC_SIZE-1:0] in_2,
    input valid_in_2,
    input [2:0] opcode,
    input choice,

    output reg [BIT_VEC_SIZE-1:0] out,
    output reg valid_out
);

    always @(posedge clk) begin
        if (rst) begin
            valid_out <= 0;
        end else begin
            if (valid_in_1 & valid_in_2) begin
                case(opcode)
                    3'b000: out <= (choice==0) ? in_1 : in_2;
                    3'b001: out <= in_1 | in_2;
                    3'b010: out <= in_1 & in_2;
                    3'b011: out <= in_1 & ~in_2;
                    3'b100: out <= in_1 ^ in_2;
                endcase
                valid_out <= 1;
            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule
