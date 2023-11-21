;; https://exercism.org/tracks/wasm/exercises/rna-transcription

(module
  ;; https://github.com/exercism/wasm-lib
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  ;; (import "console" "log_f32" (func $log_f32 (param f32)))
  ;; (import "console" "log_i32_s" (func $log_i32_s (param i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))
  (memory (export "mem") 1)

  (global $false i32 (i32.const 0))
  (global $true  i32 (i32.const 1))

  ;; 0=>false/disable, 1=>true/enable
  (global $debug i32 (i32.const 1))

  (global $error i32 (i32.const -1))

  (global $rune_A i32 (i32.const 65))
  (global $rune_C i32 (i32.const 67))
  (global $rune_G i32 (i32.const 71))
  (global $rune_T i32 (i32.const 84))
  (global $rune_U i32 (i32.const 85))

  ;; test data starts at 64, ends at 196 (reused as output)
  ;;                     v    v   v      v     v     v     v
  ;;                     11111111111111111111111111111111111
  ;;                     00000000000000000000000000000000000
  ;;                     00000000001111111111222222222233333
  ;;                     01234567890123456789012345678901234
  ;;                     ^    ^   ^      ^     ^     ^     ^
  (data (i32.const 1000) "dna|rna|cursor|limit|error|empty|")
  (global $debug_label_dna_offset i32 (i32.const 1000))
  (global $debug_label_dna_length i32 (i32.const 3))
  (global $debug_label_rna_offset i32 (i32.const 1004))
  (global $debug_label_rna_length i32 (i32.const 3))
  (global $debug_label_cursor_offset i32 (i32.const 1009))
  (global $debug_label_cursor_length i32 (i32.const 6))
  (global $debug_label_limit_offset i32 (i32.const 1016))
  (global $debug_label_limit_length i32 (i32.const 5))
  (global $debug_label_error_offset i32 (i32.const 1022))
  (global $debug_label_error_length i32 (i32.const 5))
  (global $debug_label_empty_offset i32 (i32.const 1027))
  (global $debug_label_empty_length i32 (i32.const 5))

  ;;
  ;; Convert a string of DNA to RNA
  ;;
  ;; @param {i32} offset - The offset of the DNA string in linear memory
  ;; @param {i32} length - The length of the DNA string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the RNA string in linear memory
  ;;
  (func (export "toRna") (param $offset i32) (param $length i32) (result i32 i32)
    (local $cursor i32)
    (local $limit i32)

    (local.set $cursor (local.get $offset))
    (local.set $limit
      (i32.sub
        (i32.add
          (local.get $offset)
          (local.get $length)
          ) ;; add
        (i32.const 1)
        ) ;; sub
      )

    (call $debug_print_str (global.get $debug_label_dna_offset) (global.get $debug_label_dna_length))
    (call $debug_print_str (local.get $offset) (local.get $length))
    (call $debug_print_i32u (local.get $length))

    (if
      (i32.eq
        (local.get $length)
        (i32.const 0)
        ) ;; eq
      (then
        (call $debug_print_str (global.get $debug_label_empty_offset) (global.get $debug_label_empty_length))
        (call $debug_print_i32u (local.get $length))

        ;; (return (global.get $debug_label_error_offset) (global.get $debug_label_error_length))
        (return (local.get $offset) (local.get $length))
        ) ;; then
      ) ;; if empty string(s)

    (loop $my_loop
      ;; write location, data
      (i32.store8
        (local.get $cursor)
        (call $dna_to_rna (i32.load8_u (local.get $cursor)))
        ) ;; overwrite dna nucleotie with it's rna compliment

      (local.set $cursor
        (i32.add
          (local.get $cursor)
          (i32.const 1)
          ) ;; add
        ) ;; cursor++

      (br_if $my_loop
        (i32.le_u
          (local.get $cursor)
          (local.get $limit)
          ) ;; ge
        ) ;; br_if
      ) ;; loop

    (call $debug_print_str (global.get $debug_label_rna_offset) (global.get $debug_label_rna_length))
    (call $debug_print_str (local.get $offset) (local.get $length))
    (call $debug_print_i32u (local.get $length))

    (return (local.get $offset) (local.get $length))
  ) ;; toRna()

  ;; returns the dna nucleotide rna compliment
  (func $dna_to_rna (export "dna_to_rna") (param $rune i32) (result i32)
    (if
      (i32.eq
        (global.get $rune_A)
        (local.get $rune)
        ) ;; A?
      (then
        (return (global.get $rune_U))
        ) ;; then
      ) ;; A?

    (if
      (i32.eq
        (global.get $rune_C)
        (local.get $rune)
        ) ;; C?
      (then
        (return (global.get $rune_G))
        ) ;; then
      ) ;; C?

    (if
      (i32.eq
        (global.get $rune_G)
        (local.get $rune)
        ) ;; G?
      (then
        (return (global.get $rune_C))
        ) ;; then
      ) ;; G?

    (if
      (i32.eq
        (global.get $rune_T)
        (local.get $rune)
        ) ;; T?
      (then
        (return (global.get $rune_A))
        ) ;; then
      ) ;; T?

    (return (global.get $error))
    ) ;; dna_to_rna()

  ;; print i32u if debugging is enabled
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

  ;; print utf-8 str if debugging is enabled
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
