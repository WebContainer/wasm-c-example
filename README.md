# WASM Electron Toolkit

> Cross platform compiled desktop applications.

```
$ROOT/
    llvm/
    wabt/
    binaryen/
    wasm-c-experiments/
```

# Wabt

Convert between WASM binary and textual formats.

```
cd $ROOT
git clone https://github.com/WebAssembly/wabt.git
make
```

# Binaryen

Convert between `.s` assembly and WASM.

```
cd $ROOT
git clone https://github.com/webassembly/binaryen.git
cmake . && make
```

# LLVM

From-scratch build LLVM, clang, lld

```
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

# checkout clang
(cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang)

# checkout lld
(cd llvm/tools
svn co http://llvm.org/svn/llvm-project/lld/trunk lld)

# generate project
mkdir -p out; cd out
cmake -G ninja -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly ../llvm

# build
ninja
```

# WASM C Example

```
cd $ROOT
git clone https://github.com/groundwater/wasm-c-example.git
cd wasm-c-example
make
```

# Notes

## WebAssembly

- [WebAssembly GitHub Org](https://github.com/WebAssembly)
- [spec](https://github.com/WebAssembly/spec)
- [Instructions](https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md)

## Text Format

- https://github.com/webassembly/wabt
- [Walkthrough](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)

# Links

- [Disable linking libc in emscripten](https://stackoverflow.com/questions/41653792/disable-linking-libc-in-emscripten)
- [Using WebAssembly in LLVM](https://gist.github.com/yurydelendik/4eeff8248aeb14ce763e)
