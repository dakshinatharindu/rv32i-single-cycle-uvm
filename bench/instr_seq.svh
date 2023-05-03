class instr_seq extends uvm_sequence #(instruction, res);

    `uvm_object_utils(instr_seq)

    int file;
    logic [31:0] instr;

    function new(string name = "instr_seq");
        super.new(name);
        file = $fopen("./bench/program.txt", "r");
        if (!file) `uvm_fatal("SEQ", "program file was not found");
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
        
        while(!$feof(file)) begin
            instruction op = instruction::type_id::create("op");
            res rsp;
            $fscanf(file, "%h\n", instr);
            start_item(op);
            assert (op.randomize());
            op.load_data(instr);
            `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
            finish_item(op);
            get_response(rsp);
            `uvm_info("SEQ", $sformatf("Got:\t%s", rsp.convert2str()), UVM_MEDIUM)
        end
        $fclose(file);
    endtask
endclass