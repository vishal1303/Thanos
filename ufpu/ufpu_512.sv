`include "/home/dynamo/a/vshriva/Desktop/params/param_512.sv"

module ufpu
(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in,
    input valid_in,
    input [2:0] opcode,
    input [BIT_VEC_SIZE_LOG-1:0] id,
    input [NUM_OF_METRICS_LOG-1:0] metricX,
    input [15:0] val,
    input [2:0] pred_op,

    output reg [BIT_VEC_SIZE-1:0] out,
    output reg valid_out
);

    reg temp_valid;
    reg [2:0] temp_opcode;

    reg [BIT_VEC_SIZE-1:0] temp_bit_vec;

    Entry temp_metricX_list [BIT_VEC_SIZE-1:0];

    reg [BIT_VEC_SIZE_LOG-1:0] last_id;
    reg [15:0] w;

    logic [BIT_VEC_SIZE_LOG-1:0] random;
    logic done;
    LFSR#(.NUM_BITS(BIT_VEC_SIZE_LOG)) lfsr (clk, ~rst, random, done);

    logic [BIT_VEC_SIZE-1:0] pri_encode_bit_vec_1;
    always @(*) begin
        for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
            if (last_id+i < BIT_VEC_SIZE) begin
                pri_encode_bit_vec_1[i] = in[last_id+i];
            end else begin
                pri_encode_bit_vec_1[i] = in[i-(BIT_VEC_SIZE-last_id)];
            end
        end
    end
    logic [BIT_VEC_SIZE_LOG-1:0] encode_1;
    logic valid_1;
    logic [BIT_VEC_SIZE_LOG-1:0] encode_1_reg;
    priority_encode_log#(
        .width(BIT_VEC_SIZE),
        .log_width(BIT_VEC_SIZE_LOG)
    ) pri_encoder_1(pri_encode_bit_vec_1, encode_1, valid_1);

    logic [BIT_VEC_SIZE_LOG-1:0] idx = (opcode == 3'b100) ? random : encode_1_reg;
    logic [BIT_VEC_SIZE-1:0] pri_encode_bit_vec_2;
    always @(*) begin
        if (opcode == 3'b011) begin
            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                pri_encode_bit_vec_2[i] = (temp_metricX_list[i].ptr != '1) ? 1 : 0;
            end
        end else if (opcode == 3'b100 | opcode == 3'b101) begin
            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                if (idx+i < BIT_VEC_SIZE) begin
                    pri_encode_bit_vec_2[i] = temp_bit_vec[idx+i];
                end else begin
                    pri_encode_bit_vec_2[i]
                        = temp_bit_vec[i-(BIT_VEC_SIZE-idx)];
                end
            end
        end else begin
            pri_encode_bit_vec_2 = '0;
        end
    end
    logic [BIT_VEC_SIZE_LOG-1:0] encode_2;
    logic valid_2;
    priority_encode_log#(
        .width(BIT_VEC_SIZE),
        .log_width(BIT_VEC_SIZE_LOG)
    ) pri_encoder_2(pri_encode_bit_vec_2, encode_2, valid_2);

    logic [BIT_VEC_SIZE_LOG-1:0] rr_choice;
    assign rr_choice = (last_id != encode_1_reg) ? encode_1_reg : encode_2;

    logic [BIT_VEC_SIZE-1:0] pred_result;
    always @(*) begin
        pred_result = '0;

        for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
            case (pred_op)
                3'b000: pred_result[i] = (temp_metricX_list[i].val < val);
                3'b001: pred_result[i] = (temp_metricX_list[i].val > val);
                3'b010: pred_result[i] = (temp_metricX_list[i].val <= val);
                3'b011: pred_result[i] = (temp_metricX_list[i].val >= val);
                3'b100: pred_result[i] = (temp_metricX_list[i].val == val);
                3'b101: pred_result[i] = (temp_metricX_list[i].val != val);
            endcase
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            valid_out <= 0;
            temp_valid <= 0;
            last_id <= 0;
            w <= 0;
            encode_1_reg <= 0;
        end else begin
            if (valid_in) begin
                case(opcode)
                    3'b000: begin
                        temp_bit_vec <= in;
                    end
                    3'b001: begin
                        for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                            if (i == id) begin
                                temp_bit_vec[i] <= in[i];
                            end else begin
                                temp_bit_vec[i] <= 0;
                            end
                        end
                    end
                    3'b010: begin
                        //metric list is being read from SMBM
                    end
                    3'b011: begin
                        //metric list is being read from SMBM
                    end
                    3'b100: begin
                        temp_bit_vec <= in;
                    end
                    3'b101: begin
                        //metric list is being read from SMBM
                        encode_1_reg <= encode_1;
                        temp_bit_vec <= in;
                    end
                endcase
                temp_valid <= 1;
                temp_opcode <= opcode;
            end else begin
                temp_valid <= 0;
            end

            if (temp_valid) begin
                case(temp_opcode)
                    3'b000: begin
                        out <= temp_bit_vec;
                    end
                    3'b001: begin
                        out <= temp_bit_vec;
                    end
                    3'b010: begin
                        for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                            out[temp_metricX_list[i].ptr]
                                <= ((temp_metricX_list[i].ptr != '1)
                                    & (pred_result[i]))
                                ? 1 : 0;
                        end
                    end
                    3'b011: begin
                        for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                            if (i == encode_2) begin
                                out[i] <= 1;
                            end else begin
                                out[i] <= 0;
                            end
                        end
                    end
                    3'b100: begin
                        if (temp_bit_vec[random] == 1) begin
                            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                                if (i == random) begin
                                    out[i] <= 1;
                                end else begin
                                    out[i] <= 0;
                                end
                            end
                        end else begin
                            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                                if (i == encode_2) begin
                                    out[i] <= 1;
                                end else begin
                                    out[i] <= 0;
                                end
                            end
                        end
                    end
                    3'b101: begin
                        if (temp_bit_vec[last_id] == 1
                        & w <= temp_metricX_list[last_id].val) begin
                            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                                if (i == last_id) begin
                                    out[i] <= 1;
                                end else begin
                                    out[i] <= 0;
                                end
                            end
                            w <= w + 1;
                        end else begin
                            for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                                if (i == rr_choice) begin
                                    out[i] <= 1;
                                end else begin
                                    out[i] <= 0;
                                end
                            end
                            last_id <= rr_choice;
                            w <= 1;
                        end
                    end
                endcase
                valid_out <= 1;
            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule

`include "/home/dynamo/a/vshriva/Desktop/params/priority_encoder.sv"
`include "/home/dynamo/a/vshriva/Desktop/params/lfsr.sv"
