# WASM Examples

The final layout will look like this.

```
$ROOT/
    llvm/
        out/
    wabt/
        bin/
    wasm-c-experiments/
    musl-wasm/

```

# Wabt

Convert between WASM binary and textual formats.

```
cd $ROOT
git clone https://github.com/WebAssembly/wabt.git
make
```

# LLVM

From-scratch build LLVM, clang, lld

```
cd $ROOT
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

# checkout clang
(cd llvm/tools && svn co http://llvm.org/svn/llvm-project/cfe/trunk clang)

# checkout lld
(cd llvm/tools && svn co http://llvm.org/svn/llvm-project/lld/trunk lld)

(cd llvm/projects
svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx
svn co http://llvm.org/svn/llvm-project/libcxxabi/trunk libcxxabi)


# generate project
mkdir -p out && cd out
cmake -G Ninja -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly ../llvm

# build
ninja
```

# MUSL-WASM

```
cd $ROOT
git clone https://github.com/groundwater/musl-wasm
mkdir -p out && cd out

export AR=../llvm/out/llvm-ar
export CC="../llvm/out/clang --target=wasm32-unknown-unknown-wasm"
export RANLIB=../llvm/out/llvm-ranlib
export CFLAGS="-O0 -fvisibility=default"

../configure --disable-shared

make lib/libc.a
```

# WASM C Example

```
cd $ROOT
git clone https://github.com/groundwater/wasm-c-example.git
cd wasm-c-example
make
```

This produces `out.wasm` which is a compiled and linked wasm executable, _almost_ ready to load in your browser.
The `.wasm` binary requires a runtime implementation to run.

- The runtime must implement to symbols in [external-symbols](external-symbols).
- Check out the [WebContainers](https://github.com/groundwater/WebContainers/) work-in-progress implementation.

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
