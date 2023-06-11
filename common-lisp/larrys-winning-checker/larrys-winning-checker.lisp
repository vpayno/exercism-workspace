(defpackage :larrys-winning-checker
  (:use :cl)
  (:export
   :make-empty-board
   :make-board-from-list
   :all-the-same-p
   :row
   :column))

(in-package :larrys-winning-checker)

;;; returns an empty 3x3 array
(defun make-empty-board ()
  (make-array '(3 3) :initial-element nil)
  ) ; => #2A((NIL NIL NIL) (NIL NIL NIL) (NIL NIL NIL))

;;; returns a 3x3 array intialized with a list
(defun make-board-from-list (list)
  (make-array '(3 3) :initial-contents list)
  ) ; => #2A((1 2 3) (4 5 6) (7 8 9))

;;; return true if one of the arrays has 3 of the same element
(defun all-the-same-p (list)
  (and
   (eq (aref list 0) (aref list 1))
   (eq (aref list 0) (aref list 2))
   )
  ) ; => t or nil

;;; returns the elements in the requested row
(defun row (board row-num)
  (vector
   (aref board row-num 0)
   (aref board row-num 1)
   (aref board row-num 2)
   )
  ) ; => #(x y z)

;;; returns the elements in the requested column
(defun column (board col-num)
  (vector
   (aref board 0 col-num)
   (aref board 1 col-num)
   (aref board 2 col-num)
   )
  ) ; => #(x y z)
