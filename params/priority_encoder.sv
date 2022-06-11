/*
* This module is adopted from https://github.com/programmable-scheduling/pifo-hardware/blob/master/src/rtl/design/pifo.v
*/
module priority_encode_log #
(
    parameter width = 32,
    parameter log_width = 5
)
(
  decode,
  encode_reg,valid_reg
);
    localparam pot_width = 1 << log_width;

    input  [width-1:0]     decode;
    output [log_width-1:0] encode_reg;
    output                 valid_reg;

    wire [pot_width-1:0] pot_decode = {pot_width{1'b0}} | decode;

    reg [pot_width-1:0] part_idx [0:log_width-1];

    always_comb begin
      part_idx[0] = 0;
      for(integer i=0; i<pot_width; i=i+2) begin
        part_idx[0][i] = pot_decode[i] || pot_decode[i+1];
        part_idx[0][i+1] = !pot_decode[i];
      end
    end

    genvar lvar;
    generate for(lvar=1; lvar<log_width; lvar=lvar+1) begin : something
      always_comb begin
        part_idx[lvar] = 0;
        for(integer i=0; i<pot_width; i=i+(1<<(lvar+1))) begin
          part_idx[lvar][i] = part_idx[lvar-1][i] ||  part_idx[lvar-1][i+(1<<lvar)];
          part_idx[lvar][i+1 +: lvar] = part_idx[lvar-1][i] ? part_idx[lvar-1][i+1 +:lvar] : part_idx[lvar-1][i+(1<<lvar)+1 +:lvar];
          part_idx[lvar][i+1 + lvar] = !part_idx[lvar-1][i];
        end
      end
    end
    endgenerate

    assign valid_reg  = part_idx[log_width-1][0];
    assign encode_reg = part_idx[log_width-1][1+:log_width];
endmodule


