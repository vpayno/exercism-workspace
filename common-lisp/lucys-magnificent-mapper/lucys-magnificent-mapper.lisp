(defpackage :lucys-magnificent-mapper
  (:use :cl)
  (:export :make-magnificent-maybe :only-the-best))

(in-package :lucys-magnificent-mapper)

;; returns a list of numbers after applying the transformer function on each number
(defun make-magnificent-maybe(transformer numbers)
  (mapcar transformer numbers)
  ) ; => ( transformed list )

;; returns a list with only numbers that are magnificent
;; - always remove 1
;; - used the passed function to filter out the rest of the bad numbers
(defun only-the-best (filter numbers)
  (remove-if filter (remove 1 numbers))
  ) ; => ( only magnificent numbers )
