`include "/home/dynamo/a/vshriva/Desktop/params/param_128.sv"

parameter INPUTS = 2;
parameter STAGES = 2;


module fp(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in [INPUTS-1:0],
    input valid_in [INPUTS-1:0],

    input choice [40][STAGES-1:0],

    input [2:0] kufpu1_opcode [INPUTS/2-1:0][STAGES-1:0],
    input [BIT_VEC_SIZE_LOG-1:0] kufpu1_id [INPUTS/2-1:0][STAGES-1:0],
    input [NUM_OF_METRICS_LOG-1:0] kufpu1_metricX [INPUTS/2-1:0][STAGES-1:0],
    input [15:0] kufpu1_val [INPUTS/2-1:0][STAGES-1:0],
    input [2:0] kufpu1_pred_op [INPUTS/2-1:0][STAGES-1:0],

    input [2:0] kufpu2_opcode [INPUTS/2-1:0][STAGES-1:0],
    input [BIT_VEC_SIZE_LOG-1:0] kufpu2_id [INPUTS/2-1:0][STAGES-1:0],
    input [NUM_OF_METRICS_LOG-1:0] kufpu2_metricX [INPUTS/2-1:0][STAGES-1:0],
    input [15:0] kufpu2_val [INPUTS/2-1:0][STAGES-1:0],
    input [2:0] kufpu2_pred_op [INPUTS/2-1:0][STAGES-1:0],

    input [2:0] bfpu1_opcode [INPUTS/2-1:0][STAGES-1:0],
    input bfpu1_choice [INPUTS/2-1:0][STAGES-1:0],

    input [2:0] bfpu2_opcode [INPUTS/2-1:0][STAGES-1:0],
    input bfpu2_choice [INPUTS/2-1:0][STAGES-1:0],

    output reg [BIT_VEC_SIZE-1:0] out [INPUTS-1:0],
    output reg valid_out [INPUTS-1:0]
);

    wire [BIT_VEC_SIZE-1:0] in_temp [INPUTS-1:0][STAGES-1:0];

    wire [BIT_VEC_SIZE-1:0] temp [INPUTS-1:0][STAGES-2:0];

    genvar i;
    generate
        for (i=0; i<STAGES; i=i+1) begin : fp_stage
            if (INPUTS == 2) begin
                benes_2 i_benes_2(
                    .clk(clk),
                    .rst(rst),

                    .in_1((i==0) ? in[0] : temp[0][i]),
                    .in_2((i==0) ? in[1] : temp[1][i]),

                    .choice_1(choice[0][i]),
                    .choice_2(choice[1][i]),

                    .out_1(in_temp[0][i]),
                    .out_2(in_temp[1][i])
                );
                Cell i_cell(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[0][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[0][i]),
                    .kufpu1_id(kufpu1_id[0][i]),
                    .kufpu1_metricX(kufpu1_metricX[0][i]),
                    .kufpu1_val(kufpu1_val[0][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[0][i]),

                    .kufpu2_in(in_temp[1][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[0][i]),
                    .kufpu2_id(kufpu2_id[0][i]),
                    .kufpu2_metricX(kufpu2_metricX[0][i]),
                    .kufpu2_val(kufpu2_val[0][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[0][i]),

                    .bfpu1_opcode(bfpu1_opcode[0][i]),
                    .bfpu1_choice(bfpu1_choice[0][i]),

                    .bfpu2_opcode(bfpu2_opcode[0][i]),
                    .bfpu2_choice(bfpu2_choice[0][i]),

                    .bfpu1_out((i==STAGES-1) ? out[0] : temp[0][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[1] : temp[1][i]),
                    .bfpu2_valid_out()
                );
            end
            if (INPUTS == 4) begin
                benes_4 i_benes_4(
                    .clk(clk),
                    .rst(rst),

                    .in_1((i==0) ? in[0] : temp[0][i]),
                    .in_2((i==0) ? in[1] : temp[1][i]),
                    .in_3((i==0) ? in[2] : temp[2][i]),
                    .in_4((i==0) ? in[3] : temp[3][i]),

                    .choice_1(choice[0][i]),
                    .choice_2(choice[1][i]),
                    .choice_3(choice[2][i]),
                    .choice_4(choice[3][i]),
                    .choice_5(choice[4][i]),
                    .choice_6(choice[5][i]),
                    .choice_7(choice[6][i]),
                    .choice_8(choice[7][i]),
                    .choice_9(choice[8][i]),
                    .choice_10(choice[9][i]),
                    .choice_11(choice[10][i]),
                    .choice_12(choice[11][i]),

                    .out_1(in_temp[0][i]),
                    .out_2(in_temp[1][i]),
                    .out_3(in_temp[2][i]),
                    .out_4(in_temp[3][i])
                );
                Cell i_cell_1(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[0][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[0][i]),
                    .kufpu1_id(kufpu1_id[0][i]),
                    .kufpu1_metricX(kufpu1_metricX[0][i]),
                    .kufpu1_val(kufpu1_val[0][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[0][i]),

                    .kufpu2_in(in_temp[1][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[0][i]),
                    .kufpu2_id(kufpu2_id[0][i]),
                    .kufpu2_metricX(kufpu2_metricX[0][i]),
                    .kufpu2_val(kufpu2_val[0][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[0][i]),

                    .bfpu1_opcode(bfpu1_opcode[0][i]),
                    .bfpu1_choice(bfpu1_choice[0][i]),

                    .bfpu2_opcode(bfpu2_opcode[0][i]),
                    .bfpu2_choice(bfpu2_choice[0][i]),

                    .bfpu1_out((i==STAGES-1) ? out[0] : temp[0][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[1] : temp[1][i]),
                    .bfpu2_valid_out()
                );
                Cell i_cell_2(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[2][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[1][i]),
                    .kufpu1_id(kufpu1_id[1][i]),
                    .kufpu1_metricX(kufpu1_metricX[1][i]),
                    .kufpu1_val(kufpu1_val[1][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[1][i]),

                    .kufpu2_in(in_temp[3][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[1][i]),
                    .kufpu2_id(kufpu2_id[1][i]),
                    .kufpu2_metricX(kufpu2_metricX[1][i]),
                    .kufpu2_val(kufpu2_val[1][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[1][i]),

                    .bfpu1_opcode(bfpu1_opcode[1][i]),
                    .bfpu1_choice(bfpu1_choice[1][i]),

                    .bfpu2_opcode(bfpu2_opcode[1][i]),
                    .bfpu2_choice(bfpu2_choice[1][i]),

                    .bfpu1_out((i==STAGES-1) ? out[2] : temp[2][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[3] : temp[3][i]),
                    .bfpu2_valid_out()
                );
            end
            if (INPUTS == 8) begin
                benes_8 i_benes_8(
                    .clk(clk),
                    .rst(rst),

                    .in_1((i==0) ? in[0] : temp[0][i]),
                    .in_2((i==0) ? in[1] : temp[1][i]),
                    .in_3((i==0) ? in[2] : temp[2][i]),
                    .in_4((i==0) ? in[3] : temp[3][i]),
                    .in_5((i==0) ? in[4] : temp[4][i]),
                    .in_6((i==0) ? in[5] : temp[5][i]),
                    .in_7((i==0) ? in[6] : temp[6][i]),
                    .in_8((i==0) ? in[7] : temp[7][i]),

                    .choice_1(choice[0][i]),
                    .choice_2(choice[1][i]),
                    .choice_3(choice[2][i]),
                    .choice_4(choice[3][i]),
                    .choice_5(choice[4][i]),
                    .choice_6(choice[5][i]),
                    .choice_7(choice[6][i]),
                    .choice_8(choice[7][i]),
                    .choice_9(choice[8][i]),
                    .choice_10(choice[9][i]),
                    .choice_11(choice[10][i]),
                    .choice_12(choice[11][i]),
                    .choice_13(choice[12][i]),
                    .choice_14(choice[13][i]),
                    .choice_15(choice[14][i]),
                    .choice_16(choice[15][i]),
                    .choice_17(choice[16][i]),
                    .choice_18(choice[17][i]),
                    .choice_19(choice[18][i]),
                    .choice_20(choice[19][i]),
                    .choice_21(choice[20][i]),
                    .choice_22(choice[21][i]),
                    .choice_23(choice[22][i]),
                    .choice_24(choice[23][i]),
                    .choice_25(choice[24][i]),
                    .choice_26(choice[25][i]),
                    .choice_27(choice[26][i]),
                    .choice_28(choice[27][i]),
                    .choice_29(choice[28][i]),
                    .choice_30(choice[29][i]),
                    .choice_31(choice[30][i]),
                    .choice_32(choice[31][i]),
                    .choice_33(choice[32][i]),
                    .choice_34(choice[33][i]),
                    .choice_35(choice[34][i]),
                    .choice_36(choice[35][i]),
                    .choice_37(choice[36][i]),
                    .choice_38(choice[37][i]),
                    .choice_39(choice[38][i]),
                    .choice_40(choice[39][i]),

                    .out_1(in_temp[0][i]),
                    .out_2(in_temp[1][i]),
                    .out_3(in_temp[2][i]),
                    .out_4(in_temp[3][i]),
                    .out_5(in_temp[4][i]),
                    .out_6(in_temp[5][i]),
                    .out_7(in_temp[6][i]),
                    .out_8(in_temp[7][i])
                );
                Cell i_cell_1(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[0][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[0][i]),
                    .kufpu1_id(kufpu1_id[0][i]),
                    .kufpu1_metricX(kufpu1_metricX[0][i]),
                    .kufpu1_val(kufpu1_val[0][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[0][i]),

                    .kufpu2_in(in_temp[1][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[0][i]),
                    .kufpu2_id(kufpu2_id[0][i]),
                    .kufpu2_metricX(kufpu2_metricX[0][i]),
                    .kufpu2_val(kufpu2_val[0][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[0][i]),

                    .bfpu1_opcode(bfpu1_opcode[0][i]),
                    .bfpu1_choice(bfpu1_choice[0][i]),

                    .bfpu2_opcode(bfpu2_opcode[0][i]),
                    .bfpu2_choice(bfpu2_choice[0][i]),

                    .bfpu1_out((i==STAGES-1) ? out[0] : temp[0][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[1] : temp[1][i]),
                    .bfpu2_valid_out()
                );
                Cell i_cell_2(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[2][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[1][i]),
                    .kufpu1_id(kufpu1_id[1][i]),
                    .kufpu1_metricX(kufpu1_metricX[1][i]),
                    .kufpu1_val(kufpu1_val[1][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[1][i]),

                    .kufpu2_in(in_temp[3][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[1][i]),
                    .kufpu2_id(kufpu2_id[1][i]),
                    .kufpu2_metricX(kufpu2_metricX[1][i]),
                    .kufpu2_val(kufpu2_val[1][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[1][i]),

                    .bfpu1_opcode(bfpu1_opcode[1][i]),
                    .bfpu1_choice(bfpu1_choice[1][i]),

                    .bfpu2_opcode(bfpu2_opcode[1][i]),
                    .bfpu2_choice(bfpu2_choice[1][i]),

                    .bfpu1_out((i==STAGES-1) ? out[2] : temp[2][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[3] : temp[3][i]),
                    .bfpu2_valid_out()
                );
                Cell i_cell_3(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[4][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[2][i]),
                    .kufpu1_id(kufpu1_id[2][i]),
                    .kufpu1_metricX(kufpu1_metricX[2][i]),
                    .kufpu1_val(kufpu1_val[2][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[2][i]),

                    .kufpu2_in(in_temp[5][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[2][i]),
                    .kufpu2_id(kufpu2_id[2][i]),
                    .kufpu2_metricX(kufpu2_metricX[2][i]),
                    .kufpu2_val(kufpu2_val[2][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[2][i]),

                    .bfpu1_opcode(bfpu1_opcode[2][i]),
                    .bfpu1_choice(bfpu1_choice[2][i]),

                    .bfpu2_opcode(bfpu2_opcode[2][i]),
                    .bfpu2_choice(bfpu2_choice[2][i]),

                    .bfpu1_out((i==STAGES-1) ? out[4] : temp[4][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[5] : temp[5][i]),
                    .bfpu2_valid_out()
                );
                Cell i_cell_4(
                    .clk(clk),
                    .rst(rst),

                    .kufpu1_in(in_temp[6][i]),
                    .kufpu1_valid_in(),
                    .kufpu1_opcode(kufpu1_opcode[3][i]),
                    .kufpu1_id(kufpu1_id[3][i]),
                    .kufpu1_metricX(kufpu1_metricX[3][i]),
                    .kufpu1_val(kufpu1_val[3][i]),
                    .kufpu1_pred_op(kufpu1_pred_op[3][i]),

                    .kufpu2_in(in_temp[7][i]),
                    .kufpu2_valid_in(),
                    .kufpu2_opcode(kufpu2_opcode[3][i]),
                    .kufpu2_id(kufpu2_id[3][i]),
                    .kufpu2_metricX(kufpu2_metricX[3][i]),
                    .kufpu2_val(kufpu2_val[3][i]),
                    .kufpu2_pred_op(kufpu2_pred_op[3][i]),

                    .bfpu1_opcode(bfpu1_opcode[3][i]),
                    .bfpu1_choice(bfpu1_choice[3][i]),

                    .bfpu2_opcode(bfpu2_opcode[3][i]),
                    .bfpu2_choice(bfpu2_choice[3][i]),

                    .bfpu1_out((i==STAGES-1) ? out[6] : temp[6][i]),
                    .bfpu1_valid_out(),

                    .bfpu2_out((i==STAGES-1) ? out[7] : temp[7][i]),
                    .bfpu2_valid_out()
                );
            end
        end
    endgenerate

endmodule

`include "/home/dynamo/a/vshriva/Desktop/benes/benes.sv"
`include "/home/dynamo/a/vshriva/Desktop/Cell/Cell_4.sv"
