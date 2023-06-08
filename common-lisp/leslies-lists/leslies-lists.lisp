(defpackage :leslies-lists
  (:use :cl)
  (:export :new-list
           :list-of-things
           :add-to-list
           :first-thing
           :second-thing
           :third-thing
           :twenty-third-thing
           :remove-first-item
           :on-the-list-p
           :list-append
           :just-how-long
           :part-of-list
           :list-reverse))

(in-package :leslies-lists)

;;; returns empty list
(defun new-list ()
  '()
  ) ; => ()

;;; returns a list with 3 things
(defun list-of-things (thing1 thing2 thing3)
  (list thing1 thing2 thing3)
  ) ; => (thing1 thing2 thing3)

;;; returns a list with the new item prepended
(defun add-to-list (item list)
  (cons item list)
  ) ; => (item list_items...)

;;; returns the first thing on the list
(defun first-thing (list)
  (first list)
  ) ; 1st item or nil

;;; returns the second thing on the list
(defun second-thing (list)
  (second list)
  ) ; 2nd item or nil

;;; returns the third thing on the list
(defun third-thing (list)
  (third list)
  ) ; 3rd item or nil

;;; returns the 23rd (index 22) thing on the list
(defun twenty-third-thing (list)
  (nth 22 list)
  ) ; => 23rd item or nil

;;; returns a new list without the first item
(defun remove-first-item (list)
  (rest list)
  ) ; => list[1:]

;;; returns one list after merging two lists
(defun list-append (list1 list2)
  (append list1 list2)
  ) ; => (list1[], list2[])

;; returns the length of the list
(defun just-how-long (list)
  (length list)
  ) ; => n>=0
