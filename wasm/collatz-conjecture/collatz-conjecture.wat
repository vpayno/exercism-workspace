;; https://exercism.org/tracks/wasm/exercises/collatz-conjecture

(module
  ;; (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  ;; (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  (global $error i32 (i32.const -1))

  (func (export "steps") (param $start i32) (result i32)
    (local $number i32)
    (local $count i32)

    (local.set $number (local.get $start))
    (local.set $count (i32.const 0))

    (if (i32.le_s (local.get $number) (i32.const 0))
      (return (global.get $error))
      ) ;; if zero or negative

    (if (i32.eq (i32.const 1) (local.get $number))
      (return (local.get $count))
      ) ;; if one

    (loop $my_loop
      (local.set $count
        (i32.add (local.get $count) (i32.const 1))
        ) ;; count+=1

      (if
        (i32.eqz
          (i32.rem_s (local.get $number) (i32.const 2))
          ) ;; eq
        (then
          (local.set $number
            (i32.div_s (local.get $number) (i32.const 2))
            ) ;; num /= 2
          ) ;; then
        (else
          (local.set $number
            (i32.add
              (i32.mul (local.get $number) (i32.const 3))
              (i32.const 1)
              ) ;; add
            ) ;; num = num * 3 + 1;
          ) ;; then
        ) ;; if

      (br_if $my_loop
        (i32.gt_s (local.get $number) (i32.const 1))
        ) ;; br_if
      ) ;; loop

    (return (local.get $count))
  ) ;; steps()
) ;; module
