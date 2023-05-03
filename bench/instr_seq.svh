class instr_seq extends uvm_sequence #(instruction, res);

    `uvm_object_utils(instr_seq)

    logic [31:0] instr_addr = 32'h0;
    logic [7:0] instr_mem [1024];
    function new(string name = "instr_seq");
        super.new(name);
        $readmemh("./bench/g.hex", instr_mem);
    endfunction

    function logic [31:0] instr_mem_read(logic [9:0] addr);
        return {instr_mem[addr+3], instr_mem[addr+2], instr_mem[addr+1], instr_mem[addr]};
    endfunction

    virtual task body();
        res rsp;
        instruction op = instruction::type_id::create("op");
        start_item(op);
        assert (op.randomize());
        op.load_data($random, 1);
        `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
        finish_item(op);
        get_response(rsp);
        `uvm_info("SEQ", $sformatf("Got:\t%s", rsp.convert2str()), UVM_MEDIUM)
        
        repeat(50) begin
            instruction op = instruction::type_id::create("op");
            res rsp;
            start_item(op);
            assert (op.randomize());
            op.load_data(instr_mem_read(instr_addr));
            `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
            finish_item(op);
            get_response(rsp);
            `uvm_info("SEQ", $sformatf("Got:\t%s", rsp.convert2str()), UVM_MEDIUM)
            instr_addr = rsp.nxt_instr;
        end
    endtask
endclass