;; https://exercism.org/tracks/wasm/exercises

(module
  ;; https://github.com/exercism/wasm-lib
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  (import "console" "log_f32" (func $log_f32 (param f32)))
  ;; (import "console" "log_i32_s" (func $log_i32_s (param i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  ;; (import "console" "log_i64_u" (func $log_i64_u (param i64)))
  ;; string log example
  ;; (call $log_mem_as_utf8 (local.get $offset) (local.get $length))
  ;; i32 log example
  ;; (call $log_i32_u (local.get $number))

  (memory (export "mem") 1)

  ;; 0=>false/disable, 1=>true/enable
  (global $debug i32 (i32.const 1))

  (global $error i32 (i32.const 0))

  ;;                      v v v     v        v
  ;;                      00000000001111111111
  ;;                      01234567890123456789
  ;;                      ^ ^ ^     ^        ^
  (data (i32.const 2000) "x|y|score|distance|")
  (global $debug_label_x_offset i32 (i32.const 2000))
  (global $debug_label_x_length i32 (i32.const 1))
  (global $debug_label_y_offset i32 (i32.const 2002))
  (global $debug_label_y_length i32 (i32.const 1))
  (global $debug_label_score_offset i32 (i32.const 2004))
  (global $debug_label_score_length i32 (i32.const 5))
  (global $debug_label_distance_offset i32 (i32.const 2010))
  (global $debug_label_distance_length i32 (i32.const 8))

  ;; calculcate dart board score
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $score i32)
    (local $distance f32)

    (local.set $distance (call $hypot (local.get $x) (local.get $y)))

    (call $debug_print_str (global.get $debug_label_x_offset) (global.get $debug_label_x_length))
    (call $debug_print_f32 (local.get $x))

    (call $debug_print_str (global.get $debug_label_y_offset) (global.get $debug_label_y_length))
    (call $debug_print_f32 (local.get $y))

    (call $debug_print_str (global.get $debug_label_distance_offset) (global.get $debug_label_distance_length))
    (call $debug_print_f32 (local.get $distance))

    (call $debug_print_str (global.get $debug_label_score_offset) (global.get $debug_label_score_length))

    (if
      (f32.le
        (local.get $distance)
        (f32.const 1.0)
        ) ;; <= 1
      (then
        (local.set $score (i32.const 10))
        (call $debug_print_i32u (local.get $score))

        (return (local.get $score))
        ) ;; then
      ) ;; if distance <= 1.0

    (if
      (f32.le
        (local.get $distance)
        (f32.const 5.0)
        ) ;; <= 5
      (then
        (local.set $score (i32.const 5))
        (call $debug_print_i32u (local.get $score))

        (return (local.get $score))
        ) ;; then
      ) ;; if distance <= 5.0

    (if
      (f32.le
        (local.get $distance)
        (f32.const 10.0)
        ) ;; <= 10
      (then
        (local.set $score (i32.const 1))
        (call $debug_print_i32u (local.get $score))

        (return (local.get $score))
        ) ;; then
      ) ;; if distance <= 10.0

    (call $debug_print_i32u (local.get $score))

    (return (local.get $score))
  )

  ;; calculate distance between (0,0) and (x,y)
  ;; d=√( (x_2-x_1)²+(y_2-y_1)² )
  ;; d=√( (a)²+(b)² )
  ;; d=√(c)
  (func $hypot (export "hypot") (param $x2 f32) (param $y2 f32) (result f32)
    (local $x1 f32)
    (local $y1 f32)

    (local $a f32)
    (local $b f32)
    (local $c f32)
    (local $result f32)

    (local.get $x1 (f32.const 0))
    (local.get $y1 (f32.const 0))

    ;; sub 0 is a bit silly, keeping it here for completeness
    (local.set $a
      (f32.sub
        (local.get $x2)
        (local.get $x1)
        ) ;; x2 - x1
      ) ;; set a

    ;; sub 0 is a bit silly, keeping it here for completeness
    (local.set $b
      (f32.sub
        (local.get $y2)
        (local.get $y1)
        ) ;; y2 - y1
      ) ;; set b

    (local.set $c
      (f32.add
        (f32.mul
          (local.get $a)
          (local.get $a)
          ) ;; a^2
        (f32.mul
          (local.get $b)
          (local.get $b)
          ) ;; b^2
        ) ;; a^2+b^2
      ) ;; a^2+b^2

    (local.set $result
      (f32.sqrt
        (local.get $c)
      ) ;; √c
      ) ;; set c

    (return (local.get $result))
  ) ;; hypot()

  ;; print f32 if debugging is enabled
  (func $debug_print_f32 (export "debug_print_f32") (param $value f32)
      (if
        (global.get $debug)
        (then
          (call $log_f32 (local.get $value))
          ) ;; then
        ) ;; if debugging
    ) ;; debug_print_f32()

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
