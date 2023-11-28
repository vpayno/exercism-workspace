;; https://exercism.org/tracks/wasm/exercises/resistor-color

(module
  ;; (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  ;; (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  (global $colors_offset i32 (i32.const 100))
  (global $colors_length i32 (i32.const 58))

  ;;                     v     v     v   v      v      v     v    v      v    v
  ;;                     1111111111111111111111111111111111111111111111111111111111
  ;;                     0000000000111111111122222222223333333333444444444455555555
  ;;                     0123456789012345678901234567890123456789012345678901234567
  ;;                     ^     ^     ^   ^      ^      ^     ^    ^      ^    ^
  (data (i32.const 100) "black,brown,red,orange,yellow,green,blue,violet,grey,white")

  (global $black_offset  i32 (i32.const 100))
  (global $brown_offset  i32 (i32.const 106))
  (global $red_offset    i32 (i32.const 112))
  (global $orange_offset i32 (i32.const 116))
  (global $yellow_offset i32 (i32.const 123))
  (global $green_offset  i32 (i32.const 130))
  (global $blue_offset   i32 (i32.const 136))
  (global $violet_offset i32 (i32.const 141))
  (global $grey_offset   i32 (i32.const 148))
  (global $white_offset  i32 (i32.const 153))

  (global $black_length  i32 (i32.const 5))
  (global $brown_length  i32 (i32.const 5))
  (global $red_length    i32 (i32.const 3))
  (global $orange_length i32 (i32.const 6))
  (global $yellow_length i32 (i32.const 6))
  (global $green_length  i32 (i32.const 5))
  (global $blue_length   i32 (i32.const 4))
  (global $violet_length i32 (i32.const 6))
  (global $grey_length   i32 (i32.const 4))
  (global $white_length  i32 (i32.const 5))

  (global $error_value   i32 (i32.const -1))
  (global $black_value   i32 (i32.const 0))
  (global $brown_value   i32 (i32.const 1))
  (global $red_value     i32 (i32.const 2))
  (global $orange_value  i32 (i32.const 3))
  (global $yellow_value  i32 (i32.const 4))
  (global $green_value   i32 (i32.const 5))
  (global $blue_value    i32 (i32.const 6))
  (global $violet_value  i32 (i32.const 7))
  (global $grey_value    i32 (i32.const 8))
  (global $white_value   i32 (i32.const 9))

  (global $false i32 (i32.const 0))
  (global $true  i32 (i32.const 1))

  ;; Return buffer of comma separated colors
  ;; black,brown,red,orange,yellow,green,blue,violet,grey,white
  (func (export "colors") (result i32 i32)
    ;; (call $log_mem_as_utf8 (global.get $colors_offset) (global.get $colors_length))

    (return (global.get $colors_offset) (global.get $colors_length))
  ) ;; colors()

  ;; Called each time a module is initialized
  ;; Can be used to populate globals similar to a constructor
  (func $initialize)
  (start $initialize)

  ;; Given a valid resistor color, returns the associated value
  (func (export "colorCode") (param $offset i32) (param $length i32) (result i32)
    ;; (call $log_mem_as_utf8 (global.get $colors_offset) (global.get $colors_length))
    ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $black_offset) (global.get $black_length)
        ) ;; str_cmp
        (return (global.get $black_value))
      ) ;; if black

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $brown_offset) (global.get $brown_length)
        ) ;; str_cmp
        (return (global.get $brown_value))
      ) ;; if brown

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $red_offset) (global.get $red_length)
        ) ;; str_cmp
        (return (global.get $red_value))
      ) ;; if red

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $orange_offset) (global.get $orange_length)
        ) ;; str_cmp
        (return (global.get $orange_value))
      ) ;; if orange

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $yellow_offset) (global.get $yellow_length)
        ) ;; str_cmp
        (return (global.get $yellow_value))
      ) ;; if yellow

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $green_offset) (global.get $green_length)
        ) ;; str_cmp
        (return (global.get $green_value))
      ) ;; if green

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $blue_offset) (global.get $blue_length)
        ) ;; str_cmp
        (return (global.get $blue_value))
      ) ;; if blue

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $violet_offset) (global.get $violet_length)
        ) ;; str_cmp
        (return (global.get $violet_value))
      ) ;; if violet

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $grey_offset) (global.get $grey_length)
        ) ;; str_cmp
        (return (global.get $grey_value))
      ) ;; if grey

    (if
      (call $str_cmp
        (local.get $offset) (local.get $length)
        (global.get $white_offset) (global.get $white_length)
        ) ;; str_cmp
        (return (global.get $white_value))
      ) ;; if white

    (return (global.get $error_value))
  ) ;; colorCode()

  ;; Called to compare two strings
  (func $str_cmp (export "str_cmp") (param $offset_left i32) (param $length_left i32) (param $offset_right i32) (param $length_right i32) (result i32)
    (local $index_left i32)
    (local $index_right i32)
    (local $limit i32)

    ;; (call $log_mem_as_utf8 (local.get $offset_left) (local.get $length_left))

    (if (i32.ne (local.get $length_left) (local.get $length_right))
      (then
        ;; (call $log_mem_as_utf8 (local.get $offset_right) (local.get $length_right))

        (return (global.get $false))
        ) ;; then
      ) ;; if lengths ne

    (local.set $index_left (local.get $offset_left))
    (local.set $index_right (local.get $offset_right))
    (local.set $limit (i32.add (local.get $offset_left) (local.get $length_left)))

    (loop $my_loop
      ;; (call $log_i32_u (local.get $index_left))
      ;; (call $log_i32_u (local.get $index_right))

      (if
        (i32.ne
          (i32.load8_u (local.get $index_left))
          (i32.load8_u (local.get $index_right))
          ) ;; ne
        (then
          ;; (call $log_mem_as_utf8 (local.get $offset_right) (local.get $length_right))

          (return (global.get $false))
          ) ;; then
        ) ;; if

      (local.set $index_left
        (i32.add (local.get $index_left) (i32.const 1))
        ) ;; index_left++
      (local.set $index_right
        (i32.add (local.get $index_right) (i32.const 1))
        ) ;; index_right++

      (br_if $my_loop
        (i32.lt_u
          (local.get $index_left)
          (local.get $limit)
          ) ;; lt
        ) ;; br_if
      ) ;; loop

    ;; (call $log_mem_as_utf8 (local.get $offset_right) (local.get $length_right))

    (return (global.get $true))
    ) ;; str_cmp()
) ;; module
