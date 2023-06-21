(defpackage :robot-name
  (:documentation "Robot Naming Package")
  (:use :cl)
  (:export :build-robot :robot-name :reset-name))

(in-package :robot-name)

;;; This exercise does a really bad job of making it obvious how to solve it.
;;; From looking at solutions, I preferre the struct with methods option vs
;;; tradditional OOP.

;;; Committing this example to learn from it but not submitting it.
;;; https://exercism.org/tracks/common-lisp/exercises/robot-name/solutions/kruschk

(defparameter *alphabetic* "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(defparameter *digital* "0123456789")

(defparameter *name-pattern*
  (list *alphabetic* *alphabetic* *digital* *digital* *digital*)
  )

(defparameter *robot-names* (make-hash-table))

;;; Some handy utility functions

(defun decode (nmbr)
  (macrolet (
             (quotrem (dividend divisor)
		      `(multiple-value-list (truncate ,dividend ,divisor)))
             )
            (coerce
             (loop for string in *name-pattern*
                   for lngth in (mapcar #'length *name-pattern*)
                   for (qtnt rmndr) = (quotrem nmbr lngth) then (quotrem qtnt lngth)
                   collecting (elt string rmndr))
             'string) ; coerce
            ) ; macrolet
  )

(defun generate-name ()
  (decode (random (apply #'* (mapcar #'length *name-pattern*))))
  )

;;; The generic object interface

(defgeneric build-robot ())

(defgeneric reset-name (robot))

(defgeneric robot-name (robot))

;;; Define the class and methods

(defclass robot ()
  ((name :initform "" :reader name))
  )

(defmethod build-robot ()
  (make-instance 'robot)
  )

(defmethod reset-name ((robot robot))
  (setf (slot-value robot 'name) "")
  )

(defmethod robot-name ((robot robot))
  (when (string= (name robot) "")
    (loop for name = (generate-name)
	  while (gethash name *robot-names*)
	  finally (setf (gethash name *robot-names*) t)
	  finally (setf (slot-value robot 'name) name)
	  ) ; loop
    ) ; when
  (name robot)
  )
