// class monitor extends uvm_monitor;
//     `uvm_component_utils(monitor)

//     uvm_analysis_port #(instr) mon_analysis_port;
//     config_db db;
//     virtual switch_if sw_if;

//     function new(string name = "monitor", uvm_component parent);
//         super.new(name, parent);
//     endfunction

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         if (!uvm_config_db #(config_db)::get(this, "", "db", db))
//             `uvm_fatal("DRIVER", "No config_db found")
//         sw_if = db.sw_if;
//         mon_analysis_port = new("mon_analysis_port", this);
//     endfunction : build_phase

//     task run_phase(uvm_phase phase);
//         @(negedge sw_if.clk);
//         forever begin
//             switch_req req_tx = switch_req::type_id::create("req");
//             @(posedge sw_if.clk)
//             #2;
//             req_tx.rstn = sw_if.rstn;
//             req_tx.vld = sw_if.vld;
//             req_tx.addr = sw_if.addr;
//             req_tx.data = sw_if.data;
//             req_tx.addr_a = sw_if.addr_a;
//             req_tx.data_a = sw_if.data_a;
//             req_tx.addr_b = sw_if.addr_b;
//             req_tx.data_b = sw_if.data_b;

//             mon_analysis_port.write(req_tx);
//             `uvm_info("MON", $sformatf("Saw \t\t\t%s", req_tx.convert2str()), UVM_MEDIUM)
//         end
//     endtask
// endclass