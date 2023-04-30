import uvm_pkg::*;
import core_pkg::*;

module top;

   core_if _if();
   core_wrapper dut(_if.core_md);
   
   initial begin
    uvm_config_db #(virtual core_if)::set(null, "uvm_test_top.*", "_if", _if);
    
    run_test();
   end   
      
endmodule // top