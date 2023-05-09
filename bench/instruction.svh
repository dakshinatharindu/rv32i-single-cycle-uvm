class instruction extends uvm_sequence_item;

    `uvm_object_utils(instruction)

    logic                   rstn;
    logic       [31:0]      instr;
    logic       [31:0]      mem_rd_d;
    logic                   vld;

    function new(string name = "instruction");
        super.new(name);
    endfunction

    virtual function string convert2str();
        return $sformatf("rstn=%h, vld=%h, instr=%h, mem_rd_d=%h", rstn, vld, instr, mem_rd_d);
    endfunction

    function void load_data(logic [31:0] i, logic [31:0] d, logic r = 0, logic v = 1);
        instr = i;
        mem_rd_d = d;
        rstn = r;
        vld = v;
    endfunction
endclass