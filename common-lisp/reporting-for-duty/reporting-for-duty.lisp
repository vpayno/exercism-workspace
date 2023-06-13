(defpackage :reporting-for-duty
  (:use :cl)
  (:export :format-quarter-value :format-two-quarters
           :format-two-quarters-for-reading))

(in-package :reporting-for-duty)

;; return the given values as a formatted string
(defun format-quarter-value (quarter data)
  (format nil "The value ~A quarter: ~A" quarter data)
  ) ; => "The value X quarter: Y"

;; return the given values as a formatted string
(defun format-two-quarters (s q1 d1 q2 d2)
  (format s "~%~A~%~A~%"
    (format-quarter-value q1 d1)
    (format-quarter-value q2 d2)
    )
  ) ; => "\nThe value Q1 quarter: D1\nThe value Q2 quarter: D2\n"

;; return the given values as a formatted string
(defun format-two-quarters-for-reading (s q1 d1 q2 d2)
  (format s "~S"
    (list
     (format-quarter-value q1 d1)
     (format-quarter-value q2 d2)
     )
    )
  ) ; => "(\"line1\" \"line2\")"
