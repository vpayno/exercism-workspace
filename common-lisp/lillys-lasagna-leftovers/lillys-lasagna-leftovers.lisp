(defpackage :lillys-lasagna-leftovers
  (:use :cl)
  (:export
   :preparation-time
   :remaining-minutes-in-oven
   :split-leftovers))

(in-package :lillys-lasagna-leftovers)

;;; return the preparation time needed for x layers
(defun preparation-time (&rest layers)
  (* 19 (length layers))
  ) ; => int (time in minutes)

;;; return the converted cooking time in minutes
(defun remaining-minutes-in-oven (&optional (cook-time :normal))
  (ecase cook-time
	 (:normal 337)
	 (:shorter 237)
	 (:very-short 137)
	 (:longer 437)
	 (:very-long 537)
	 ((nil) 0)
	 )
  ) ; => cooking time (minutes)

;;; returns the amount of left overs after using x number of containers from the human and alien to split the food
(defun split-leftovers (&key (weight 0 weight-supplied-p) (human 10) (alien 10))
  (cond
   ((equalp weight nil) :looks-like-someone-was-hungry)
   ((= weight 0) :just-split-it)
   (t (- weight human alien))
   )
  ) ; => int, :looks-like-someone-was-hungry or :just-split-it
