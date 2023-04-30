class driver extends uvm_driver #(instr);

    `uvm_component_utils(driver)

    virtual core_if _if;

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual core_if)::get(this, "", "_if", _if))
            `uvm_fatal("DRIVER", "No config_db found")
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        forever begin
            instr op;
            @(negedge _if.clk);
            seq_item_port.get(op);
            `uvm_info("DRIVER", $sformatf("Got:\t%s", op.convert2str()), UVM_MEDIUM)
            
            @(posedge _if.clk);
            #2;
        end
    endtask
endclass