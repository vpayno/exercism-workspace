;; https://exercism.org/tracks/wasm/exercises/reverse-string

(module
  (import "console" "log_mem_as_utf8" (func $log_mem_as_utf8 (param $byteOffset i32) (param $length i32)))
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))

  (memory (export "mem") 1)

  (func (export "reverseString") (param $offset i32) (param $length i32) (result i32 i32)
    (local $read_ptr i32)
    (local $write_ptr i32)
    (local $return_offset i32)
    (local $return_length i32)

    ;; return zeros if null string
    (if (i32.eqz (local.get $length))
      (return (i32.const 0) (i32.const 0))
      )

    ;; return same offset and length if length is 1
    (if (i32.eq (local.get $length) (i32.const 1))
      (return (local.get $offset) (local.get $length))
      )

    ;; save return offset
    (local.set $return_offset
      (i32.add (local.get $offset) (local.get $length))
      )

    ;; save return length
    (local.set $return_length (local.get $length))

    ;; read_ptr set to offset+length-1
    (local.set $read_ptr
      (i32.sub
        (i32.add (local.get $offset) (local.get $length))
        (i32.const 1)
        )
      )

    ;; write_ptr set to offset+length
    (local.set $write_ptr
      (i32.add (local.get $offset) (local.get $length))
      )

    ;;(call $log_i32_u (local.get $offset))
    ;;(call $log_i32_u (local.get $length))
    ;;(call $log_i32_u (local.get $read_ptr))
    ;;(call $log_i32_u (local.get $write_ptr))
    (call $log_mem_as_utf8 (local.get $offset) (local.get $length))

    ;; loop - copy ($offset + $length - 0) to $(offset + $length + 1)
    (loop $my_loop

      ;; get byte at read_ptr and push it to write_ptr
      ;; destination loc, source loc, source length
      ;; both of these do the same thing
      (memory.copy
        (local.get $write_ptr)
        (local.get $read_ptr)
        (i32.const 1)
        )
      ;;(i32.store
        ;;(local.get $write_ptr)
        ;;(i32.load (local.get $read_ptr))
        ;;)

      ;;(call $log_mem_as_utf8 (local.get $write_ptr) (i32.const 1))

      ;; decrement read_ptr
      (local.set $read_ptr
        (i32.sub (local.get $read_ptr) (i32.const 1))
        )

      ;; increment write_ptr
      (local.set $write_ptr
        (i32.add (local.get $write_ptr) (i32.const 1))
        )

      ;;(call $log_i32_u (local.get $read_ptr))
      ;;(call $log_i32_u (local.get $write_ptr))

      ;; break if read_ptr <= offset
      (br_if $my_loop
        (i32.le_u
          (local.get $offset)
          (local.get $read_ptr)
          )
        )

      ) ;; loop

    (call $log_mem_as_utf8 (local.get $return_offset) (local.get $return_length))

    (return
      (local.get $return_offset)
      (local.get $return_length)
      )
  )
)
