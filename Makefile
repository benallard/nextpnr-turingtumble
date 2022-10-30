.PHONY: puzzle19

puzzle19: 19_entanglement/solution.v
	verilator --lint-only -Ituringtumble --top-module puzzle $<