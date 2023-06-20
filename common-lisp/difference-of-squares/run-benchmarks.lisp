(load "~/.clisprc.lisp")

(ql:quickload "local-time")

(load "./difference-of-squares-test.lisp")

;; Lisp is really fast!
;; Using get-universal-time or local-time:now resulted in all test taking 0 seconds.
;; We need to use milli or micro seconds! Using get-internal-real-time!

(defun now-µs ()
  (get-internal-real-time)
  ) ; real time in microseconds

(loop for style in '("gauss" "reduce" "gauss" "reduce") do

      (defparameter sum-method style)

      (format t "Benchmarking functions using ~A functions:~%~%" style)

      (let ((time-start (now-µs)) (time-stop 0) (n (expt 10 100000)))
        ;; (format t "square-of-sum-~A() result: ~A~%" sum-method (difference-of-squares:square-of-sum n)) ; this adds ~4 seconds to print the huge number
        ;; (sleep 1)
        (difference-of-squares:square-of-sum n)
        (setq time-stop (now-µs))
        (format t " square-of-sum-~A() run time: ~:@d µs for 10^100,000~%" sum-method (- time-stop time-start))
      )

      (let ((time-start (now-µs)) (time-stop 0) (n (expt 10 100000)))
        ;; (format t "sum-of-squares-~A() result: ~A~%" sum-method (difference-of-squares:sum-of-squares n)) ; this adds ~4 seconds to print the huge number
        ;; (sleep 1)
        (difference-of-squares:sum-of-squares n)
        (setq time-stop (now-µs))
        (format t "sum-of-squares-~A() run time: ~:@d µs for 10^100,000~%" sum-method (- time-stop time-start))
      )

      (format t "~%")
  )

(quit)
