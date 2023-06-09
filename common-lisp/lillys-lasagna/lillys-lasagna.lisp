(defpackage :lillys-lasagna
  (:use :cl)
  (:export :expected-time-in-oven
           :remaining-minutes-in-oven
           :preparation-time-in-minutes
           :elapsed-time-in-minutes))

(in-package :lillys-lasagna)

;; returns how many minutes the lasagna should be in the oven
(defun expected-time-in-oven ()
  "Returns how many minutes (int) the lasagna should be in the oven."
  337
  ) ; => int

;; returns how many minutes (int) of cooking time that are left
(defun remaining-minutes-in-oven (actual)
  "Returns how many minutes (int) the lasagna still has to remain in the oven using the parameter of the actual time in minutes (int) spent in the oven so far."
  (- (expected-time-in-oven) actual)
  ) ; => int

;; returns the preparation time in minutes (int) needed based on how many layers (int) it has
(defun preparation-time-in-minutes (layers)
  "Returns the amount of time in minutes (int) the lasagna will take to cook taking into account the number of layers (int) it has."
  (* 19 layers)
  ) ; => int

;; returns the number of (int) spent preparing the lasagna
(defun elapsed-time-in-minutes (layers actual)
  "Returns the amount of time spent preparing the lasagna using the number of layers (int) and the amount of time (int) the lasagna has spent in the oven."
  (+ (preparation-time-in-minutes layers) actual)
  ) ; => int
