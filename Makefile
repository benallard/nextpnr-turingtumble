.PHONY: puzzle19

puzzle19: puzzle19.vvp

puzzle19.vvp: 19_entanglement/tb.v 19_entanglement/puzzle.v turingtumble/cells.v turingtumble/board.v
	verilator --lint-only --timing -I. --top-module tb $<
	iverilog -I. $< -o $@
	vvp $@ 