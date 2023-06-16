# Exercism Common Lisp Track

[Home Page](https://exercism.org/tracks/common-lisp)

[My Profile](https://exercism.org/profiles/vpayno)

## Installing Common Lisp

### Dependencies

- [Commom Lisp](https://common-lisp.net/)
- [GNU clisp](https://www.gnu.org/software/clisp/)
- [Quicklisp](https://www.quicklisp.org/beta/)
- [FiveAM](https://github.com/lispci/fiveam/)

### Debian

- [Debian Wiki - Common Lisp](https://wiki.debian.org/CommonLisp)

Install `GNU Lisp`, `SBCL`, `FiveAM`, `emacs-nox`.

```bash
sudo apt install -y clisp clisp-doc cl-fiveam sbcl sbcl-doc cl-launch emacs-nox
```

#### lisp-format

`lisp-format` needs `emacs`.

```bash
git clone https://github.com/eschulte/lisp-format ~/git_remote/lisp-format
cp -v ~/git_remote/lisp-format/lisp-format ~/bin/lisp-format
chmod -v a+x ~/bin/lisp-format
```

#### Roswell - Common Lisp Environmenbt Setup Utility

```bash
ros_deb="$(curl -sS https://api.github.com/repos/roswell/roswell/releases/latest | jq -r '.assets | .[] | select(.name|test("[.]deb$")) | .browser_download_url')"
curl -sSOL "${ros_deb}"
sudo apt install -y "./${ros_deb}"
```

#### SBLint

```bash
ros install sbcl            # dependency that can be installed with apt
ros install cxxxr/sblint    # linter
```

- start GNU LISP interpreter

```lisp
$ clisp

  i i i i i i i       ooooo    o        ooooooo   ooooo   ooooo
  I I I I I I I      8     8   8           8     8     o  8    8
  I  \ `+' /  I      8         8           8     8        8    8
   \  `-+-'  /       8         8           8      ooooo   8oooo
    `-__|__-'        8         8           8           8  8
        |            8     o   8           8     o     8  8
  ------+------       ooooo    8oooooo  ooo8ooo   ooooo   8

Welcome to GNU CLISP 2.49.92 (2018-02-18) <http://clisp.org/>

Copyright (c) Bruno Haible, Michael Stoll 1992-1993
Copyright (c) Bruno Haible, Marcus Daniels 1994-1997
Copyright (c) Bruno Haible, Pierpaolo Bernardi, Sam Steingold 1998
Copyright (c) Bruno Haible, Sam Steingold 1999-2000
Copyright (c) Sam Steingold, Bruno Haible 2001-2018

Type :h and hit Enter for context help.

[1]> (load "/home/vpayno/quicklisp/setup.lisp")
;; Loading file /home/vpayno/quicklisp/setup.lisp ...
;;  Loading file /home/vpayno/quicklisp/asdf.lisp ...
;;  Loaded file /home/vpayno/quicklisp/asdf.lisp
;; Loaded file /home/vpayno/quicklisp/setup.lisp
#P"/home/vpayno/quicklisp/setup.lisp"
```

- run `(ql:add-to-init-file)`

```lisp
[2]> (ql:add-to-init-file)
I will append the following lines to #P"/home/vpayno/.clisprc.lisp":

  ;;; The following lines added by ql:add-to-init-file:
  #-quicklisp
  (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
    (when (probe-file quicklisp-init)
      (load quicklisp-init)))

Press Enter to continue.
#P"/home/vpayno/.clisprc.lisp"
```

- run `(ql:quickload "quicklisp-slime-helper")`

```lisp
[3]> (ql:quickload "quicklisp-slime-helper")

 (ql:update-dist "quicklisp")

(ql:update-client)

To load "quicklisp-slime-helper":
  Load 2 ASDF systems:
    alexandria asdf
  Install 2 Quicklisp releases:
    quicklisp-slime-helper slime
; Fetching #<URL "http://beta.quicklisp.org/archive/slime/2023-02-14/slime-v2.28.tgz">
; 807.68KB
==================================================
827,061 bytes in 0.16 seconds (5140.28KB/sec)
; Fetching #<URL "http://beta.quicklisp.org/archive/quicklisp-slime-helper/2015-07-09/quicklisp-slime-helper-20150709-git.tgz">
; 2.16KB
==================================================
2,211 bytes in 0.00 seconds (3774.79KB/sec)
; Loading "quicklisp-slime-helper"
[package swank-loader]............................
[package swank/backend]...........................
[package swank/rpc]...............................
[package swank/match].............................
[package swank-mop]...............................
[package swank]...................................
[package pxref]...................................
[package swank-monitor]...........................
[package swank/clisp].............................
[package swank/gray].............
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-util.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-util.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-repl.lisp ...
.................
[package swank-repl].
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-repl.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-c-p-c.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-c-p-c.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-arglists.lisp ...
....
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-arglists.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-fuzzy.lisp ...
.
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-fuzzy.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-fancy-inspector.lisp ...
..
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-fancy-inspector.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-presentations.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-presentations.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-presentation-streams.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-presentation-streams.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-asdf.lisp ...
..
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-asdf.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-package-fu.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-package-fu.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-hyperdoc.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-hyperdoc.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-mrepl.lisp ...
....................
[package swank-api]...............................
[package swank-mrepl]
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-mrepl.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-trace-dialog.lisp ...
.............................
[package swank-trace-dialog].
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-trace-dialog.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-macrostep.lisp ...
.....................
[package swank-macrostep]
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-macrostep.fas
;; Compiling file /home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-quicklisp.lisp ...
;; Wrote file /home/vpayno/.slime/fasl/2.28/clisp-2.49.92-unix-pc386/home/vpayno/quicklisp/dists/quicklisp/software/slime-v2.28/contrib/swank-quicklisp.fas
.........................
[package alexandria]..............................
[package alexandria-2]............................
[package quicklisp-slime-helper]
slime-helper.el installed in "/home/vpayno/quicklisp/slime-helper.el"

To use, add this to your ~/.emacs:

  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")


("quicklisp-slime-helper")
[4]> (exit)
Bye.
```

### Loading and running tests

- run unit tests with `(load "hello-world-test.lisp")` and `(hello-world-test:run-tests)`

```lisp
$ clisp
  i i i i i i i       ooooo    o        ooooooo   ooooo   ooooo
  I I I I I I I      8     8   8           8     8     o  8    8
  I  \ `+' /  I      8         8           8     8        8    8
   \  `-+-'  /       8         8           8      ooooo   8oooo
    `-__|__-'        8         8           8           8  8
        |            8     o   8           8     o     8  8
  ------+------       ooooo    8oooooo  ooo8ooo   ooooo   8

Welcome to GNU CLISP 2.49.92 (2018-02-18) <http://clisp.org/>

Copyright (c) Bruno Haible, Michael Stoll 1992-1993
Copyright (c) Bruno Haible, Marcus Daniels 1994-1997
Copyright (c) Bruno Haible, Pierpaolo Bernardi, Sam Steingold 1998
Copyright (c) Bruno Haible, Sam Steingold 1999-2000
Copyright (c) Sam Steingold, Bruno Haible 2001-2018

Type :h and hit Enter for context help.

;; Loading file /home/vpayno/.clisprc.lisp ...
;;  Loading file /home/vpayno/quicklisp/setup.lisp ...
;;   Loading file /home/vpayno/quicklisp/asdf.lisp ...
;;   Loaded file /home/vpayno/quicklisp/asdf.lisp
;;  Loaded file /home/vpayno/quicklisp/setup.lisp
;; Loaded file /home/vpayno/.clisprc.lisp

[1]> (load "hello-world-test.lisp")
;; Loading file hello-world-test.lisp ...
;;  Loading file /home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world.lisp ...
;;  Loaded file /home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world.lisp
To load "fiveam":
  Load 1 ASDF system:
    fiveam
; Loading "fiveam"
[package net.didierverna.asdf-flv]................
[package trivial-backtrace].......................
[package it.bese.fiveam]...
;; Loaded file hello-world-test.lisp
#P"/home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world-test.lisp"

[2]> (hello-world-test:run-tests)

Running test suite HELLO-WORLD-SUITE
 Running test SAY-HI! f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 SAY-HI! in HELLO-WORLD-SUITE []:

(HELLO-WORLD:HELLO)

 evaluated to

"Goodbye, Mars!"

 which is not

EQUAL

 to

"Hello, World!"


 --------------------------------

NIL ;
(#<IT.BESE.FIVEAM::TEST-FAILURE #x00000080007100A9>) ;
NIL
Break 2 [2]> abort
```

- fix the code so tests pass, reload test file and re-run tests

```lisp
[3]> (load "hello-world-test.lisp")
;; Loading file hello-world-test.lisp ...
;;  Loading file /home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world.lisp ...
;;  Loaded file /home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world.lisp
To load "fiveam":
  Load 1 ASDF system:
    fiveam
; Loading "fiveam"

;; Loaded file hello-world-test.lisp
#P"/home/vpayno/git_vpayno/exercism-workspace/common-lisp/hello-world/hello-world-test.lisp"
[4]> (hello-world-test:run-tests)

Running test suite HELLO-WORLD-SUITE
 Running test SAY-HI! .
 Did 1 check.
    Pass: 1 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)

T ;
NIL ;
NIL
[5]> (exit)
Bye.
```

## Tools

- [for_each](./for_each)
- [run-tests](./run-tests)
- [update_readmes](./update_readmes)

## [Concepts](https://exercism.org/tracks/common-lisp/concepts)

- [Comments](https://exercism.org/tracks/common-lisp/concepts/comments)
- [Cons](https://exercism.org/tracks/common-lisp/concepts/cons)
- [Expressions](https://exercism.org/tracks/common-lisp/concepts/expressions)
- [Symbols](https://exercism.org/tracks/common-lisp/concepts/symbols)
- [Lists](https://exercism.org/tracks/common-lisp/concepts/lists)
- [Strings](https://exercism.org/tracks/common-lisp/concepts/strings)
- [Characters](https://exercism.org/tracks/common-lisp/concepts/characters)
- [Integers](https://exercism.org/tracks/common-lisp/concepts/integers)
- [Floating Point Numbers](https://exercism.org/tracks/common-lisp/concepts/floating-point-numbers)
- [Arithmetic](https://exercism.org/tracks/common-lisp/concepts/arithmetic)
- [Date and Time](https://exercism.org/tracks/common-lisp/concepts/date-time)
- [Truty and Falsy](https://exercism.org/tracks/common-lisp/concepts/truthy-and-falsy)
- [Conditionals](https://exercism.org/tracks/common-lisp/concepts/conditionals)
- [Equality](https://exercism.org/tracks/common-lisp/concepts/equality)
- [Functions](https://exercism.org/tracks/common-lisp/concepts/functions)
- [Lambda List](https://exercism.org/tracks/common-lisp/concepts/lambda-list)
- [Keyword Parameters](https://exercism.org/tracks/common-lisp/concepts/keyword-parameters)
- [Optional Parameters](https://exercism.org/tracks/common-lisp/concepts/optional-parameters)
- [Rest Parameters](https://exercism.org/tracks/common-lisp/concepts/rest-parameters)
- [Multiple Values](https://exercism.org/tracks/common-lisp/concepts/multiple-values)
- [Hash Tables](https://exercism.org/tracks/common-lisp/concepts/hash-tables)
- [Vectors](https://exercism.org/tracks/common-lisp/concepts/vectors)
- [Arrays](https://exercism.org/tracks/common-lisp/concepts/arrays)
- [Filtering](https://exercism.org/tracks/common-lisp/concepts/filtering)
- [Mapping](https://exercism.org/tracks/common-lisp/concepts/mapping)
- [Reducing](https://exercism.org/tracks/common-lisp/concepts/reducing)
- [Format](https://exercism.org/tracks/common-lisp/concepts/format-basics)

## [Exercises](https://exercism.org/tracks/common-lisp/exercises)

- [hello-world](./hello-world/README.md)
- [socks-and-sexprs](./socks-and-sexprs/README.md)
- [pizza-pi](./pizza-pi/README.md)
- [leslies-lists](./leslies-lists/README.md)
- [pal-picker](./pal-picker/README.md)
- [lillys-lasagna](./lillys-lasagna/README.md)
- [gigasecond-anniversary](./gigasecond-anniversary/README.md)
- [log-levels](./log-levels/README.md)
- [character-study](./character-study/README.md)
- [high-scores](./high-scores/README.md)
- [larrys-winning-checker](./larrys-winning-checker/README.md)
- [lucys-magnificent-mapper](./lucys-magnificent-mapper/README.md)
- [key-comparison](./key-comparison/README.md)
- [reporting-for-duty](./reporting-for-duty/README.md)
- [lillys-lasagna-leftovers](./lillys-lasagna-leftovers/README.md)
- [logans-numeric-partition](./logans-numeric-partition/README.md)
- [two-fer](./two-fer/README.md)
