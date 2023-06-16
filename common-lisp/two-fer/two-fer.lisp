(defpackage :two-fer
  (:use :cl)
  (:export :twofer))
(in-package :two-fer)

;;;
(defun twofer (&optional (name))
  (format nil "One for ~:[you~;~A~], one for me." name name)
  )
