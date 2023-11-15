;; https://exercism.org/tracks/wasm/exercises/two-fer

(module
  (memory (export "mem") 1)

  ;; default return value/string
  ;;                   000000000011111111112222
  ;;                   012345678901234567890123
  (data (i32.const 0) "One for you, one for me.")
  (global $data_length i32 (i32.const 24))

  (func (export "twoFer") (param $offset i32) (param $length i32) (result i32 i32)
    (local $result_offset i32)

    (local.set $result_offset (i32.const 24))

    ;; return the default string when there input is zero-length
    (if (i32.eqz (local.get $length))
      (return (i32.const 0) (global.get $data_length))
      )

    ;; copy "One for ", offset 24+8=>32
    (memory.copy (local.get $result_offset) (i32.const 0) (i32.const 8))

    ;; copy input string after "One for ", offset 32+$length
    (memory.copy (i32.const 32) (local.get $offset) (local.get $length))

    ;; copy the end of the default string after the function input
    (memory.copy
      ;; new offset =>32+$length
      (i32.add (i32.const 32) (local.get $length))

      ;; copy ", one for me." to the end off 32+$length
      (i32.const 11) (i32.const 13)
      )

    ;; return the new string
    (return
      (i32.const 24)
      (i32.add (i32.const 21) (local.get $length))
      )
  )
)
