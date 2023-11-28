;; https://exercism.org/tracks/wasm/exercises/pop-count

(module
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  ;; 0=>false/disable, 1=>true/enable
  (global $debug i32 (i32.const 1))

  (data (i32.const 2000) "number|egg_count|bit")
  (global $debug_label_number_offset i32 (i32.const 2000))
  (global $debug_label_number_length i32 (i32.const 6))
  (global $debug_label_eggcount_offset i32 (i32.const 2007))
  (global $debug_label_eggcount_length i32 (i32.const 9))
  (global $debug_label_bit_offset i32 (i32.const 2017))
  (global $debug_label_bit_length i32 (i32.const 3))

  (func (export "eggCount") (param $number i32) (result i32)
    (local $egg_count i32)

    (call $debug_print_str (global.get $debug_label_number_offset) (global.get $debug_label_number_length))
    (call $debug_print_i32u (local.get $number))

    (local.set $egg_count (i32.popcnt (local.get $number)))

    (call $debug_print_str (global.get $debug_label_eggcount_offset) (global.get $debug_label_eggcount_length))
    (call $debug_print_i32u (local.get $egg_count))

    (return (local.get $egg_count))
  ) ;; eggCount()

  ;; print i32u if debugging is enabled
  (func $debug_print_i32u (export "debug_print_i32u") (param $value i32)
      (if
        (global.get $debug)
        (then
          (call $log_i32_u (local.get $value))
          ) ;; then
        ) ;; if debugging
    ) ;; debug_print_i32u()

  ;; print utf-8 str if debugging is enabled
  (func $debug_print_str (export "debug_print_str") (param $offset i32) (param $length i32)
      (if
        (global.get $debug)
        (then
          (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
          ) ;; then
        ) ;; if debugging
    ) ;; debug_print_str()
) ;; module
