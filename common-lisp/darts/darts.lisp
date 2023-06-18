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
  (let ((r 0))
    (setf r (radius x y))
    (cond
     ((and (> r 5) (<= r 10)) 1)
     ((and (> r 1) (<= r 5)) 5)
     ((<= r 1) 10)
     (t 0)
     ) ; cond
    ) ; let
  ) ; => int
