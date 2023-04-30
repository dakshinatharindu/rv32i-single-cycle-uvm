class instr_seq extends uvm_sequence #(instr);

    `uvm_object_utils(instr_seq)

    rand int n_loops;
    constraint how_many {n_loops inside {[5:6]};}

    function new(string name = "instr_seq");
        super.new(name);
    endfunction

    virtual task body();
        repeat(n_loops) begin 
            instr op = instr::type_id::create("op");
            start_item(op);
            assert (op.randomize());
            `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
            finish_item(op);
        end
    endtask
endclass