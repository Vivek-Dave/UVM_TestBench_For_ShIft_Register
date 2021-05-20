
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "shr_sequence_item.sv"        // transaction class
 `include "shr_sequence.sv"             // sequence class
 `include "shr_sequencer.sv"            // sequencer class
 `include "shr_driver.sv"               // driver class
 `include "shr_monitor.sv"
 `include "shr_agent.sv"                // agent class  
 `include "shr_coverage.sv"             // coverage class
 `include "shr_scoreboard.sv"
 `include "shr_env.sv"                  // environment class

 `include "shr_test.sv"                 // test

endpackage
`endif 


