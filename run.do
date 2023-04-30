if [file exists work] {vdel -all}
vlib work
vlog -f compile.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs="+acc" top +UVM_TESTNAME=verbose_test +UVM_VERBOSITY=UVM_HIGH
add wave /top/_if/clk
add wave /top/_if/rstn
add wave /top/_if/instr
add wave /top/_if/mem_rd_d
add wave /top/_if/vld
add wave /top/_if/nxt_instr
add wave /top/_if/alu_out
add wave /top/_if/mem_wr_d
add wave /top/_if/mem_rd
add wave /top/_if/mem_wr
add wave /top/_if/str_type
run -all
# coverage report -cvg -detail -output coverage.txt
