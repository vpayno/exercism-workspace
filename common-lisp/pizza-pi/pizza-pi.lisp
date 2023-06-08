(defpackage :pizza-pi
  (:use :cl)
  (:export :dough-calculator :pizzas-per-cube
           :size-from-sauce :fair-share-p))

(in-package :pizza-pi)

;;; returns the amount of dough needed (g) to make x pizzas (int) of y diameter (cm)
(defun dough-calculator (pizzas diameter)
  ;; g = n * (((45 * PI * d) / 20) + 200)
  (round (* pizzas (+ (/ (* 45 pi diameter) 20) 200)))
  ) ; => dough weight (g)

;;; return the size of the pizza (cm) that a given amount of sauce (ml) can make
(defun size-from-sauce (sauce)
  ;; d = square-root of ((40 * s) / (3 * pi))
  (sqrt (/ (* 40 sauce) (* 3 pi)))
  ) ; => size of the pizza (cm)

;;; return the number of pizzas (int) of diameter (cm) that can be made from a cheese cube (cm^3)
(defun pizzas-per-cube (cube-size diameter)
  ;; n = (2 * (l^3)) / (3 * pi * (d^2))
  (floor (/ (* 2 (expt cube-size 3)) (* 3 pi (expt diameter 2))))
  ) ; => number of pizzas (int)

;;; return true if the slices of pizza (pizzas * 8 slices) can be evenly divided by number of friends
(defun fair-share-p (pizzas friends)
  ;; 8 slices per pizza
  (= 0 (mod (* pizzas 8) friends))
  ) ; => true if the number of slices are evenly divisible among friends
