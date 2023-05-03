class instruction extends uvm_sequence_item;

    `uvm_object_utils(instruction)

    logic                   rstn;
    logic       [31:0]      instr;
    rand logic  [31:0]      mem_rd_d;
    rand logic              vld;

    constraint vld_range {vld dist { 0 := 1, 1 := 9};}

    function new(string name = "instruction");
        super.new(name);
    endfunction

    virtual function string convert2str();
        return $sformatf("rstn=%h, vld=%h, instr=%h, mem_rd_d=%h", rstn, vld, instr, mem_rd_d);
    endfunction

    function void load_data(logic [31:0] i, logic r = 0);
        instr = i;
        rstn = r;
    endfunction
endclass