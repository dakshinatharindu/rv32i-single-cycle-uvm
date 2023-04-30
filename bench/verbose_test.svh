class verbose_test extends uvm_test;

    `uvm_component_utils(verbose_test)

    core_env env;
    instr_seq seq;

    function new(string name="verbose_test", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = core_env::type_id::create("env",this);
        seq = instr_seq::type_id::create("seq");
    endfunction : build_phase

    // function void end_of_elaboration_phase(uvm_phase phase);
    //     env.agnt.seqr.set_arbitration(UVM_SEQ_ARB_RANDOM);
    // endfunction : end_of_elaboration_phase

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agnt.seqr);
        phase.drop_objection(this);
    endtask

endclass