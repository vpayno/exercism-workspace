(defpackage :raindrops
  (:use :cl)
  (:export :convert))

(in-package :raindrops)

;;; returns Pling if evenly divisible by 3
(defun pling (n)
  "Returns the sound Pling if the number is evenly divisibley by 3"

  (if (= 0 (mod n 3))
      (format nil "Pling") ; if true
    (format nil "")        ; else return an empty string
    ) ; endif
  ) ; => "" or "Pling"

;;; returns Plang if evenly divisible by 5
(defun plang (n)
  "Returns the sound Plang if the number is evenly divisibley by 5"

  (if (= 0 (mod n 5))
      (format nil "Plang") ; if true
    (format nil "")        ; else return an empty string
    ) ; endif
  ) ; => "" or "Plang"

;;; returns Plong if evenly divisible by 7
(defun plong (n)
  "Returns the sound Plong if the number is evenly divisibley by 7"

  (if (= 0 (mod n 7))
      (format nil "Plong") ; if true
    (format nil "")        ; else return an empty string
    ) ; endif
  ) ; => "" or "Plong"

;;; returns the number instead of the string if the string is empty.
(defun sounds-or-number (str n)
  (if (= 0 (length str))
      (format nil "~A" n) ; if string is empty
    (format nil "~A" str) ; else string has rain sounds
    ) ; endif
  ) ; => n or str

;;; returns rainsounds from a number
(defun rainsounds (n)
  (concatenate 'string
               (pling n)
               (plang n)
               (plong n)
               )
  ) ; => str

;;; returns the rain drop sounds for a given number
(defun convert (n)
  "Converts a number to a string of raindrop sounds."

  (let ((str "")) ; create a local scope variable to the let expression
    (setf str (rainsounds n)) ; set str to the rainsounds string

    (sounds-or-number str n)
    ) ; let str
  ) ; => n or str
