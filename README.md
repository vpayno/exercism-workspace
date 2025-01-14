# exercism-workspace

Exercism Workspace

- [Tracks](https://exercism.org/docs/tracks)
- [My Profile](https://exercism.org/profiles/vpayno)

## [12in23 Challenge Dashboard](https://exercism.org/challenges/12in23)

Archived `#12in23` challenge notes to [README-2023.md](./README-2023.md)

## CI

### CI Badges

[![Bash Checks](https://github.com/vpayno/exercism-workspace/actions/workflows/bash.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/bash.yml)
[![Go Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/go.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/go.yml)
[![Dart Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/dart.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/dart.yml)
[![Tcl Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/tcl.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/tcl.yml)
[![Lua Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/lua.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/lua.yml)
[![Vimscript Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/vimscript.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/vimscript.yml)
[![Awk Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/awk.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/awk.yml)
[![Rust Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/rust.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/rust.yml)
[![jq Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/jq.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/jq.yml)
[![Haskell Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/haskell.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/haskell.yml)
[![Python Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/python.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/python.yml)
[![Common Lisp Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/common-lisp.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/common-lisp.yml)
[![C Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/c.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/c.yml)
[![CPP Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/cpp.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/cpp.yml)
[![Ruby Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/ruby.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/ruby.yml)
[![WebAssembly Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/wasm.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/wasm.yml)
[![Gleam Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/gleam.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/gleam.yml)
[![R Workflow](https://github.com/vpayno/exercism-workspace/actions/workflows/r.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/r.yml)

[![Check Links](https://github.com/vpayno/exercism-workspace/actions/workflows/links.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/links.yml)
[![woke (pr)](https://github.com/vpayno/exercism-workspace/actions/workflows/woke-pr.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/woke-pr.yml)
[![Woke (push)](https://github.com/vpayno/exercism-workspace/actions/workflows/woke-push.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/woke-push.yml)
[![CodeQL](https://github.com/vpayno/exercism-workspace/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/codeql-analysis.yml)
[![Docker Build](https://github.com/vpayno/exercism-workspace/actions/workflows/docker-build.yml/badge.svg)](https://github.com/vpayno/exercism-workspace/actions/workflows/docker-build.yml)

### CI Containers

- [ci-generic-debian](https://hub.docker.com/r/vpayno/ci-generic-debian/tags)
- [ci-anaconda-debian](https://hub.docker.com/r/vpayno/ci-anaconda-debian/tags)

### Workflow Versions

- 1.0 - original versions
- 2.0 - exercises are tested in parallel
- 3.0 - start using a custom container
- 4.0 - lean hard on wrapper script encapsulation
- 5.0 - use dagger ci to wrap the wrapper scripts which allows for local and ci execution

### Yaml Configs

- [BASH Workflow](.github/workflows/bash.yml)
- [Git PR Fixup Blocker Workflow](.github/workflows/git.yml)
- [Go Workflow](.github/workflows/go.yml)
- [Dart Workflow](.github/workflows/dart.yml)
- [Tcl Workflow](.github/workflows/tcl.yml)
- [Lua Workflow](.github/workflows/lua.yml)
- [Vimscript Workflow](.github/workflows/vimscript.yml)
- [Awk Workflow](.github/workflows/awk.yml)
- [Rust Workflow](.github/workflows/rust.yml)
- [jq Workflow](.github/workflows/jq.yml)
- [Haskell Workflow](.github/workflows/haskell.yml)
- [Python Workflow](.github/workflows/python.yml)
- [Common Lisp Workflow](.github/workflows/common-lisp.yml)
- [C Workflow](.github/workflows/c.yml)
- [C++ Workflow](.github/workflows/cpp.yml)
- [Ruby Workflow](.github/workflows/ruby.yml)
- [WebAssembly Workflow](.github/workflows/wasm.yml)
- [Gleam Workflow](.github/workflows/gleam.yml)
- [R Workflow](.github/workflows/r.yml)
- [Link Checker Workflow](.github/workflows/links.yml)
- [CodeQL Workflow](.github/workflows/codeql-analysis.yml)
- [Woke PR](.github/workflows/woke-pr.yml)
- [Woke Push](.github/workflows/woke-push.yml)

## Active Tracks

- [Bash](bash/README.md)
- [Go](go/README.md)
- [Dart](dart/README.md)
- [Tcl](tcl/README.md)
- [Lua](lua/README.md)
- [Vimscript](vimscript/README.md)
- [Awk](awk/README.md)
- [Rust](rust/README.md)
- [jq](jq/README.md)
- [Haskell](haskell/README.md)
- [Python](python/README.md)
- [Common Lisp](common-lisp/README.md)
- [C](c/README.md)
- [C++](cpp/README.md)
- [Ruby](ruby/README.md)
- [WebAssembly](wasm/README.md)
- [Gleam](gleam/README.md)
- [R](r/README.md)

## Tools/Scripts

- [Bash run-tests](./bash/run-tests)
- [Go run-tests](./go/run-tests)
- [Dart run-tests](./dart/run-tests)
- [Tcl run-tests](./tcl/run-tests)
- [Lua run-tests](./lua/run-tests)
- [Vimscript run-tests](./vimscript/run-tests)
- [Awk run-tests](./awk/run-tests)
- [Rust run-tests](./rust/run-tests)
- [jq run-tests](./jq/run-tests)
- [Haskell run-tests](./haskell/run-tests)
- [Python run-tests](./python/run-tests)
- [Common Lisp run-tests](./common-lisp/run-tests)
- [C run-tests](./c/run-tests)
- [C++ run-tests](./cpp/run-tests)
- [Ruby run-tests](./ruby/run-tests)
- [WebAssembly run-tests](./wasm/run-tests)
- [Gleam run-tests](./gleam/run-tests)
- [R run-tests](./r/run-tests)
