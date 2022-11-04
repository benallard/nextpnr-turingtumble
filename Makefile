.PHONY: puzzle19 puzzle26 puzzle33

puzzle19: puzzle19.vvp puzzle19.v
puzzle19.vvp: 19_entanglement/tb.v 19_entanglement/puzzle.v 19_entanglement/pieces.v turingtumble/*.v
	verilator --lint-only -Wno-UNOPTFLAT --timing --top-module tb $<
	iverilog $< -o $@
	vvp $@

puzzle19.v: 19_entanglement/synth.ys 19_entanglement/pieces.v turingtumble/*.v 
	yosys $<

puzzle26: puzzle26.vvp
puzzle26.vvp: 26_nucleus/tb.v 26_nucleus/puzzle.v turingtumble/*.v
	verilator --lint-only --timing --top-module tb $<
	iverilog $< -o $@
	vvp $@

puzzle33: puzzle33.vvp
puzzle33.vvp: 33_teleportation/puzzle.v turingtumble/*.v
	verilator --lint-only --timing --top-module puzzle $<
	iverilog $< -o $@
	vvp $@