(defpackage :pangram
  (:use :cl)
  (:export :pangramp))

(in-package :pangram)

(defun pangramp (text)
  (setf lcase (string-downcase text))
  (setf lchars (coerce lcase 'list))

  (eq
   (length
    (remove-duplicates
     (remove-if-not #'alpha-char-p lchars)
     )
    )
   26)
  )
