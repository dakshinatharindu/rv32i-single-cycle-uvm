class instr_seq extends uvm_sequence #(instruction);

    `uvm_object_utils(instr_seq)

    int file;
    logic [31:0] instr;

    function new(string name = "instr_seq");
        super.new(name);
        file = $fopen("./bench/program.txt", "r");
        if (!file) `uvm_fatal("SEQ", "program file was not found");
    endfunction

    virtual task body();
        instruction op = instruction::type_id::create("op");
        start_item(op);
        assert (op.randomize());
        op.load_data($random, 0);
        `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
        finish_item(op);
        
        while(!$feof(file)) begin
            instruction op = instruction::type_id::create("op");
            $fscanf(file, "%h\n", instr);
            start_item(op);
            assert (op.randomize());
            op.load_data(instr);
            `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
            finish_item(op);
        end
        $fclose(file);
    endtask
endclass