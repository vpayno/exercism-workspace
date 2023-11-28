;; https://exercism.org/tracks/wasm/exercises/hamming

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

  ;; test data starts at 1024
  ;;                     v     v      v       v     v        v v            v     v         v v                v
  ;;                     111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
  ;;                     000000000011111111112222222222333333333344444444445555555555666666666677777777778888888
  ;;                     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
  ;;                     ^     ^      ^       ^     ^        ^ ^            ^     ^         ^ ^                ^
  (data (i32.const 100) "first|second|readptr|limit|distance|unequal_length|empty|different|invalid_nucleotide|")
  (global $debug_label_first_offset i32 (i32.const 100))
  (global $debug_label_first_length i32 (i32.const 5))
  (global $debug_label_second_offset i32 (i32.const 106))
  (global $debug_label_second_length i32 (i32.const 6))
  (global $debug_label_readptr_offset i32 (i32.const 113))
  (global $debug_label_readptr_length i32 (i32.const 7))
  (global $debug_label_limit_offset i32 (i32.const 121))
  (global $debug_label_limit_length i32 (i32.const 5))
  (global $debug_label_distance_offset i32 (i32.const 127))
  (global $debug_label_distance_length i32 (i32.const 8))
  (global $debug_label_unequallength_offset i32 (i32.const 136))
  (global $debug_label_unequallength_length i32 (i32.const 14))
  (global $debug_label_equallength_offset i32 (i32.const 138))
  (global $debug_label_equallength_length i32 (i32.const 12))
  (global $debug_label_empty_offset i32 (i32.const 151))
  (global $debug_label_empty_length i32 (i32.const 5))
  (global $debug_label_different_offset i32 (i32.const 157))
  (global $debug_label_different_length i32 (i32.const 9))
  (global $debug_label_invalidnucleotide_offset i32 (i32.const 167))
  (global $debug_label_invalidnucleotide_length i32 (i32.const 18))
  (global $debug_label_validnucleotide_offset i32 (i32.const 169))
  (global $debug_label_validnucleotide_length i32 (i32.const 16))

  ;;
  ;; Calculate the hamming distance between two strings.
  ;;
  ;; @param {i32} firstOffset - The offset of the first string in linear memory.
  ;; @param {i32} firstLength - The length of the first string in linear memory.
  ;; @param {i32} secondOffset - The offset of the second string in linear memory.
  ;; @param {i32} secondLength - The length of the second string in linear memory.
  ;;
  ;; @returns {i32} - The hamming distance between the two strings or -1 if the
  ;;                  strings are not of equal length.
  ;;
  (func (export "compute")
    (param $firstOffset i32) (param $firstLength i32) (param $secondOffset i32) (param $secondLength i32) (result i32)

    (local $limit i32)
    (local $first_readptr i32)
    (local $second_readptr i32)
    (local $distance i32)

    (local.set $limit
      (i32.sub
        (i32.add
          (local.get $firstOffset)
          (local.get $firstLength)
          ) ;; add
        (i32.const 1)
        ) ;; sub
      )
    (local.set $first_readptr (local.get $firstOffset))
    (local.set $second_readptr (local.get $secondOffset))
    (local.set $distance (i32.const 0))

    (call $debug_print_str (global.get $debug_label_first_offset) (global.get $debug_label_first_length))
    (call $debug_print_str (local.get $firstOffset) (local.get $firstLength))
    (call $debug_print_i32u (local.get $firstLength))

    (call $debug_print_str (global.get $debug_label_second_offset) (global.get $debug_label_second_length))
    (call $debug_print_str (local.get $secondOffset) (local.get $secondLength))
    (call $debug_print_i32u (local.get $secondLength))

    (call $debug_print_str (global.get $debug_label_limit_offset) (global.get $debug_label_limit_length))
    (call $debug_print_i32u (local.get $limit))

    (if
      (i32.ne
        (local.get $firstLength)
        (local.get $secondLength)
        ) ;; ne
      (then
        (call $debug_print_str (global.get $debug_label_unequallength_offset) (global.get $debug_label_unequallength_length))
        (call $debug_print_i32u (local.get $firstLength))
        (call $debug_print_i32u (local.get $secondLength))

        (return (global.get $error))
        ) ;; then
      ) ;; if unequal lengths

    (if
      (i32.eq
        (local.get $firstLength)
        (i32.const 0)
        ) ;; eq
      (then
        (call $debug_print_str (global.get $debug_label_empty_offset) (global.get $debug_label_empty_length))
        (call $debug_print_i32u (local.get $firstLength))
        (call $debug_print_i32u (local.get $secondLength))

        (return (local.get $distance))
        ) ;; then
      ) ;; if empty string(s)

    (loop $my_loop
      (if
        (i32.and
          (call $is_nucleotide (i32.load8_u (local.get $first_readptr)))
          (call $is_nucleotide (i32.load8_u (local.get $second_readptr)))
          ) ;; or
        (then
          (call $debug_print_str (global.get $debug_label_validnucleotide_offset) (global.get $debug_label_validnucleotide_length))
          ;; (call $debug_print_i32u (i32.load8_u (local.get $first_readptr)))
          ;; (call $debug_print_i32u (i32.load8_u (local.get $second_readptr)))
          ) ;; then
        (else
          (call $debug_print_str (global.get $debug_label_invalidnucleotide_offset) (global.get $debug_label_invalidnucleotide_length))
          (call $debug_print_i32u (i32.load8_u (local.get $first_readptr)))
          (call $debug_print_i32u (i32.load8_u (local.get $second_readptr)))

          ;; no tests, so it's either a return -1 (error) or the distance so far
          (return (global.get $error))
          ) ;; then
        ) ;; invalid nucleotide?

      (if
        (i32.ne
          (i32.load8_u (local.get $first_readptr))
          (i32.load8_u (local.get $second_readptr))
          ) ;; ne
        (then
          (local.set $distance (i32.add
            (local.get $distance)
            (i32.const 1)
            ) ;; d++
          ) ;; different nucleotides, distance++

          (call $debug_print_str (global.get $debug_label_different_offset) (global.get $debug_label_different_length))
          (call $debug_print_i32u (i32.load8_u (local.get $first_readptr)))
          (call $debug_print_i32u (i32.load8_u (local.get $second_readptr)))

          (call $debug_print_str (global.get $debug_label_readptr_offset) (global.get $debug_label_readptr_length))
          (call $debug_print_i32u (local.get $first_readptr))
          ;; (call $debug_print_i32u (local.get $second_readptr))

          (call $debug_print_str (global.get $debug_label_distance_offset) (global.get $debug_label_distance_length))
          (call $debug_print_i32u (local.get $distance))
          ) ;; then
        ) ;; if different chars

      (local.set $first_readptr
        (i32.add
          (local.get $first_readptr)
          (i32.const 1)
          ) ;; add
        ) ;; first_readptr++

      (local.set $second_readptr
        (i32.add
          (local.get $second_readptr)
          (i32.const 1)
          ) ;; add
        ) ;; second_readptr++

      (br_if $my_loop
        (i32.le_u
          (local.get $first_readptr)
          (local.get $limit)
          ) ;; ge
        ) ;; br_if
      ) ;; loop

    (call $debug_print_str (global.get $debug_label_distance_offset) (global.get $debug_label_distance_length))
    (call $debug_print_i32u (local.get $distance))

    (return (local.get $distance))
  ) ;; compute()

  ;; is the nucleotide valid?
  (func $is_nucleotide (export "is_nucleotide") (param $rune i32) (result i32)
    ;; ACGT only?
    (if
      (i32.eq
        (global.get $rune_A)
        (local.get $rune)
        ) ;; A?
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; A?

    (if
      (i32.eq
        (global.get $rune_C)
        (local.get $rune)
        ) ;; C?
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; A?

    (if
      (i32.eq
        (global.get $rune_G)
        (local.get $rune)
        ) ;; G?
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; A?

    (if
      (i32.eq
        (global.get $rune_T)
        (local.get $rune)
        ) ;; T?
      (then
        (return (global.get $true))
        ) ;; then
      ) ;; A?

    (return (global.get $false))
    ) ;; is_nucleotide()

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
