(module
  ;; (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i64) (param $length i64)))
  ;; (import "console" "log_i32_s" (func $log_i32_s (param i64)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i64_u (local.get $number))

  ;; squareNum is signed i32
  ;; Result is unsigned i64
  (func $square (export "square") (param $squareNum i32) (result i64)
    ;; guards/fast returns
    (if
      (i32.or
        ;; n < 1
        (i32.lt_s (local.get $squareNum) (i32.const 1))
        ;; n > 64
        (i32.gt_s (local.get $squareNum) (i32.const 64))
        )
      (then
        (return (i64.const 0))
        )
      ) ;; if

    ;; (1_u64) << (index - 1)
    (i64.shl
      (i64.const 1)
      ;; cast from i32 to i64
      (i64.extend_i32_u (i32.sub (local.get $squareNum) (i32.const 1)))
      ) ;; shl
  )

  ;; Result is unsigned i64
  (func (export "total") (result i64)
    ;; let it wrap to get the highest value (u64::MAX)
    ;; (i64.const -1)

    ;; ((((1_u64) << 63) - 1) << 1) + 1
    (i64.add
      (i64.shl
        (i64.sub
          (i64.shl
            (i64.const 1)
            (i64.const 63)
            ) ;; shl
          (i64.const 1)
          ) ;; sub
          (i64.const 1)
        ) ;; shl
        (i64.const 1)
      ) ;; add
  )
)
