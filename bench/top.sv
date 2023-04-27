import uvm_pkg::*;
import core_pkg::*;

module top;

   core_if _if();
   core_wrapper dut(_if.core_md);
   
   initial begin
    // uvm_config_db #(virtual switch_if)::set(null, "uvm_test_top", "sw_if", sw_if);
    
    // run_test();
    $display("imported successfully");
    $finish();
   end   
      
endmodule // top