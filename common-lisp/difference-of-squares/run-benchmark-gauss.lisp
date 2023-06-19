(load "~/.clisprc.lisp")

(ql:quickload "local-time")

(load "./difference-of-squares-test.lisp")

(defparameter sum-method "gauss")

;; Lisp is really fast!
;; using get-universal-time resulted in all test taking 0 seconds, we need to use milli or micro seconds!
;; using ms and us really didn't help much, I can time format and sleep but not my function ????

(defun now-ms ()
  (* 1000 (local-time:timestamp-to-unix (local-time:now)))
  ) ; unix time in milliseconds

(defun now-us ()
  (+ (* 1000 (local-time:timestamp-to-unix (local-time:now)) (now-ms)))
  ) ; unix time in microseconds

(let ((time-start (now-us)) (time-stop 0) (n (expt 10 100000)))
  ;; (format t "square-of-sum-gauss() result: ~A~%" (difference-of-squares:square-of-sum n)) ; this adds ~4 seconds to print the huge number
  ;; (sleep 1)
  (difference-of-squares:square-of-sum n)
  (setq time-stop (now-us))
  (format t " square-of-sum-gauss()   time: ~A microseconds for 10^100,000~%" (- time-stop time-start))
  )

(let ((time-start (now-us)) (time-stop 0) (n (expt 10 100000)))
  ;; (format t "sum-of-squares-gauss() result: ~A~%" (difference-of-squares:sum-of-squares n)) ; this adds ~4 seconds to print the huge number
  ;; (sleep 1)
  (difference-of-squares:sum-of-squares n)
  (setq time-stop (now-us))
  (format t "sum-of-squares-gauss()   time: ~A microseconds for 10^100,000~%" (- time-stop time-start))
  )

(quit)
