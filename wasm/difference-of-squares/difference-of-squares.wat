;; https://exercism.org/tracks/wasm/exercises/difference-of-squares

(module
  ;; (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  ;; (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  ;; (memory (export "mem") 1)

  ;; The name prefixed with $ is used to internally refer to functions via the call instruction
  ;; The string in the export instruction is the name of the export made available to the
  ;; embedding environment (in this case, Node.js). This is used by our test runner Jest.

  ;; u32::pow(number * (number + 1) / 2, 2)
  (func $squareOfSum (export "squareOfSum") (param $number i32) (result i32)
    (local $tmp i32)

    (local.set $tmp
      (i32.div_u
        (i32.mul
          (local.get $number)
          (i32.add
            (local.get $number)
            (i32.const 1)
            ) ;; n+1
          ) ;; n*(n+1)
        (i32.const 2)
        ) ;; (n*(n+1))/2
      ) ;; store tmp

    (return (i32.mul (local.get $tmp) (local.get $tmp)))
  ) ;; squareOfSums()

  ;; number * (number + 1) * (2 * number + 1) / 6
  (func $sumOfSquares (export "sumOfSquares") (param $number i32) (result i32)
    (i32.div_u
      (i32.mul
        (i32.mul
          (local.get $number)
          (i32.add
            (local.get $number)
            (i32.const 1)
            ) ;; n+1
          ) ;; n*(n+1)
        (i32.add
          (i32.mul
            (i32.const 2)
            (local.get $number)
            ) ;; 2*n
          (i32.const 1)
          ) ;; (2*n)+1
        ) ;; (n*(n+1))*((2*n)+1)
      (i32.const 6)
      ) ;; ((n*(n+1))*((2*n)+1))/6
  ) ;; sumOfS)quares()

  ;; square_of_sum(number) - sum_of_squares(number)
  (func (export "difference") (param $number i32) (result i32)
    (i32.sub
      (call $squareOfSum (local.get $number))
      (call $sumOfSquares (local.get $number))
    )
  ) ;; difference()
)
