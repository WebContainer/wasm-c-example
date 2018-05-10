ROOT=..

LLVM=$(ROOT)/llvm/Default/bin
WABT=$(ROOT)/wabt/bin
BINARYEN=$(ROOT)/binaryen/out/bin

CXX=$(LLVM)/clang
LLC=$(LLVM)/llc
LLD=$(LLVM)/lld 
WASM2WAT=$(WABT)/wasm2wat
S2WASM=$(BINARYEN)/s2wasm
WAT2WASM=$(WABT)/wat2was

# README
# https://github.com/WebAssembly/binaryen#cc-source--webassembly-llvm-backend--s2wasm--webassembly

out.wat: out.wasm
	$(WASM2WAT) out.wasm > out.wat
out.wasm: main.o hello.o
	# https://lld.llvm.org/WebAssembly.html
	# https://github.com/llvm-mirror/lld/blob/master/tools/lld/lld.cpp
	# ../llvm/Default/bin/lld -flavor wasm --help
	$(LLD) -flavor wasm --import-memory --allow-undefined -o out.wasm main.o hello.o

# https://github.com/WebAssembly/binaryen/issues/1447#issuecomment-368959790
# For posterity: -wasm is the default when manually invoking clang, 
# because that can output a wasm object file (.o), which LLD can link, 
# skipping s2wasm and the assembly format entirely. 
# That's another path to building wasm modules, 
# though it's neither entirely stable nor entirely supported by Emscripten at the moment, 
# so it's not as recommended for use today, unless you're feeling experimental.
main.o: main.c Makefile
	$(CXX) -O0 --target=-wasm32-unknown-unknown-wasm main.c -c -o main.o
hello.o: hello.c Makefile
	$(CXX) -O0 --target=-wasm32-unknown-unknown-wasm hello.c -c -o hello.o

main.wasm: main.wat
	$(WAT2WASM) --debug-names main.wat > main.wasm
main.wat: main.s
	$(S2WASM) -g --import-memory main.s > main.wat
main.s: main.bc
	$(LLC) -mtriple=wasm32-unknown-unknown-elf -filetype=asm -o main.s main.bc
main.bc: main.c
	$(CXX) -emit-llvm -O0 -g --target=wasm32 -S main.c -c -o main.bc
clean:
	rm -f *.s *.bc *.wasm *.wat *.o

hello.wasm: hello.wat
	$(WAT2WASM) --debug-names hello.wat > hello.wasm
hello.wat: hello.s
	$(S2WASM) -g --import-memory hello.s > hello.wat
hello.s: hello.bc
	$(LLC) -mtriple=wasm32-unknown-unknown-elf -filetype=asm -o hello.s hello.bc
hello.bc: hello.c Makefile
	$(CXX) -emit-llvm -O0 -g --target=wasm32 -S hello.c -c -o hello.bc
