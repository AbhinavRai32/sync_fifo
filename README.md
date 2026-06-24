# Synchronous FIFO

A parameterized synchronous FIFO designed and verified in Verilog, with a self-checking testbench built around a software reference model.

## Overview

This project implements a single-clock-domain FIFO with:
- Parameterized depth and data width
- Full/empty detection using the extra-MSB pointer trick (no separate counter needed for full/empty)
- Almost-full / almost-empty status flags
- Sticky overflow/underflow error flags with auto-clear

## Design Details

### Parameters
```verilog
parameter depth = 16,   // FIFO depth
parameter width = 8     // Data width
```

### Full/Empty Detection
Pointers are `ADDR_BITS + 1` wide. The extra MSB acts as a wrap-around indicator:
- **Empty**: `wptr == rptr` (MSBs match, lower bits match)
- **Full**: lower bits match but MSBs differ (write pointer has wrapped exactly one more time than read pointer)

This avoids the ambiguity of using equal pointers to mean both full and empty.

### Status Flags
- `almost_full`: asserted when occupancy ≥ `depth - 4`
- `almost_empty`: asserted when occupancy ≤ `4`
- `overflow`: asserted when a write is attempted while full; auto-clears once `full` deasserts
- `underflow`: asserted when a read is attempted while empty; auto-clears once `empty` deasserts

### Output Timing
`dataout` is a registered output — valid data appears **one clock cycle** after `rd_en` is asserted on a non-empty FIFO.

## Verification Approach

The testbench does **not** use a naive `expected = datain` check. Instead, it implements a software reference model:

- A queue (array + `head`/`tail`/`count`) independently tracks what was written and in what order
- `ref_push(data)` mirrors a write — called whenever a write is issued to the DUT
- `ref_pop(data_out)` mirrors a read — called whenever a read is issued to the DUT, returns the expected value via an output argument
- Guards inside both tasks flag illegal calls (push on full, pop on empty) rather than silently corrupting state

This decouples "what should come out" from "what the DUT happens to do," so the testbench would still catch a bug even if the DUT's internal pointer logic were broken.

### Checks performed
- Data integrity: every popped value is compared against the reference model's expected value
- `almost_full` / `almost_empty`: compared against an expected value derived independently from the reference model's `count`, against both threshold directions (not just the triggering condition)
- Overflow/underflow flag behavior: verified to assert under the correct condition and clear once that condition is no longer true
- Simultaneous read+write operation
- Boundary transitions at the almost-full/almost-empty thresholds (count = 12 and count = 4 for depth = 16)

## Running the Simulation (Vivado)

1. Add `fifo_rtl.v` and `fifo_testbench.v` to a Vivado project
2. Set `fifo_testbench` as the simulation top
3. Run Behavioral Simulation
4. Check the Tcl console / log for `[PASS]` / `[FAIL]` messages from the reference model checks

## Known Limitations / Pending Work

- **No SystemVerilog assertions (SVA)** yet — directed checks via the reference model are used instead. SVA will be added once SystemVerilog fundamentals are covered (planned for a later phase).
- Stimulus is currently directed (fixed sequences), not randomized.
- No functional coverage collection.

## Bugs Found and Fixed During Development

| Bug | Description | Fix |
|---|---|---|
| Broken golden model | Testbench compared `dataout` against `datain` directly, which only works for single back-to-back write/read with no burst behavior | Replaced with a queue-based reference model |
| Race condition | `#10` delays with a 10ns clock period caused signal updates to race the clock edge | Switched to `@(posedge clk) #1` pattern |
| Sticky overflow/underflow | Flags asserted once and never cleared, even after the triggering condition ended | Added explicit clear condition (`!full` / `!empty`) |
| Hardcoded pointer width | `wptr`/`rptr` declared with a fixed width instead of using the `PTR_BITS` localparam | Updated to use the parameterized width |
| Elaboration typo | Task call `comapreresult` did not match the declared task name `compare_result` | Corrected the call site |
