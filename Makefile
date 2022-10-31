.PHONY: puzzle19 puzzle26

puzzle19: puzzle19.vvp
puzzle19.vvp: 19_entanglement/tb.v 19_entanglement/puzzle.v turingtumble/cells.v turingtumble/board.v
	verilator --lint-only --timing --top-module tb $<
	iverilog $< -o $@
	vvp $@

puzzle26: puzzle26.vvp
puzzle26.vvp: 26_nucleus/tb.v 26_nucleus/puzzle.v turingtumble/cells.v turingtumble/board.v
	verilator --lint-only --timing --top-module tb $<
	iverilog $< -o $@
	vvp $@