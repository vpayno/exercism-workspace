;; https://exercism.org/tracks/wasm/exercises/leap

(module
  ;; (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  ;; (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  ;; (memory (export "mem") 1)

  (global $false i32 (i32.const 0))
  (global $true  i32 (i32.const 1))

  ;; Returns 1 if leap year, 0 otherwise
  (func (export "isLeap") (param $year i32) (result i32)
    (if
      (i32.eq
        (i32.rem_u
          (local.get $year)
          (i32.const 400)
          ) ;; modulo
        (i32.const 0)
        ) ;; eq
      (return (global.get $true))
      ) ;; if year % 400 == 0

    (if
      (i32.eq
        (i32.rem_u
          (local.get $year)
          (i32.const 100)
          ) ;; modulo
        (i32.const 0)
        ) ;; eq
      (return (global.get $false))
      ) ;; if year % 100 == 0

    (if
      (i32.eq
        (i32.rem_u
          (local.get $year)
          (i32.const 4)
          ) ;; modulo
        (i32.const 0)
        ) ;; eq
      (return (global.get $true))
      ) ;; if year % 4 == 0

    (return (global.get $false))
    ) ;; isLeap()
) ;; module
