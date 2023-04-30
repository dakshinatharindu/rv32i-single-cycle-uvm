class instr extends uvm_sequence_item;

    `uvm_object_utils(instr)

    rand logic               rstn;
    rand logic   [31:0]      instr;
    rand logic   [31:0]      mem_rd_d;
    rand logic               vld;

    constraint rstn_range {rstn dist { 0 := 8, 1 := 2};}
    constraint vld_range {vld dist { 0 := 3, 1 := 7};}
    constraint instr_bin {instr inside {45,78};}

    function new(string name = "instr");
        super.new(name);
    endfunction

    virtual function string convert2str();
        return $sformatf("rstn=%h, vld=%h, instr=%h, mem_rd_d=%h", rstn, vld, instr, mem_rd_d);
    endfunction
endclass