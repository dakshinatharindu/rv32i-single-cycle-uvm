if [file exists work] {vdel -all}
vlib work
vlog -f compile.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs="+acc" top +UVM_TESTNAME=switch_test +UVM_VERBOSITY=UVM_HIGH
run -all
# coverage report -cvg -detail -output coverage.txt
