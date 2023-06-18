(defpackage :darts
  (:use :cl)
  (:export :score))

(in-package :darts)

;;; return the radius where the dart landed
(defun radius (x y)
  ;; r^2 = (x – h)^2 + (y – k)^2
  (sqrt (+ (expt (- x 0) 2) (expt (- y 0) 2)))
  ) ; => int

;;; returns the score for a single dart throw
(defun score (x y)
  (cond
   ((and (> (radius x y) 5) (<= (radius x y) 10)) 1)
   ((and (> (radius x y) 1) (<= (radius x y) 5)) 5)
   ((<= (radius x y) 1) 10)
   (t 0)
   )
  ) ; => int
