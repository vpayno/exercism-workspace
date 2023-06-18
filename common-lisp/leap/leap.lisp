(defpackage :leap
  (:use :cl)
  (:export :leap-year-p))
(in-package :leap)

;;; returns true when the year is a leap year
;;; on every year that is evenly divisible by 4
;;; except every year that is evenly divisible by 100
;;; unless the year is also evenly divisible by 400
(defun leap-year-p (year)
  (cond
   ((= 0 (mod year 400)) t)
   ((= 0 (mod year 100)) nil)
   ((= 0 (mod year 4)) t)
   (t nil)
   )
  ) ; => t or nil
