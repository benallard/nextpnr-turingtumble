.PHONY: puzzle19

puzzle19: 19_entanglement/tb.v
	verilator --lint-only -Ituringtumble --top-module puzzle $<
	iverilog -Ituringtumble $< -o $@
	vvp $@ 