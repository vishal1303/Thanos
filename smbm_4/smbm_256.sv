`include "/home/dynamo/a/vshriva/Desktop/params/param_256.sv"

module smbm(
    input clk,
    input rst,

    //args for ADD/DELETE
    input [BIT_VEC_SIZE_LOG-1:0] id,
    input [7:0] metric_val [NUM_OF_METRICS-1:0],

    //args for READ
    input [BIT_VEC_SIZE-1:0] in,
    input [NUM_OF_METRICS_LOG-1:0] metricX,
    input [2:0] opcode_in,

    input [2:0] opcode,

    output Entry out_list [BIT_VEC_SIZE-1:0],
    output reg done
);

    IdEntry id_list [BIT_VEC_SIZE-1:0];
    Entry metric_list [NUM_OF_METRICS-1:0][BIT_VEC_SIZE-1:0];

    logic [BIT_VEC_SIZE-1:0] bit_vec [NUM_OF_METRICS:0];
    logic [BIT_VEC_SIZE_LOG-1:0] encode [NUM_OF_METRICS:0];
    logic valid [NUM_OF_METRICS:0];

    genvar I;
    generate
        for (I=0; I<NUM_OF_METRICS+1; I=I+1) begin : pri_encoder
            priority_encode_log#(
                .width(BIT_VEC_SIZE),
                .log_width(BIT_VEC_SIZE_LOG)
            ) i_pri_encoder(bit_vec[I], encode[I], valid[I]);
        end
    endgenerate

    typedef enum {
        RESET,
        ADD1,
        ADD2,
        DELETE1,
        DELETE2,
        READ
    } smbm_state;

    smbm_state curr_state, nxt_state;

    always @(*) begin
        case (curr_state)
            RESET: begin
                done = 0;
                if (opcode == 3'b000) nxt_state = ADD1;
                else if (opcode == 3'b001) nxt_state = DELETE1;
                else if (opcode == 3'b010) nxt_state = READ;
                else nxt_state = RESET;
            end

            ADD1: begin
                for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                    bit_vec[0][i] = (id_list[i].val > id) ? 1 : 0;
                end
                for (int j = 1; j < NUM_OF_METRICS+1; j=j+1) begin
                    for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                        bit_vec[j][i] = (metric_list[j-1][i].val > metric_val[j-1])
                                        ? 1 : 0;
                    end
                end
                nxt_state = ADD2;
            end

            ADD2: begin
                done = 1;
                nxt_state = RESET;
            end

            DELETE1: begin
                for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                    bit_vec[0][i] = (id_list[i].val == id) ? 1 : 0;
                end
                nxt_state = DELETE2;
            end

            DELETE2: begin
                done = 1;
                nxt_state = RESET;
            end

            READ: begin
                done = 1;
                nxt_state = RESET;
            end
        endcase
    end


    always @(posedge clk) begin
        if (rst) begin
            curr_state <= RESET;
        end else begin
            curr_state <= nxt_state;

            if (curr_state == ADD2) begin
                for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                    if (i < encode[0]) begin
                        id_list[i] <= id_list[i];
                    end else if (i == encode[0]) begin
                        id_list[i].val <= id;
                        for (int k = 0; k < NUM_OF_METRICS; k=k+1) begin
                            id_list[i].ptr[k] <= encode[k+1];
                        end
                    end else begin
                        if (i > 0) id_list[i] <= id_list[i-1];
                    end

                    for (int j = 1; j < NUM_OF_METRICS+1; j=j+1) begin
                        if (i < encode[j]) begin
                            metric_list[j-1][i] <= metric_list[j-1][i];
                        end else if (i == encode[j]) begin
                            metric_list[j-1][i].val <= metric_val[j-1];
                            metric_list[j-1][i].ptr <= encode[0];
                        end else begin
                            if (i > 0) metric_list[j-1][i] <= metric_list[j-1][i-1];
                        end
                    end
                end
            end else if (curr_state == DELETE2) begin
                for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                    if (i <= encode[0]) begin
                        id_list[i] <= id_list[i];
                    end else begin
                        if (i > 0) id_list[i-1] <= id_list[i];
                    end

                    for (int j = 1; j < NUM_OF_METRICS+1; j=j+1) begin
                        if (i <= id_list[encode[0]].ptr[j-1]) begin
                            metric_list[j-1][i] <= metric_list[j-1][i];
                        end else begin
                            if (i > 0) metric_list[j-1][i-1] <= metric_list[j-1][i];
                        end
                    end
                end
            end else if (curr_state == READ) begin
                if (opcode_in == 3'b010 | opcode_in == 3'b011) begin
                    for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                        if (in[metric_list[metricX][i].ptr]) begin
                            out_list[i] <= metric_list[metricX][i];
                        end else begin
                            out_list[i] <= '1;
                        end
                    end
                end else if (opcode_in == 3'b101) begin
                    for (int i = 0; i < BIT_VEC_SIZE; i=i+1) begin
                        out_list[i] <= metric_list[metricX][i];
                    end
                end
            end
        end
    end
endmodule

`include "/home/dynamo/a/vshriva/Desktop/params/priority_encoder.sv"
