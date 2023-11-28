;; https://exercism.org/tracks/wasm/exercises/rotational-cipher

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

  (global $lc_start i32 (i32.const 97))
  (global $lc_end i32 (i32.const 122))
  (global $uc_start i32 (i32.const 65))
  (global $uc_end i32 (i32.const 90))
  (global $alpha_size i32 (i32.const 26))

  ;; test data starts at 64, ends at 319 (reused as output)

  ;; ascii - 65- 90 A-Z
  ;; ascii - 91-116 a-z
  ;;                     00000000001111111111222222
  ;;                     01234567890123456789012345
  (data (i32.const 500) "abcdefghijklmnopqrstuvwxyz")

  ;;                      v      v      v
  ;;                      11111111111111111111111111111111111
  ;;                      00000000000000000000000000000000000
  ;;                      00000000001111111111222222222233333
  ;;                      01234567890123456789012345678901234
  ;;                      ^     ^      ^
  (data (i32.const 1000) "plain|cipher|empty|")
  (global $debug_label_plain_offset i32 (i32.const 1000))
  (global $debug_label_plain_length i32 (i32.const 5))
  (global $debug_label_cipher_offset i32 (i32.const 1006))
  (global $debug_label_cipher_length i32 (i32.const 6))
  (global $debug_label_empty_offset i32 (i32.const 1013))
  (global $debug_label_empty_length i32 (i32.const 5))

  ;;
  ;; Encrypt plaintext using the rotational cipher.
  ;;
  ;; @param {i32} textOffset - The offset of the plaintext input in linear memory.
  ;; @param {i32} textLength - The length of the plaintext input in linear memory.
  ;; @param {i32} shiftKey - The shift key to use for the rotational cipher.
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the ciphertext output in linear memory.
  ;;
  (func (export "rotate") (param $textOffset i32) (param $textLength i32) (param $shiftKey i32) (result i32 i32)
    (local $cursor i32)
    (local $limit i32)
    (local $rune_plain i32)
    (local $rune_encrypted i32)

    (local.set $cursor (local.get $textOffset))
    (local.set $limit
      (i32.sub
        (i32.add
          (local.get $textOffset)
          (local.get $textLength)
          ) ;; add
        (i32.const 1)
        ) ;; sub
      )

    (call $debug_print_str (global.get $debug_label_plain_offset) (global.get $debug_label_plain_length))
    (call $debug_print_str (local.get $textOffset) (local.get $textLength))
    (call $debug_print_i32u (local.get $textLength))

    (if
      (i32.eqz
        (local.get $textLength)
        ) ;; eq
      (then
        (call $debug_print_str (global.get $debug_label_empty_offset) (global.get $debug_label_empty_length))
        (call $debug_print_i32u (local.get $textLength))

        (return (local.get $textOffset) (local.get $textLength))
        ) ;; then
      ) ;; if empty string(s)

    (loop $my_loop
      (local.set $rune_plain
        (i32.load8_u (local.get $cursor))
        ) ;; get plain letter

      (local.set $rune_encrypted
        (local.get $rune_plain)
        ) ;; set initial encrypted char

      (if
        (i32.and
          (i32.ge_u (local.get $rune_plain) (global.get $uc_start))
          (i32.le_u (local.get $rune_plain) (global.get $uc_end))
          ) ;; and
        (then
          (local.set $rune_encrypted
            (i32.add
              (i32.rem_u
                (i32.add
                  (i32.sub
                    (local.get $rune_plain)
                    (global.get $uc_start)
                    ) ;; sub
                  (local.get $shiftKey)
                  ) ;; add
                (global.get $alpha_size)
                ) ;; rem
              (global.get $uc_start)
              ) ;; add
            ) ;; set rune_encrypted
          ) ;; then
        ) ;; rotate uppercase letter

      (if
        (i32.and
          (i32.ge_u (local.get $rune_plain) (global.get $lc_start))
          (i32.le_u (local.get $rune_plain) (global.get $lc_end))
          ) ;; and
        (then
          (local.set $rune_encrypted
            (i32.add
              (i32.rem_u
                (i32.add
                  (i32.sub
                    (local.get $rune_plain)
                    (global.get $lc_start)
                    ) ;; sub
                  (local.get $shiftKey)
                  ) ;; add
                (global.get $alpha_size)
                ) ;; rem
              (global.get $lc_start)
              ) ;; add
            ) ;; set rune_encrypted
          ) ;; then
        ) ;; rotate lowercase letter

      (i32.store8
        (local.get $cursor)
        (local.get $rune_encrypted)
        ) ;; write encrypted letter

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
          ) ;; le
        ) ;; br_if
      ) ;; loop

    (call $debug_print_str (global.get $debug_label_cipher_offset) (global.get $debug_label_cipher_length))
    (call $debug_print_str (local.get $textOffset) (local.get $textLength))
    (call $debug_print_i32u (local.get $textLength))

    (return (local.get $textOffset) (local.get $textLength))
  ) ;; rotate()

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
