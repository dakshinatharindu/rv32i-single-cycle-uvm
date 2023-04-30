package core_pkg;

    // uvm
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // uvm_object
    

    // uvm_transactions
    `include "instruction.svh"

    // uvm_sequences
    `include "instr_seq.svh"

    // uvm_subscribers
    `include "driver.svh"

    // uvm_agents
    `include "core_agent.svh"

    // uvm_environment
    `include "core_env.svh"

    // uvm_tests
    `include "verbose_test.svh"
    
endpackage