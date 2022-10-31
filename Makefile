.PHONY: puzzle19

puzzle19: 19_entanglement/tb.v
	verilator --lint-only --no-timing -Ituringtumble --top-module puzzle $<
	iverilog -Ituringtumble $< -o $@
	vvp $@ 