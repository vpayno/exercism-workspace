(defpackage :logans-numeric-partition
  (:use :cl)
  (:export :categorize-number :partition-numbers))

(in-package :logans-numeric-partition)

;;; '((1) . (2)) 23) ; => ((23 1) . (2))
;;; '((1) . (2)) 42) ; => ((1) . (42 2))
(defun categorize-number (lists num)
  (cond
   ((oddp num) (cons
                (cons num (car lists))
                (cdr lists)
                ))
   ((evenp num) (cons
                 (car lists)
                 (cons num (cdr lists))
                 ))
   )
  ) ; => ( (odd numbers) (even numbers) )

;;; '(1 2 3 4))     ; => ((3 1) . (4 2))
(defun partition-numbers (numbers)
  (reduce #'categorize-number numbers :initial-value '(() . ()))
  ) ; => ( (odd numbers) (even numbers) )
