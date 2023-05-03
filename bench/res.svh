class res extends uvm_sequence_item;

    `uvm_object_utils(res)

    logic   [8:0]       nxt_instr;
    logic   [31:0]      alu_out;
    logic   [31:0]      mem_wr_d;
    logic               mem_rd;
    logic               mem_wr;
    logic   [1:0]       str_type;

    function new(string name = "res");
        super.new(name);
    endfunction

    virtual function string convert2str();
        return $sformatf("nxt_instr=%h, alu_out=%h, mem_wr_d=%h, mem_rd=%h, mem_wr=%h, str_type=%h", nxt_instr, alu_out, mem_wr_d, mem_rd, mem_wr, str_type);
    endfunction

endclass