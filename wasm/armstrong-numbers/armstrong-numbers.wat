;; https://exercism.org/tracks/wasm/exercises/armstrong-numbers

(module
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  (import "console" "log_i32_s" (func $log_i32_s (param i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  (global $false i32 (i32.const 0))
  (global $true i32 (i32.const 1))

  ;;                      v          v        v            v           v         v      v
  ;;                      222222222222222222222222222222222222222222222222222222222222222
  ;;                      000000000000000000000000000000000000000000000000000000000000000
  ;;                      000000000011111111112222222222333333333344444444445555555555666
  ;;                      012345678901234567890123456789012345678901234567890123456789012
  ;;                      ^          ^        ^            ^           ^         ^      ^
  (data (i32.const 2000) "pow return|pow base|pow exponent|digit_count|candidate|number|")
  (global $debug_label_powreturn_offset i32 (i32.const 2000))
  (global $debug_label_powreturn_length i32 (i32.const 10))
  (global $debug_label_powbase_offset i32 (i32.const 2011))
  (global $debug_label_powbase_length i32 (i32.const 8))
  (global $debug_label_powexponent_offset i32 (i32.const 2020))
  (global $debug_label_powexponent_length i32 (i32.const 12))
  (global $debug_label_digitcount_offset i32 (i32.const 2033))
  (global $debug_label_digitcount_length i32 (i32.const 11))
  (global $debug_label_candidate_offset i32 (i32.const 2045))
  (global $debug_label_candidate_length i32 (i32.const 9))
  (global $debug_label_number_offset i32 (i32.const 2055))
  (global $debug_label_number_length i32 (i32.const 6))

  ;; returns 1 if armstrong number, 0 otherwise
  (func (export "isArmstrongNumber") (param $candidate i32) (result i32)
    (local $digit_count i32)
    (local $number i32)
    (local $pow_base i32)
    (local $pow_total i32)

    (local.set $digit_count (i32.const 0))
    (local.set $number (local.get $candidate))
    (local.set $pow_base (i32.const 0))
    (local.set $pow_total (i32.const 0))

    (call $log_mem_as_utf8 (global.get $debug_label_candidate_offset) (global.get $debug_label_candidate_length))
    (call $log_i32_s (local.get $candidate))

    (if
      (i32.lt_s (local.get $candidate) (i32.const 10))
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; if candidate < 10

    (if
      (i32.lt_s (local.get $candidate) (i32.const 100))
      (then
        (return (global.get $false))
        ) ;; then
      ) ;; if candidate < 100

    (local.set $digit_count (call $digit_counter (local.get $candidate)))

    (call $log_mem_as_utf8 (global.get $debug_label_digitcount_offset) (global.get $debug_label_digitcount_length))
    (call $log_i32_s (local.get $digit_count))

    (loop $my_loop
      ;; (call $log_mem_as_utf8 (global.get $debug_label_number_offset) (global.get $debug_label_number_length))
      ;; (call $log_i32_s (local.get $number))

      (local.set $pow_base
        (i32.rem_s (local.get $number) (i32.const 10))
        ) ;; let pow_temp: u64 = num % 10

      (local.set $pow_total
        (i32.add
          (call $pow (local.get $pow_base) (local.get $digit_count))
          (local.get $pow_total)
          ) ;; add
        ) ;; pow_total += pow_temp.pow(digit_count as u32)

      ;; (call $log_mem_as_utf8 (global.get $debug_label_powreturn_offset) (global.get $debug_label_powreturn_length))
      ;; (call $log_i32_s (local.get $pow_total))

      (local.set $number
        (i32.div_s (local.get $number) (i32.const 10))
        ) ;; num /= 10

      (br_if $my_loop
        (i32.gt_s (local.get $number) (i32.const 0))
        ) ;; br_if
      ) ;; loop

    (call $log_mem_as_utf8 (global.get $debug_label_powreturn_offset) (global.get $debug_label_powreturn_length))
    (call $log_i32_s (local.get $pow_total))

    (if
      (i32.eq (local.get $pow_total) (local.get $candidate))
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; if

    (return (global.get $false))
  ) ;; isArmstrongNumber()

  (func $pow (export "pow") (param $base i32) (param $exponent i32) (result i32)
    (local $result i32)

    ;; (call $log_mem_as_utf8 (global.get $debug_label_powbase_offset) (global.get $debug_label_powbase_length))
    ;; (call $log_i32_s (local.get $base))

    ;; (call $log_mem_as_utf8 (global.get $debug_label_powexponent_offset) (global.get $debug_label_powexponent_length))
    ;; (call $log_i32_s (local.get $exponent))

    (if
      (i32.eq (local.get $exponent) (i32.const 0))
      (then
        ;; (call $log_mem_as_utf8 (global.get $debug_label_powreturn_offset) (global.get $debug_label_powreturn_length))
        ;; (call $log_i32_s (i32.const 1))

        (return (i32.const 1))
        ) ;; then
      ) ;; exponent == 0

    (if
      (i32.eq (local.get $exponent) (i32.const 1))
      (then
        ;; (call $log_mem_as_utf8 (global.get $debug_label_powreturn_offset) (global.get $debug_label_powreturn_length))
        ;; (call $log_i32_s (local.get $base))

        (return (local.get $base))
        ) ;; then
      ) ;; exponent == 1

    ;; (call $log_mem_as_utf8 (global.get $debug_label_powbase_offset) (global.get $debug_label_powbase_length))
    ;; (call $log_i32_s (local.get $base))

    ;; (call $log_mem_as_utf8 (global.get $debug_label_powexponent_offset) (global.get $debug_label_powexponent_length))
    ;; (call $log_i32_s (local.get $exponent))

    (local.set $result
      (i32.mul
        (call $pow
          (local.get $base)
          (i32.sub
            (local.get $exponent)
            (i32.const 1)
            ) ;; exp - 1
          ) ;; call pow()
        (local.get $base)
        ) ;; mul
      ) ;; set result

    ;; (call $log_mem_as_utf8 (global.get $debug_label_powreturn_offset) (global.get $debug_label_powreturn_length))
    ;; (call $log_i32_s (local.get $result))

    (return (local.get $result))
    ) ;; pow()

  (func $digit_counter (export "digit_counter") (param $number i32) (result i32)
    (local $digit_count i32)
    (local $digit_tmp i32)

    (local.set $digit_count (i32.const 0))
    (local.set $digit_tmp (i32.const 0))

    ;; floor(digit_counter(n))+1 => number of digits in integer
    ;; no log function, log10(n) = x ->  10^x = n
    ;; simpler to just use a loop
    (local.set $digit_tmp (local.get $number))
    (loop $my_loop
      (local.set $digit_tmp (i32.div_u (local.get $digit_tmp) (i32.const 10)))
      (local.set $digit_count (i32.add (local.get $digit_count) (i32.const 1)))

      (br_if $my_loop
        (i32.gt_u (local.get $digit_tmp) (i32.const 0))
        ) ;; br_if
      ) ;; loop

    (return (local.get $digit_count))
    ) ;; digit_counter()
) ;; module
