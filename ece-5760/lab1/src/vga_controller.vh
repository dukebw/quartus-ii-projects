`define HORIZONTAL_WIDTH_PIXELS 10'h280 // 640
`define LAST_X_PIXEL            (`HORIZONTAL_WIDTH_PIXELS - 10'h1)
`define VERTICAL_HEIGHT_PIXELS  10'h1E0 // 480
`define H_SYNC_CYCLES           10'h60 // 96
`define H_BACK_PORCH_CYCLES     10'h28 // 48
`define H_FRONT_PORCH_CYCLES    10'h18 // 16
`define H_FRONT_PORCH_START     (`H_SYNC_CYCLES + `H_BACK_PORCH_CYCLES + `HORIZONTAL_WIDTH_PIXELS)
`define HORIZONTAL_CYCLES_MAX   (`H_FRONT_PORCH_START + `H_FRONT_PORCH_CYCLES - 1)
`define V_SYNC_CYCLES           10'h2
`define V_BACK_PORCH_CYCLES     10'h21 // 33
`define V_FRONT_PORCH_CYCLES    10'hA // 10
`define V_FRONT_PORCH_START     (`V_SYNC_CYCLES + `V_BACK_PORCH_CYCLES + `VERTICAL_HEIGHT_PIXELS)
`define VERTICAL_CYCLES_MAX     (`V_SYNC_CYCLES + `V_BACK_PORCH_CYCLES + `VERTICAL_HEIGHT_PIXELS + `V_FRONT_PORCH_CYCLES)
`define H_ADDRESS_LEAD_CYCLES   10'h1

`define IS_OUTSIDE_VISIBLE_REGION(horizontal_cycle_count, vertical_cycle_count) \
    (((horizontal_cycle_count) < (`H_SYNC_CYCLES + `H_BACK_PORCH_CYCLES)) ||    \
     ((horizontal_cycle_count) >= `H_FRONT_PORCH_START) ||                      \
     ((vertical_cycle_count) < (`V_SYNC_CYCLES + `V_BACK_PORCH_CYCLES)) ||      \
     ((vertical_cycle_count) >= `V_FRONT_PORCH_START))

