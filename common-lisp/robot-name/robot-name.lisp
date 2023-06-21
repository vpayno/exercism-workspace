(defpackage :robot-name
  (:documentation "Robot Naming Package")
  (:use :cl)
  (:export :build-robot :robot-name :reset-name))

(in-package :robot-name)

;;; This exercise does a really bad job of making it obvious how to solve it.
;;; From looking at solutions, I preferre the struct with methods option vs
;;; tradditional OOP.

;;; Good notes on how to use a struct and all the auto-generated functions.
;;; https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node169.html
;;; https://lispcookbook.github.io/cl-cookbook/clos.html

;;; this feels like a solution I would have generated had I been able to find good
;;; examples on structs before looking at solutions to figure out how all of this
;;; works.
;;; https://exercism.org/tracks/common-lisp/exercises/robot-name/solutions/cherylli

(defstruct robot
  name ; robot's name
  ) ; => ROBOT type

;;; since the random names are too simple, it will be easy to get collisions.
;;; using a list to remember all names generated while the program is running.
(defvar *used-names* '()) ; => ()

;;; really good example I saw on how to select a random letter and number in lisp
;;; without manually generating a list of letters and numbers to choose from first
(defun choose-char (range-start range-end)
  (let ((start-code (char-code range-start))
        (end-code (char-code range-end))
	) ; let
    (code-char (+ start-code (random (- end-code start-code)))
               ) ; code-char
    ) ; let
  ) ; => random character from an ascii code range

;;; returns a random letter
(defun letter () (choose-char #\A #\Z)) ; => #\A .. #\Z

;;; returns a random number
(defun digit () (choose-char #\0 #\9)) ; => #\0 .. #\9

;;; returns a random robot name
(defun random-name ()
  (concatenate 'string (list (letter) (letter) (digit) (digit) (digit)))
  ) ; => "AB123"

;;; returns a new unique robot name
(defun generate-name ()
  (loop
   (let ((new-name (random-name)))
     (unless
	 (member new-name *used-names*) ; if new name not previously generated
       (append *used-names* new-name) ; add to memory
       (return new-name)              ; return new name
       ) ; unless
     ) ; let
   ) ; loop
  ) ; => "AB123"

;;; use the auto-generated make-robot function to create a robot with a random
;;; name
(defun build-robot ()
  (make-robot :name (generate-name))
  ) ; => #S(robot :name "AB123")

;;; use the really awkward prefix notiation to set the new name of the passed
;;; robot type instance
(defun reset-name (robot-instance)
  ;; since this is in prefix notaition, read it backwards so it makes sense
  ;; robot-instance.robot-name() => string
  ;; defstruct does a lot of things that makes this make sense, somehow that
  ;; translates into setting the member variable.
  (setf (robot-name robot-instance) (generate-name))
  ) ; => sets new name in robot-instance and returns said name
