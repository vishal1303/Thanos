`ifndef PARAM_512
`define PARAM_512

parameter BIT_VEC_SIZE = 512;
parameter BIT_VEC_SIZE_LOG = $clog2(BIT_VEC_SIZE);

parameter NUM_OF_METRICS = 8;
parameter NUM_OF_METRICS_LOG = $clog2(NUM_OF_METRICS);

typedef struct {
    logic [7:0] val;
    logic [BIT_VEC_SIZE_LOG-1:0] ptr [NUM_OF_METRICS-1:0];
} IdEntry;

typedef struct packed {
    logic [7:0] val;
    logic [BIT_VEC_SIZE_LOG-1:0] ptr;
} Entry;

`endif