(module
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
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

  ;;                     v     v     v    v
  ;;                     111111111111111111
  ;;                     000000000011111111
  ;;                     012345678901234567
  ;;                     ^     ^     ^    ^
  (data (i32.const 100) "Pling|Plang|Plong|")

  (global $pling_offset i32 (i32.const 100))
  (global $pling_length i32 (i32.const 5))
  (global $plang_offset i32 (i32.const 106))
  (global $plang_length i32 (i32.const 5))
  (global $plong_offset i32 (i32.const 112))
  (global $plong_length i32 (i32.const 5))

  (global $result_offset i32 (i32.const 118))

  (data (i32.const 2000) "number|sounds|divisible_by_3|divisible_by_5|divisible_by_7|no_sounds|itoa|remainder|reverse|")
  (global $debug_label_number_offset i32 (i32.const 2000))
  (global $debug_label_number_length i32 (i32.const 6))
  (global $debug_label_sounds_offset i32 (i32.const 2007))
  (global $debug_label_sounds_length i32 (i32.const 6))
  (global $debug_label_three_offset i32 (i32.const 2014))
  (global $debug_label_three_length i32 (i32.const 14))
  (global $debug_label_five_offset i32 (i32.const 2029))
  (global $debug_label_five_length i32 (i32.const 14))
  (global $debug_label_seven_offset i32 (i32.const 2044))
  (global $debug_label_seven_length i32 (i32.const 14))
  (global $debug_label_nosounds_offset i32 (i32.const 2059))
  (global $debug_label_nosounds_length i32 (i32.const 9))
  (global $debug_label_itoa_offset i32 (i32.const 2069))
  (global $debug_label_itoa_length i32 (i32.const 4))
  (global $debug_label_remainder_offset i32 (i32.const 2074))
  (global $debug_label_remainder_length i32 (i32.const 9))
  (global $debug_label_reverse_offset i32 (i32.const 2084))
  (global $debug_label_reverse_length i32 (i32.const 7))

  (func (export "convert") (param $number i32) (result i32 i32)
    (local $read_ptr i32)
    (local $read_limit i32)
    (local $write_ptr i32)
    (local $write_length i32)
    (local $remainder i32)
    (local $digit_count i32)
    (local $digit_tmp i32)
    (local $no_sounds i32)
    (local $result_offset i32)

    (local.set $read_ptr (i32.const 0))
    (local.set $read_limit (i32.const 0))
    (local.set $write_ptr (global.get $result_offset))
    (local.set $write_length (i32.const 0))
    (local.set $remainder (i32.const 0))
    (local.set $digit_count (i32.const 0))
    (local.set $digit_tmp (i32.const 0))
    (local.set $no_sounds (global.get $false))
    (local.set $result_offset (global.get $result_offset))

    (call $debug_print_str (global.get $debug_label_number_offset) (global.get $debug_label_number_length))
    (call $debug_print_i32u (local.get $number))

    (if
      (i32.eqz
        (i32.rem_u
          (local.get $number)
          (i32.const 3)
          ) ;; modulo
        ) ;; eqz
      (then
        (call $debug_print_str (global.get $debug_label_three_offset) (global.get $debug_label_three_length))

        ;; destination loc, source loc, source length
        (memory.copy
          (local.get $write_ptr)
          (global.get $pling_offset)
          (global.get $pling_length)
          ) ;; write

        (local.set $write_ptr
          (i32.add (local.get $write_ptr) (global.get $pling_length))
          ) ;; advance write ptr

        (local.set $write_length
          (i32.add (local.get $write_length) (global.get $pling_length))
          ) ;; advance write ptr
        ) ;; then
      ) ;; if number % 3 == 0

    (if
      (i32.eqz
        (i32.rem_u
          (local.get $number)
          (i32.const 5)
          ) ;; modulo
        ) ;; eqz
      (then
        (call $debug_print_str (global.get $debug_label_five_offset) (global.get $debug_label_five_length))

        ;; destination loc, source loc, source length
        (memory.copy
          (local.get $write_ptr)
          (global.get $plang_offset)
          (global.get $plang_length)
          ) ;; write

        (local.set $write_ptr
          (i32.add (local.get $write_ptr) (global.get $plang_length))
          ) ;; advance write ptr

        (local.set $write_length
          (i32.add (local.get $write_length) (global.get $plang_length))
          ) ;; advance write ptr
        ) ;; then
      ) ;; if number % 5 == 0

    (if
      (i32.eqz
        (i32.rem_u
          (local.get $number)
          (i32.const 7)
          ) ;; modulo
        ) ;; eqz
      (then
        (call $debug_print_str (global.get $debug_label_seven_offset) (global.get $debug_label_seven_length))

        ;; destination loc, source loc, source length
        (memory.copy
          (local.get $write_ptr)
          (global.get $plong_offset)
          (global.get $plong_length)
          ) ;; write

        (local.set $write_ptr
          (i32.add (local.get $write_ptr) (global.get $plong_length))
          ) ;; advance write ptr

        (local.set $write_length
          (i32.add (local.get $write_length) (global.get $plong_length))
          ) ;; advance write ptr
        ) ;; then
      ) ;; if number % 7 == 0

    (call $debug_print_str (global.get $debug_label_sounds_offset) (global.get $debug_label_sounds_length))
    (call $debug_print_str (local.get $result_offset) (local.get $write_length))

    (if
      (i32.eqz
        (local.get $write_length)
        ) ;; eqz
      (then
        (call $debug_print_str (global.get $debug_label_itoa_offset) (global.get $debug_label_itoa_length))

        (local.set $no_sounds (global.get $true))

        ;; write_length is also the digit count, not using this
        (;
        ;; floor(log_10(n))+1 => number of digits in integer
        ;; no log function, log_10(n) = x ->  10^x = n
        (local.set $digit_tmp (local.get $number))
        (loop $my_loop
          ;; 42 / 10 => 4
          (local.set $digit_tmp (i32.div_u (local.get $digit_tmp) (i32.const 10)))
          (local.set $digit_count (i32.add (local.get $digit_count) (i32.const 1)))

          (br_if $my_loop
            (i32.gt_u (local.get $digit_tmp) (i32.const 0))
            ) ;; br_if
          ) ;; loop
        ;)

        (local.set $write_length (local.get $digit_count))

        (block $my_break
          (loop $my_loop
            ;; (call $debug_print_i32u (local.get $number))

            ;; 42 % 10 => 2
            (local.set $remainder (i32.rem_u (local.get $number) (i32.const 10)))
            ;; (call $debug_print_str (global.get $debug_label_remainder_offset) (global.get $debug_label_remainder_length))
            ;; (call $debug_print_i32u (local.get $remainder))

            ;; 42 / 10 => 4
            (local.set $number (i32.div_u (local.get $number) (i32.const 10)))
            ;; (call $debug_print_str (global.get $debug_label_number_offset) (global.get $debug_label_number_length))
            ;; (call $debug_print_i32u (local.get $number))

            (if $my_loop
              (i32.eqz (local.get $number))
              (then

                (local.set $write_length
                  (i32.add (local.get $write_length) (i32.const 1))
                  ) ;; advance write ptr

                (br $my_break)
                ) ;; then
              ) ;; guard

            (i32.store8
              (local.get $write_ptr)
              (i32.add (i32.const 48) (local.get $remainder)) ;; ascii shift to turn to a string
              )

            (local.set $write_ptr
              (i32.add (local.get $write_ptr) (i32.const 1))
              ) ;; advance write ptr

            (local.set $write_length
              (i32.add (local.get $write_length) (i32.const 1))
              ) ;; advance write ptr

            (br_if $my_loop
              (i32.and
                (i32.lt_u (local.get $number) (i32.const 10))
                (i32.ge_u (local.get $number) (i32.const 0))
                ) ;; and
              ) ;; br_if
            ) ;; loop
          ) ;; block

        ;; destination loc, source loc, source length
        (i32.store8
          (local.get $write_ptr)
          (i32.add (i32.const 48) (local.get $remainder)) ;; ascii shift to turn to a string
          ) ;; write

        (local.set $write_ptr
          (i32.add (local.get $write_ptr) (i32.const 1))
          ) ;; advance write ptr
        ) ;; then
      ) ;; if no sounds

    (call $debug_print_str (global.get $debug_label_sounds_offset) (global.get $debug_label_sounds_length))
    (call $debug_print_str (local.get $result_offset) (local.get $write_length))

    (call $debug_print_i32u (local.get $result_offset))
    (call $debug_print_i32u (local.get $write_length))

    ;; at this point the numeric string is backwards if it has two or more numbers
    ;; write_length is also the digit count
    (if
      (i32.and
        (i32.eq
          (local.get $no_sounds)
          (global.get $true)
          ) ;; eq
        (i32.gt_u
          (local.get $write_length)
          (i32.const 1)
          ) ;; eq
        ) ;; and
        (then
          (call $debug_print_str (global.get $debug_label_reverse_offset) (global.get $debug_label_reverse_length))

          (local.set $read_limit (local.get $result_offset))

          (local.set $result_offset
            (i32.add (local.get $result_offset) (local.get $write_length))
            ) ;; shift the result offset by write length

          (local.set $read_ptr (i32.sub (local.get $result_offset) (i32.const 1)))

          (loop $my_loop
            ;; destination loc, source loc, source length
            (memory.copy
              (local.get $write_ptr)
              (local.get $read_ptr)
              (i32.const 1)
              ) ;; write

            (local.set $write_ptr
              (i32.add (local.get $write_ptr) (i32.const 1))
              ) ;; advance write ptr

            (local.set $read_ptr
              (i32.sub (local.get $read_ptr) (i32.const 1))
              ) ;; advance read ptr

            (br_if $my_loop
              (i32.gt_u (local.get $read_ptr) (local.get $read_limit))
              ) ;; br_if
            ) ;; loop

            (memory.copy
              (local.get $write_ptr)
              (local.get $read_ptr)
              (i32.const 1)
              ) ;; write

            (local.set $write_ptr
              (i32.add (local.get $write_ptr) (i32.const 1))
              ) ;; advance write ptr
          ) ;; then
      ) ;; if

    (call $debug_print_str (global.get $debug_label_sounds_offset) (global.get $debug_label_sounds_length))
    (call $debug_print_str (local.get $result_offset) (local.get $write_length))

    (call $debug_print_i32u (local.get $result_offset))
    (call $debug_print_i32u (local.get $write_length))

    (return (local.get $result_offset) (local.get $write_length))
  ) ;; convert()

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
        (i32.and
          (i32.eq
            (global.get $debug)
            (global.get $true)
            ) ;; eq
          (i32.gt_u
            (local.get $length)
            (i32.const 0)
            ) ;; eq
          ) ;; and
        (then
          (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
          ) ;; then
        (else
          (call $debug_print_str (global.get $debug_label_nosounds_offset) (global.get $debug_label_nosounds_length))
          ) ;; else
        ) ;; if debugging
    ) ;; debug_print_str()
) ;; module
