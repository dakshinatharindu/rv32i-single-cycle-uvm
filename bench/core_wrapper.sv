module core_wrapper (
    core_if.core_md _if
);
    Core core(
        .clock(_if.clk),
        .reset(_if.rstn),
        .io_instr(_if.instr),
        .io_memReadData(_if.mem_rd_d),
        .io_valid(_if.vld),
        .io_instrAddrs(_if.nxt_instr),
        .io_ALUOut(_if.alu_out),
        .io_memWriteData(_if.mem_wr_d),
        .io_memRead(_if.mem_rd),
        .io_memWrite(_if.mem_wr),
        .io_storeType(_if.str_type)
    );
endmodule