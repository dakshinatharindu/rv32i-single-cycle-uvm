class driver extends uvm_driver #(instruction, res);

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
            instruction op;
            res rsp;
            @(negedge _if.clk);
            seq_item_port.get(op);
            // `uvm_info("DRIVER", $sformatf("Got:\t%s", op.convert2str()), UVM_MEDIUM)
            _if.rstn = op.rstn;
            _if.vld = op.vld;
            _if.instr = op.instr;
            _if.mem_rd_d = op.mem_rd_d;
            
            @(posedge _if.clk);
            #3;
            rsp = res::type_id::create("rsp");
            rsp.nxt_instr = _if.nxt_instr;
            rsp.alu_out = _if.alu_out;
            rsp.mem_wr_d = _if.mem_wr_d;
            rsp.mem_rd = _if.mem_rd;
            rsp.mem_wr = _if.mem_wr;
            rsp.str_type = _if.str_type;
            rsp.set_id_info(op);
            seq_item_port.put(rsp);
            
        end
    endtask
endclass