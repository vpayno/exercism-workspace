(defpackage :robot-name
  (:documentation "Robot Naming Package")
  (:use :cl)
  (:export :build-robot :robot-name :reset-name))

(in-package :robot-name)

;;; This exercise does a really bad job of making it obvious how to solve it.
;;; From looking at solutions, I preferre the struct with methods option vs
;;; tradditional OOP.

;;; Committing this example to learn from it but not submitting it.
;;; https://exercism.org/tracks/common-lisp/exercises/robot-name/solutions/kahgoh

(defstruct robot name)

(defvar *used-names* '())

(defun choose-char (range-start range-end)
  (let ((start-code (char-code range-start))
        (end-code (char-code range-end))
	) ; let
    (code-char (+ start-code (random (- end-code start-code)))
               ) ; code-char
    ) ; let
  )

(defun letter () (choose-char #\A #\Z))

(defun digit () (choose-char #\0 #\9))

(defun pick-name ()
  (concatenate 'string (list (letter) (letter) (digit) (digit) (digit)))
  )

(defun generate-name ()
  (loop
   (let ((next (pick-name)))
     (unless
         (member next *used-names*)
       (append *used-names* next)
       (return next)
       ) ; unless
     ) ; let
   ) ; loop
  )

(defun build-robot ()
  (make-robot :name (generate-name))
  )

(defun reset-name (robot)
  (setf (robot-name robot) (generate-name))
  )
