(defpackage :grains
  (:use :cl)
  (:export :square :total))
(in-package :grains)

;;; returns the number of grains for a given square on the chess board
(defun square (n)
  (expt 2 (- n 1))
  ) ; => number of grains in given square

;;; returns the total number of grains on a chess board
(defun total ()
  (- (expt 2 64 ) 1)
  ) ; => all the grains on a chess board
