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
  )

;;; returns Plang if evenly divisible by 5
(defun plang (n)
  "Returns the sound Plang if the number is evenly divisibley by 5"

  (if (= 0 (mod n 5))
      (format nil "Plang") ; if true
    (format nil "")        ; else return an empty string
    ) ; endif
  )

;;; returns Plong if evenly divisible by 7
(defun plong (n)
  "Returns the sound Plong if the number is evenly divisibley by 7"

  (if (= 0 (mod n 7))
      (format nil "Plong") ; if true
    (format nil "")        ; else return an empty string
    ) ; endif
  )

;;; returns the rain drop sounds for a given number
(defun convert (n)
  "Converts a number to a string of raindrop sounds."

  (let ((str "")) ; create a local scope variable to the let expression
    (setf str (concatenate 'string
			   (pling n)
			   (plang n)
			   (plong n)
			   ) ; set str to the format expression which concatenates 3 strings
	  ) ; setf str

    (if (= 0 (length str))
        (format nil "~A" n) ; if string is empty
      (format nil "~A" str) ; else string has rain sounds
      ) ; endif
    ) ; let str
  )
