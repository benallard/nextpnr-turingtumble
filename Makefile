.PHONY: puzzle19

puzzle19: puzzle19.vvp

puzzle19.vvp: 19_entanglement/tb.v 19_entanglement/puzzle.v turingtumble/cells.v turingtumble/board.v
	verilator --lint-only --timing --top-module tb $<
	iverilog $< -o $@
	vvp $@ 