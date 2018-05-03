ROOT=..

CLANG_PREFIX=${ROOT}/llvm/out/bin
WASM_PREFIX=${ROOT}/wabt/bin
BINARYEN_PREFIX=${ROOT}/binaryen/out/bin

CXX=${CLANG_PREFIX}/clang
LLC=${CLANG_PREFIX}/llc

S2WASM=${BINARYEN_PREFIX}/s2wasm
WAT2WASM=${WASM_PREFIX}/wat2wasm

# README
# https://github.com/WebAssembly/binaryen#cc-source--webassembly-llvm-backend--s2wasm--webassembly

main.wasm: main.wat
	${WAT2WASM} --debug-names main.wat > main.wasm
main.wat: main.s
	${S2WASM} -g --import-memory main.s > main.wat
main.s: main.bc
	${LLC} -mtriple=wasm32-unknown-unknown-elf -filetype=asm -o main.s main.bc
main.bc: main.c Makefile
	${CXX} -emit-llvm -O0 -g --target=wasm32 -S main.c -c -o main.bc
clean:
	rm -f *.s *.bc *.wasm *.wat
