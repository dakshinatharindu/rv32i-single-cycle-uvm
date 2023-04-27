interface core_if;
    logic               clk;
    logic               rstn;
    logic   [31:0]      instr;
    logic   [31:0]      mem_rd_d;
    logic               vld;
    logic   [8:0]       nxt_instr;
    logic   [31:0]      alu_out;
    logic   [31:0]      mem_wr_d;
    logic               mem_rd;
    logic               mem_wr;
    logic   [1:0]       str_type;

    modport core_md (
        input           clk,
        input           rstn,
        input           instr,
        input           mem_rd_d,
        input           vld,
        output          nxt_instr,
        output          alu_out,
        output          mem_wr_d,
        output          mem_rd,
        output          mem_wr,
        output          str_type
    );

    initial begin : clock_gen
      clk = 0;
      forever #10 clk = ~clk;
    end : clock_gen

endinterface //core_if