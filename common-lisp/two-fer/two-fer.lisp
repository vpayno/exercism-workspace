(defpackage :two-fer
  (:use :cl)
  (:export :twofer))
(in-package :two-fer)

;;; returns the string with the name as is or "you" if nil or absent
(defun twofer (&optional (name))
  ;; https://gigamonkeys.com/book/a-few-format-recipes.html#:~:text=With%20a%20colon%20modifier%2C%20the%20~%5B,directive%20must%20contain%20a%20~%3B.
  (format nil "One for ~:[you~;~A~], one for me." name name)
  )
