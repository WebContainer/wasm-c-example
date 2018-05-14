ROOT=..

LLVM=$(ROOT)/llvm/out/bin
WABT=$(ROOT)/wabt/bin
BINARYEN=$(ROOT)/binaryen/out/bin

CXX=$(LLVM)/clang
LLD=$(LLVM)/wasm-ld 

WASM2WAT=$(WABT)/wasm2wat

LIBC_DIR		=../musl/out/lib
LIBC_INCLUDE	=../musl/include
ARCH_INCLUDE	=../musl/arch/wasm32
ARCH_INCLUDE_GEN=../musl/out/obj/include

# README
# https://github.com/WebAssembly/binaryen#cc-source--webassembly-llvm-backend--s2wasm--webassembly
# https://webghc.github.io/2017/07/25/buildinglibcedited.html
# https://gist.github.com/masuidrive/5231110#file-gistfile1-txt-L250
CFLAGS=\
	-nostdinc \
	-nodefaultlibs \
	-Oz \
	--target=-wasm32-unknown-unknown-wasm \
	-Werror=implicit-function-declaration \
	-fno-builtin \
	-I $(ARCH_INCLUDE_GEN) \
	-I $(ARCH_INCLUDE) \
	-I $(LIBC_INCLUDE)

LLD_FLAGS=\
	--import-memory \
	--allow-undefined-file=external-symbols \
	--entry main
LLD_PATHS=\
	-L . \
	-L $(LIBC_DIR)
LLD_LIBS=\
	-l hello \
	-l c

out.wat: out.wasm
	$(WASM2WAT) out.wasm > out.wat

# https://lld.llvm.org/WebAssembly.html
# https://github.com/llvm-mirror/lld/blob/master/tools/lld/lld.cpp
out.wasm: main.o libhello.a
	$(LLD) $(LLD_FLAGS) $(LLD_PATHS) $(LLD_LIBS) main.o -o out.wasm

# Testing that we can make a static libary!
libhello.a: hello.o
	../llvm/out/bin/llvm-ar qc libhello.a hello.o

# https://github.com/WebAssembly/binaryen/issues/1447#issuecomment-368959790
# For posterity: -wasm is the default when manually invoking clang, 
# because that can output a wasm object file (.o), which LLD can link, 
# skipping s2wasm and the assembly format entirely. 
# That's another path to building wasm modules, 
# though it's neither entirely stable nor entirely supported by Emscripten at the moment, 
# so it's not as recommended for use today, unless you're feeling experimental.

main.o: main.c Makefile
	$(CXX) $(CFLAGS) $(CXX_FLAGS) main.c -c -o main.o
hello.o: hello.c Makefile
	$(CXX) $(CFLAGS) $(CXX_FLAGS) hello.c -c -o hello.o

clean:
	rm -f *.s *.bc *.wasm *.wat *.o *.a

# Below is the old method used.
# We don't use that toolchain anymore.
# We leave it here. Why not.

# main.wasm: main.wat
# 	$(WAT2WASM) --debug-names main.wat > main.wasm
# main.wat: main.s
# 	$(S2WASM) -g --import-memory main.s > main.wat
# main.s: main.bc
# 	$(LLC) -mtriple=wasm32-unknown-unknown-elf -filetype=asm -o main.s main.bc
# main.bc: main.c
# 	$(CXX) -emit-llvm -O0 -g --target=wasm32 -S main.c -c -o main.bc
#
# hello.wasm: hello.wat
# 	$(WAT2WASM) --debug-names hello.wat > hello.wasm
# hello.wat: hello.s
# 	$(S2WASM) -g --import-memory hello.s > hello.wat
# hello.s: hello.bc
# 	$(LLC) -mtriple=wasm32-unknown-unknown-elf -filetype=asm -o hello.s hello.bc
# hello.bc: hello.c Makefile
# 	$(CXX) -emit-llvm -O0 -g --target=wasm32 -S hello.c -c -o hello.bc
