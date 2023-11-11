;; https://exercism.org/tracks/wasm/exercises/nucleotide-count

(module
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  (global $a_offset i32 (i32.const 1000))
  (global $c_offset i32 (i32.const 1001))
  (global $g_offset i32 (i32.const 1002))
  (global $t_offset i32 (i32.const 1003))

  (global $false i32 (i32.const 0))
  (global $true  i32 (i32.const 1))

  ;; 0=>false/disable, 1=>true/enable
  (global $debug i32 (i32.const 0))

  (data (i32.const 1000) "ACGT")
  (global $data_length i32 (i32.const 4))

  (data (i32.const 2000) "ERROR")
  (global $error_offset i32 (i32.const 2000))
  (global $error_length i32 (i32.const 5))

  (data (i32.const 2005) "NOT_A_MATCH")
  (global $not_a_match_offset i32 (i32.const 2005))
  (global $not_a_match_length i32 (i32.const 11))
  (global $match_offset i32 (i32.const 2011))
  (global $match_length i32 (i32.const 5))

  (data (i32.const 2016) "SEQUENCE")
  (global $title_offset i32 (i32.const 2016))
  (global $title_length i32 (i32.const 8))

  (data (i32.const 2024) "CHECKING")
  (global $checking_offset i32 (i32.const 2024))
  (global $checking_length i32 (i32.const 8))

  (func (export "countNucleotides") (param $sequence_offset i32) (param $sequence_length i32) (result i32 i32 i32 i32)
    (local $sequence_ptr i32)
    (local $found i32)

    (local $a_count i32)
    (local $c_count i32)
    (local $g_count i32)
    (local $t_count i32)

    (local $error i32)

    (local.set $sequence_ptr (local.get $sequence_offset))

    (local.set $a_count (i32.const 0))
    (local.set $c_count (i32.const 0))
    (local.set $g_count (i32.const 0))
    (local.set $t_count (i32.const 0))

    (local.set $error (i32.const -1))

    (if
      (i32.eq
        (local.get $sequence_length)
        (i32.const 0)
        ) ;; eq
      (then
        (return
          (local.get $a_count)
          (local.get $c_count)
          (local.get $g_count)
          (local.get $t_count)
          ) ;; return
        ) ;; then
      ) ;; if other

    (call $debug_print_str (global.get $title_offset) (global.get $title_length))
    (call $debug_print_str (local.get $sequence_offset) (local.get $sequence_length))

    (loop $my_loop
      (local.set $found (global.get $false))

      (call $debug_print_str (global.get $checking_offset) (global.get $checking_length))
      (call $debug_print_str (local.get $sequence_ptr) (i32.const 1))

      (call $debug_print_str (global.get $a_offset) (i32.const 1))
      (if
        (i32.eq
          (i32.load8_u (global.get $a_offset))
          (i32.load8_u (local.get $sequence_ptr))
          ) ;; eq
        (then
          (local.set $a_count (i32.add (local.get $a_count) (i32.const 1)))
          (local.set $found (global.get $true))

          (call $debug_print_str (global.get $match_offset) (global.get $match_length))
          (call $debug_print_i32u (local.get $a_count))
          ) ;; then
        (else
          (call $debug_print_str (global.get $not_a_match_offset) (global.get $not_a_match_length))
          ) ;;
        ) ;; if a

      (call $debug_print_str (global.get $c_offset) (i32.const 1))
      (if
        (i32.eq
          (i32.load8_u (global.get $c_offset))
          (i32.load8_u (local.get $sequence_ptr))
          ) ;; eq
        (then
          (local.set $c_count (i32.add (local.get $c_count) (i32.const 1)))
          (local.set $found (global.get $true))

          (call $debug_print_str (global.get $match_offset) (global.get $match_length))
          (call $debug_print_i32u (local.get $c_count))
          ) ;; then
        (else
          (call $debug_print_str (global.get $not_a_match_offset) (global.get $not_a_match_length))
          ) ;;
        ) ;; if c

      (call $debug_print_str (global.get $g_offset) (i32.const 1))
      (if
        (i32.eq
          (i32.load8_u (global.get $g_offset))
          (i32.load8_u (local.get $sequence_ptr))
          ) ;; eq
        (then
          (local.set $g_count (i32.add (local.get $g_count) (i32.const 1)))
          (local.set $found (global.get $true))

          (call $debug_print_str (global.get $match_offset) (global.get $match_length))
          (call $debug_print_i32u (local.get $g_count))
          ) ;; then
        (else
          (call $debug_print_str (global.get $not_a_match_offset) (global.get $not_a_match_length))
          ) ;;
        ) ;; if g

      (call $debug_print_str (global.get $t_offset) (i32.const 1))
      (if
        (i32.eq
          (i32.load8_u (global.get $t_offset))
          (i32.load8_u (local.get $sequence_ptr))
          ) ;; eq
        (then
          (local.set $t_count (i32.add (local.get $t_count) (i32.const 1)))
          (local.set $found (global.get $true))

          (call $debug_print_str (global.get $match_offset) (global.get $match_length))
          (call $debug_print_i32u (local.get $t_count))
          ) ;; then
        (else
          (call $debug_print_str (global.get $not_a_match_offset) (global.get $not_a_match_length))
          ) ;;
        ) ;; if t

      (if
        (i32.eq
          (local.get $found)
          (global.get $false)
          ) ;; eq
        (then
          (call $debug_print_str (global.get $error_offset) (global.get $error_length))
          (call $debug_print_str (local.get $sequence_ptr) (i32.const 1))
          (call $debug_print_i32u (local.get $sequence_ptr))
          (call $debug_print_i32u (local.get $sequence_length))

          (return
            (local.get $error)
            (local.get $error)
            (local.get $error)
            (local.get $error)
            ) ;; return
          ) ;; then
        ) ;; if other

      (local.set $sequence_ptr (i32.add (local.get $sequence_ptr) (i32.const 1)))

      (call $debug_print_i32u (local.get $sequence_ptr))

      ;; break if false
      (br_if $my_loop
        (i32.lt_u
          (local.get $sequence_ptr)
          (i32.add (local.get $sequence_offset) (local.get $sequence_length))
          ) ;; ge
        ) ;; br_if
      ) ;; loop

    (return
      (local.get $a_count)
      (local.get $c_count)
      (local.get $g_count)
      (local.get $t_count)
    )
  )

  (func $debug_print_i32u (export "debug_print_i32u") (param $value i32)
      (if
        (i32.eq
          (global.get $debug)
          (global.get $true)
          ) ;; eq
        (then
          (call $log_i32_u (local.get $value))
          ) ;; then
        ) ;; if debugging
    ) ;; debug_print_i32u()

  (func $debug_print_str (export "debug_print_str") (param $offset i32) (param $length i32)
      (if
        (i32.eq
          (global.get $debug)
          (global.get $true)
          ) ;; eq
        (then
          (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
          ) ;; then
        ) ;; if debugging
    ) ;; debug_print_str()
) ;; module
