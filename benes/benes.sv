`include "/home/dynamo/a/vshriva/Desktop/params/param_128.sv"


module benes_8(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in_1,
    input [BIT_VEC_SIZE-1:0] in_2,
    input [BIT_VEC_SIZE-1:0] in_3,
    input [BIT_VEC_SIZE-1:0] in_4,
    input [BIT_VEC_SIZE-1:0] in_5,
    input [BIT_VEC_SIZE-1:0] in_6,
    input [BIT_VEC_SIZE-1:0] in_7,
    input [BIT_VEC_SIZE-1:0] in_8,

    input choice_1,
    input choice_2,
    input choice_3,
    input choice_4,
    input choice_5,
    input choice_6,
    input choice_7,
    input choice_8,
    input choice_9,
    input choice_10,
    input choice_11,
    input choice_12,
    input choice_13,
    input choice_14,
    input choice_15,
    input choice_16,
    input choice_17,
    input choice_18,
    input choice_19,
    input choice_20,
    input choice_21,
    input choice_22,
    input choice_23,
    input choice_24,
    input choice_25,
    input choice_26,
    input choice_27,
    input choice_28,
    input choice_29,
    input choice_30,
    input choice_31,
    input choice_32,
    input choice_33,
    input choice_34,
    input choice_35,
    input choice_36,
    input choice_37,
    input choice_38,
    input choice_39,
    input choice_40,

    output reg [BIT_VEC_SIZE-1:0] out_1,
    output reg [BIT_VEC_SIZE-1:0] out_2,
    output reg [BIT_VEC_SIZE-1:0] out_3,
    output reg [BIT_VEC_SIZE-1:0] out_4,
    output reg [BIT_VEC_SIZE-1:0] out_5,
    output reg [BIT_VEC_SIZE-1:0] out_6,
    output reg [BIT_VEC_SIZE-1:0] out_7,
    output reg [BIT_VEC_SIZE-1:0] out_8
);

    wire [BIT_VEC_SIZE-1:0] wire1;
    wire [BIT_VEC_SIZE-1:0] wire2;
    wire [BIT_VEC_SIZE-1:0] wire3;
    wire [BIT_VEC_SIZE-1:0] wire4;
    wire [BIT_VEC_SIZE-1:0] wire5;
    wire [BIT_VEC_SIZE-1:0] wire6;
    wire [BIT_VEC_SIZE-1:0] wire7;
    wire [BIT_VEC_SIZE-1:0] wire8;
    wire [BIT_VEC_SIZE-1:0] wire9;
    wire [BIT_VEC_SIZE-1:0] wire10;
    wire [BIT_VEC_SIZE-1:0] wire11;
    wire [BIT_VEC_SIZE-1:0] wire12;
    wire [BIT_VEC_SIZE-1:0] wire13;
    wire [BIT_VEC_SIZE-1:0] wire14;
    wire [BIT_VEC_SIZE-1:0] wire15;
    wire [BIT_VEC_SIZE-1:0] wire16;

    benes_2 b1(
        .clk(clk),
        .rst(rst),
        .in_1(in_1),
        .in_2(in_2),
        .choice_1(choice_1),
        .choice_2(choice_2),
        .out_1(wire1),
        .out_2(wire2)
    );
    benes_2 b2(
        .clk(clk),
        .rst(rst),
        .in_1(in_3),
        .in_2(in_4),
        .choice_1(choice_3),
        .choice_2(choice_4),
        .out_1(wire3),
        .out_2(wire4)
    );
    benes_2 b3(
        .clk(clk),
        .rst(rst),
        .in_1(in_5),
        .in_2(in_6),
        .choice_1(choice_5),
        .choice_2(choice_6),
        .out_1(wire5),
        .out_2(wire6)
    );
    benes_2 b4(
        .clk(clk),
        .rst(rst),
        .in_1(in_7),
        .in_2(in_8),
        .choice_1(choice_7),
        .choice_2(choice_8),
        .out_1(wire7),
        .out_2(wire8)
    );
    benes_4 b5(
        .clk(clk),
        .rst(rst),

        .in_1(wire1),
        .in_2(wire3),
        .in_3(wire5),
        .in_4(wire7),

        .choice_1(choice_9),
        .choice_2(choice_10),
        .choice_3(choice_11),
        .choice_4(choice_12),
        .choice_5(choice_13),
        .choice_6(choice_14),
        .choice_7(choice_15),
        .choice_8(choice_16),
        .choice_9(choice_17),
        .choice_10(choice_18),
        .choice_11(choice_19),
        .choice_12(choice_20),

        .out_1(wire9),
        .out_2(wire10),
        .out_3(wire11),
        .out_4(wire12)
    );
    benes_4 b6(
        .clk(clk),
        .rst(rst),

        .in_1(wire2),
        .in_2(wire4),
        .in_3(wire6),
        .in_4(wire8),

        .choice_1(choice_21),
        .choice_2(choice_22),
        .choice_3(choice_23),
        .choice_4(choice_24),
        .choice_5(choice_25),
        .choice_6(choice_26),
        .choice_7(choice_27),
        .choice_8(choice_28),
        .choice_9(choice_29),
        .choice_10(choice_30),
        .choice_11(choice_31),
        .choice_12(choice_32),

        .out_1(wire13),
        .out_2(wire14),
        .out_3(wire15),
        .out_4(wire16)
    );
    benes_2 b7(
        .clk(clk),
        .rst(rst),
        .in_1(wire9),
        .in_2(wire13),
        .choice_1(choice_33),
        .choice_2(choice_34),
        .out_1(out_1),
        .out_2(out_2)
    );
    benes_2 b8(
        .clk(clk),
        .rst(rst),
        .in_1(wire10),
        .in_2(wire14),
        .choice_1(choice_35),
        .choice_2(choice_36),
        .out_1(out_3),
        .out_2(out_4)
    );
    benes_2 b9(
        .clk(clk),
        .rst(rst),
        .in_1(wire11),
        .in_2(wire15),
        .choice_1(choice_37),
        .choice_2(choice_38),
        .out_1(out_5),
        .out_2(out_6)
    );
    benes_2 b10(
        .clk(clk),
        .rst(rst),
        .in_1(wire12),
        .in_2(wire16),
        .choice_1(choice_39),
        .choice_2(choice_40),
        .out_1(out_7),
        .out_2(out_8)
    );
endmodule


module benes_4(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in_1,
    input [BIT_VEC_SIZE-1:0] in_2,
    input [BIT_VEC_SIZE-1:0] in_3,
    input [BIT_VEC_SIZE-1:0] in_4,

    input choice_1,
    input choice_2,
    input choice_3,
    input choice_4,
    input choice_5,
    input choice_6,
    input choice_7,
    input choice_8,
    input choice_9,
    input choice_10,
    input choice_11,
    input choice_12,

    output reg [BIT_VEC_SIZE-1:0] out_1,
    output reg [BIT_VEC_SIZE-1:0] out_2,
    output reg [BIT_VEC_SIZE-1:0] out_3,
    output reg [BIT_VEC_SIZE-1:0] out_4
);

    wire [BIT_VEC_SIZE-1:0] wire1;
    wire [BIT_VEC_SIZE-1:0] wire2;
    wire [BIT_VEC_SIZE-1:0] wire3;
    wire [BIT_VEC_SIZE-1:0] wire4;
    wire [BIT_VEC_SIZE-1:0] wire5;
    wire [BIT_VEC_SIZE-1:0] wire6;
    wire [BIT_VEC_SIZE-1:0] wire7;
    wire [BIT_VEC_SIZE-1:0] wire8;

    benes_2 b1(
        .clk(clk),
        .rst(rst),
        .in_1(in_1),
        .in_2(in_2),
        .choice_1(choice_1),
        .choice_2(choice_2),
        .out_1(wire1),
        .out_2(wire2)
    );

    benes_2 b2(
        .clk(clk),
        .rst(rst),
        .in_1(in_3),
        .in_2(in_4),
        .choice_1(choice_3),
        .choice_2(choice_4),
        .out_1(wire3),
        .out_2(wire4)
    );

    benes_2 b3(
        .clk(clk),
        .rst(rst),
        .in_1(wire1),
        .in_2(wire3),
        .choice_1(choice_5),
        .choice_2(choice_6),
        .out_1(wire5),
        .out_2(wire6)
    );

    benes_2 b4(
        .clk(clk),
        .rst(rst),
        .in_1(wire2),
        .in_2(wire4),
        .choice_1(choice_7),
        .choice_2(choice_8),
        .out_1(wire7),
        .out_2(wire8)
    );

    benes_2 b5(
        .clk(clk),
        .rst(rst),
        .in_1(wire5),
        .in_2(wire7),
        .choice_1(choice_9),
        .choice_2(choice_10),
        .out_1(out_1),
        .out_2(out_2)
    );

    benes_2 b6(
        .clk(clk),
        .rst(rst),
        .in_1(wire6),
        .in_2(wire8),
        .choice_1(choice_11),
        .choice_2(choice_12),
        .out_1(out_3),
        .out_2(out_4)
    );
endmodule


module benes_2(
    input clk,
    input rst,

    input [BIT_VEC_SIZE-1:0] in_1,
    input [BIT_VEC_SIZE-1:0] in_2,

    input choice_1,
    input choice_2,

    output reg [BIT_VEC_SIZE-1:0] out_1,
    output reg [BIT_VEC_SIZE-1:0] out_2
);

    always @(posedge clk) begin
        if (~rst) begin
            out_1 <= (choice_1==0) ? in_1 : in_2;
            out_2 <= (choice_2==0) ? in_1 : in_2;
        end
    end
endmodule

