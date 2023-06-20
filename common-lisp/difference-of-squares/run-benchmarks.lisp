(load "~/.clisprc.lisp")

(ql:quickload "local-time")

(load "./difference-of-squares-test.lisp")

;; Lisp is really fast!
;; Using get-universal-time or local-time:now resulted in all test taking 0 seconds.
;; We need to use milli or micro seconds! Using get-internal-real-time!

(defun now-µs ()
  (get-internal-real-time)
  ) ; real time in microseconds

(loop for style in '("gauss" "reduce") do
      (defparameter sum-method style)

      (format t "Benchmarking functions using ~A functions:~%~%" style)

      (let ((time-square-of-sum 0) (time-sum-of-squares 0) (iterations 100.0))

        (loop for i from 1 to iterations do
              (setq time-square-of-sum (let ((time-start (now-µs)) (time-stop 0) (n (expt 10 100000)))
                ;; (format t "square-of-sum-~A() result: ~A~%" sum-method (difference-of-squares:square-of-sum n)) ; this adds ~4 seconds to print the huge number
                ;; (sleep 1)
                (difference-of-squares:square-of-sum n)
                (setq time-stop (now-µs))
                (+ time-square-of-sum (- time-stop time-start))
              ))

              (setq time-sum-of-squares (let ((time-start (now-µs)) (time-stop 0) (n (expt 10 100000)))
                ;; (format t "sum-of-squares-~A() result: ~A~%" sum-method (difference-of-squares:sum-of-squares n)) ; this adds ~4 seconds to print the huge number
                ;; (sleep 1)
                (difference-of-squares:sum-of-squares n)
                (setq time-stop (now-µs))
                (+ time-sum-of-squares (- time-stop time-start))
              ))

              (format t ".")
          )

        (format t "~%~%")

        (format t " square-of-sum-~A() run time: ~:@d µs for 10^100,000~%" sum-method (/ time-square-of-sum iterations))
        (format t "sum-of-squares-~A() run time: ~:@d µs for 10^100,000~%" sum-method (/ time-sum-of-squares iterations))
      )

      (format t "~%")
  )

(quit)
