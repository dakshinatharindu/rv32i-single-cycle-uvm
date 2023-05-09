class instr_seq extends uvm_sequence #(instruction, res);

    `uvm_object_utils(instr_seq)

    logic [31:0] instr_addr = 32'h0;
    logic [31:0] mem_rd_d;
    logic [7:0] instr_mem [1024];
    logic [7:0] data_mem [1024];
    logic vld = 0;

    function new(string name = "instr_seq");
        super.new(name);
        $readmemh("./bench/g.hex", instr_mem);
    endfunction

    function logic [31:0] instr_mem_read(logic [9:0] addr);
        return {instr_mem[addr+3], instr_mem[addr+2], instr_mem[addr+1], instr_mem[addr]};
    endfunction

    function logic [31:0] data_mem_read(logic [31:0] addr);
        return {data_mem[addr+3], data_mem[addr+2], data_mem[addr+1], data_mem[addr]};
    endfunction

    function void data_mem_write(logic [31:0] addr, logic [31:0] data, logic [1:0] str_type);
        case (str_type)
            2'b00 : data_mem[addr] = data[7:0];
            2'b01 : begin
                data_mem[addr] = data[7:0];
                data_mem[addr+1] = data[15:8];
            end
            2'b10 : begin
                data_mem[addr] = data[7:0];
                data_mem[addr+1] = data[15:8];
                data_mem[addr+2] = data[23:16];
                data_mem[addr+3] = data[31:24];
            end
            default: begin
                `uvm_error("DMEM", "invalid store type")
             end
        endcase
    endfunction

    virtual task body();
        res rsp;
        instruction op = instruction::type_id::create("op");
        start_item(op);
        assert (op.randomize());
        op.load_data($random, .d($random), .r(1));
        `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
        finish_item(op);
        get_response(rsp);
        `uvm_info("SEQ", $sformatf("Got:\t%s", rsp.convert2str()), UVM_MEDIUM)
        
        repeat(500) begin
            instruction op = instruction::type_id::create("op");
            res rsp;
            start_item(op);
            assert (op.randomize());
            op.load_data(instr_mem_read(instr_addr), .d(mem_rd_d), .r(0), .v(vld));
            `uvm_info("SEQ", $sformatf("Sent:\t%s", op.convert2str()), UVM_MEDIUM)
            finish_item(op);
            get_response(rsp);
            `uvm_info("SEQ", $sformatf("Got:\t%s", rsp.convert2str()), UVM_MEDIUM)
            instr_addr = rsp.nxt_instr;
            if (rsp.mem_rd) begin
                 mem_rd_d = data_mem_read(rsp.alu_out);
                 vld = !vld;
            end
            if (rsp.mem_wr) begin 
                data_mem_write(rsp.alu_out, rsp.mem_wr_d, rsp.str_type);
                vld = !vld;
            end
        end
    endtask
endclass