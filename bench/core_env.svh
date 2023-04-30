class core_env extends uvm_env;

    `uvm_component_utils(core_env);

    core_agent agnt;

    function new(string name="core_env", uvm_component parent);
      super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = core_agent::type_id::create("agnt", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

endclass