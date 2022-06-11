`include "/home/dynamo/a/vshriva/Desktop/params/param_128.sv"

parameter K = 2;

module Cell
(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] kufpu1_in,
    input kufpu1_valid_in,
    input [2:0] kufpu1_opcode,
    input [BIT_VEC_SIZE_LOG-1:0] kufpu1_id,
    input [NUM_OF_METRICS_LOG-1:0] kufpu1_metricX,
    input [15:0] kufpu1_val,
    input [2:0] kufpu1_pred_op,

    input [BIT_VEC_SIZE-1:0] kufpu2_in,
    input kufpu2_valid_in,
    input [2:0] kufpu2_opcode,
    input [BIT_VEC_SIZE_LOG-1:0] kufpu2_id,
    input [NUM_OF_METRICS_LOG-1:0] kufpu2_metricX,
    input [15:0] kufpu2_val,
    input [2:0] kufpu2_pred_op,

    input [2:0] bfpu1_opcode,
    input bfpu1_choice,

    input [2:0] bfpu2_opcode,
    input bfpu2_choice,

    output reg [BIT_VEC_SIZE-1:0] bfpu1_out,
    output reg bfpu1_valid_out,

    output reg [BIT_VEC_SIZE-1:0] bfpu2_out,
    output reg bfpu2_valid_out
);

    wire [BIT_VEC_SIZE-1:0] kufpu1_out;
    wire kufpu1_valid_out;
    wire [BIT_VEC_SIZE-1:0] kufpu2_out;
    wire kufpu2_valid_out;

    kufpu kufpu1(
        .clk(clk),
        .rst(rst),

        .in(kufpu1_in),
        .valid_in(kufpu1_valid_in),
        .opcode(kufpu1_opcode),
        .id(kufpu1_id),
        .metricX(kufpu1_metricX),
        .val(kufpu1_val),
        .pred_op(kufpu1_pred_op),

        .out(kufpu1_out),
        .valid_out(kufpu1_valid_out)
    );

    kufpu kufpu2(
        .clk(clk),
        .rst(rst),

        .in(kufpu2_in),
        .valid_in(kufpu2_valid_in),
        .opcode(kufpu2_opcode),
        .id(kufpu2_id),
        .metricX(kufpu2_metricX),
        .val(kufpu2_val),
        .pred_op(kufpu2_pred_op),

        .out(kufpu2_out),
        .valid_out(kufpu2_valid_out)
    );

    bfpu bfpu1(
        .clk(clk),
        .rst(rst),

        .in_1(kufpu1_out),
        .valid_in_1(kufpu1_valid_out),
        .in_2(kufpu2_out),
        .valid_in_2(kufpu2_valid_out),
        .opcode(bfpu1_opcode),
        .choice(bfpu1_choice),

        .out(bfpu1_out),
        .valid_out(bfpu1_valid_out)
    );

    bfpu bfpu2(
        .clk(clk),
        .rst(rst),

        .in_1(kufpu1_out),
        .valid_in_1(kufpu1_valid_out),
        .in_2(kufpu2_out),
        .valid_in_2(kufpu2_valid_out),
        .opcode(bfpu2_opcode),
        .choice(bfpu2_choice),

        .out(bfpu2_out),
        .valid_out(bfpu2_valid_out)
    );
endmodule

module kufpu
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

    wire [BIT_VEC_SIZE-1:0] temp_in [2*K:0];
    wire temp_valid_in [2*K:0];
    wire [2:0] temp_opcode [2*K:0];
    wire [BIT_VEC_SIZE_LOG-1:0] temp_id [2*K:0];
    wire [NUM_OF_METRICS_LOG-1:0] temp_metricX [2*K:0];
    wire [15:0] temp_val [2*K:0];
    wire [2:0] temp_pred_op [2*K:0];

    wire [BIT_VEC_SIZE-1:0] temp_ufpu_out [K-1:0];
    wire temp_ufpu_valid_out [K-1:0];

    wire [BIT_VEC_SIZE-1:0] temp_out [2*K:0];
    wire temp_valid_out [2*K:0];

    genvar i;
    generate
        for (i=0; i<K; i=i+1) begin : kufpu_stage
            ufpu i_ufpu(
                .clk(clk),
                .rst(rst),

                .in((i==0) ? in : temp_in[2*i]),
                .valid_in((i==0) ? valid_in : temp_valid_in[2*i]),
                .opcode((i==0) ? opcode : temp_opcode[2*i]),
                .id((i==0) ? id : temp_id[2*i]),
                .metricX((i==0) ? metricX : temp_metricX[2*i]),
                .val((i==0) ? val : temp_val[2*i]),
                .pred_op((i==0) ? pred_op : temp_pred_op[2*i]),

                .out(temp_ufpu_out[i]),
                .valid_out(temp_ufpu_valid_out[i])
            );

            delay i_delay(
                .clk(clk),
                .rst(rst),

                .in((i==0) ? in : temp_in[2*i]),
                .valid_in((i==0) ? valid_in : temp_valid_in[2*i]),
                .opcode_in((i==0) ? opcode : temp_opcode[2*i]),
                .id_in((i==0) ? id : temp_id[2*i]),
                .metricX_in((i==0) ? metricX : temp_metricX[2*i]),
                .val_in((i==0) ? val : temp_val[2*i]),
                .pred_op_in((i==0) ? pred_op : temp_pred_op[2*i]),
                .f_in('0),
                .f_in_valid('1),

                .out(temp_in[2*i+1]),
                .valid_out(temp_valid_in[2*i+1]),
                .opcode_out(temp_opcode[2*i+1]),
                .id_out(temp_id[2*i+1]),
                .metricX_out(temp_metricX[2*i+1]),
                .val_out(temp_val[2*i+1]),
                .pred_op_out(temp_pred_op[2*i+1]),
                .f_out(temp_out[2*i+1]),
                .f_out_valid(temp_valid_out[2*i+1])
            );

            generator#(.STAGE_NUM(i+1)) i_generator(
                .clk(clk),
                .rst(rst),

                .in(temp_in[2*i+1]),
                .valid_in(temp_valid_in[2*i+1]),
                .opcode_in(temp_opcode[2*i+1]),
                .id_in(temp_id[2*i+1]),
                .metricX_in(temp_metricX[2*i+1]),
                .val_in(temp_val[2*i+1]),
                .pred_op_in(temp_pred_op[2*i+1]),

                .ufpu_output_in(temp_ufpu_out[i]),

                .f_in(temp_out[2*i+1]),
                .f_in_valid(temp_valid_out[2*i+1]),

                .out(temp_in[2*i+2]),
                .valid_out(temp_valid_in[2*i+2]),
                .opcode_out(temp_opcode[2*i+2]),
                .id_out(temp_id[2*i+2]),
                .metricX_out(temp_metricX[2*i+2]),
                .val_out(temp_val[2*i+2]),
                .pred_op_out(temp_pred_op[2*i+2]),

                .f_out((i==K-1) ? out : temp_out[2*i+2]),
                .f_out_valid((i==K-1) ? valid_out : temp_valid_out[2*i+2])
            );
        end
    endgenerate

endmodule


module delay
(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in,
    input valid_in,
    input [2:0] opcode_in,
    input [BIT_VEC_SIZE_LOG-1:0] id_in,
    input [NUM_OF_METRICS_LOG-1:0] metricX_in,
    input [15:0] val_in,
    input [2:0] pred_op_in,
    input [BIT_VEC_SIZE-1:0] f_in,
    input f_in_valid,

    output reg [BIT_VEC_SIZE-1:0] out,
    output reg valid_out,
    output reg [2:0] opcode_out,
    output reg [BIT_VEC_SIZE_LOG-1:0] id_out,
    output reg [NUM_OF_METRICS_LOG-1:0] metricX_out,
    output reg [15:0] val_out,
    output reg [2:0] pred_op_out,
    output reg [BIT_VEC_SIZE-1:0] f_out,
    output reg f_out_valid
);

    reg [BIT_VEC_SIZE-1:0] temp_out;
    reg temp_valid_out;
    reg [2:0] temp_opcode_out;
    reg [BIT_VEC_SIZE_LOG-1:0] temp_id_out;
    reg [NUM_OF_METRICS_LOG-1:0] temp_metricX_out;
    reg [15:0] temp_val_out;
    reg [2:0] temp_pred_op_out;
    reg [BIT_VEC_SIZE-1:0] temp_f_out;
    reg temp_f_valid_out;

    always @(posedge clk) begin
        if (rst) begin
            out <= '0;
            valid_out <= 0;
            opcode_out <= '0;
            id_out <= '0;
            metricX_out <= '0;
            val_out <= '0;
            pred_op_out <= '0;
            f_out <= '0;
            f_out_valid <= 0;
            temp_out <= '0;
            temp_valid_out <= 0;
            temp_opcode_out <= '0;
            temp_id_out <= '0;
            temp_metricX_out <= '0;
            temp_val_out <= '0;
            temp_pred_op_out <= '0;
            temp_f_out <= '0;
            temp_f_valid_out <= 0;
        end else begin
            temp_out <= in;
            temp_valid_out <= valid_in;
            temp_opcode_out <= opcode_in;
            temp_id_out <= id_in;
            temp_metricX_out <= metricX_in;
            temp_val_out <= val_in;
            temp_pred_op_out <= pred_op_in;
            temp_f_out <= f_in;
            temp_f_valid_out <= f_in_valid;

            out <= temp_out;
            valid_out <= temp_valid_out;
            opcode_out <= temp_opcode_out;
            id_out <= temp_id_out;
            metricX_out <= temp_metricX_out;
            val_out <= temp_val_out;
            pred_op_out <= temp_pred_op_out;
            f_out <= temp_f_out;
            f_out_valid <= temp_f_valid_out;
        end
    end
endmodule


module generator#
(
    parameter STAGE_NUM = 0
)
(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in,
    input valid_in,
    input [2:0] opcode_in,
    input [BIT_VEC_SIZE_LOG-1:0] id_in,
    input [NUM_OF_METRICS_LOG-1:0] metricX_in,
    input [15:0] val_in,
    input [2:0] pred_op_in,

    input [BIT_VEC_SIZE-1:0] ufpu_output_in,

    input [BIT_VEC_SIZE-1:0] f_in,
    input f_in_valid,

    output reg [BIT_VEC_SIZE-1:0] out,
    output reg valid_out,
    output reg [2:0] opcode_out,
    output reg [BIT_VEC_SIZE_LOG-1:0] id_out,
    output reg [NUM_OF_METRICS_LOG-1:0] metricX_out,
    output reg [15:0] val_out,
    output reg [2:0] pred_op_out,

    output reg [BIT_VEC_SIZE-1:0] f_out,
    output reg f_out_valid
);

    always @(posedge clk) begin
        if (rst) begin
            out <= '0;
            valid_out <= 0;
            opcode_out <= '0;
            id_out <= '0;
            metricX_out <= '0;
            val_out <= '0;
            pred_op_out <= '0;
            f_out <= '0;
            f_out_valid <= 0;
        end else begin
            valid_out <= valid_in;
            id_out <= id_in;
            metricX_out <= metricX_in;
            val_out <= val_in;
            pred_op_out <= pred_op_in;

            opcode_out <= (STAGE_NUM < K) ? opcode_in : '0;

            out <= in & ~ufpu_output_in;

            f_out <= (opcode_in != '0) ? (f_in | ufpu_output_in) : f_in;
            f_out_valid <= f_in_valid;
        end
    end
endmodule

`include "/home/dynamo/a/vshriva/Desktop/ufpu/ufpu_128.sv"
`include "/home/dynamo/a/vshriva/Desktop/bfpu/bfpu_128.sv"


