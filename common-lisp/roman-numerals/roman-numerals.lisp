(defpackage :roman-numerals
  (:use :cl)
  (:export :romanize))

(in-package :roman-numerals)

;;; https://gigamonkeys.com/book/a-few-format-recipes.html#:~:text=sign%20modifier.6-,English%2DLanguage%20Directives,-Some%20of%20the
;;; you can do a lot of really cool things with Lisp's format directive
(defun romanize (n)
  "Returns the Roman numeral representation for a given number."
  (format nil "~@R" n)
  )
