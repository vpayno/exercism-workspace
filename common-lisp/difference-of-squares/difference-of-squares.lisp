(defpackage :difference-of-squares
  (:use :cl)
  (:export :sum-of-squares
           :square-of-sum
           :difference))

(in-package :difference-of-squares)

(defparameter sum-method "gauss")

;; returns a list of numbers (inclusive)
;; default start is 1 because it worked out better that way for this exercise
(defun range (end &optional (start 1))
  (if (>= end start)
      (loop for i from start to end collect i)
    (loop for i downfrom end to start collect i)
    )
  ); => ( start .. end )

;; returns the sum of a range of numbers
(defun sum-to (end &optional (start 1))
  (if (>= end start)
      (loop for i from start to end sum i)
    (loop for i downfrom end to start sum i)
    )
  ); => int

;; returns the square of a number
(defun square (n)
  (expt n 2)
  ) ; >= n^2

;; returns a list with the squares of a range of numbers
(defun squares (end &optional (start 1))
  (mapcar #'square (range end start))
  ) ; >= n^2

;; returns the sum of squares using arithmetic progression
;; https://brilliant.org/wiki/sum-of-n-n2-or-n3/
;; https://en.wikipedia.org/wiki/Arithmetic_progression
(defun sum-of-squares-gauss (n)
  ;;  n * (n + 1) * (2*n + 1) / 6
  (/ (* n (1+ n) (+ (* n 2) 1)) 6)
  ) ; => int

;; returns the square of sums using arithmetic progression
;; https://brilliant.org/wiki/sum-of-n-n2-or-n3/
;; https://en.wikipedia.org/wiki/Arithmetic_progression
(defun square-of-sum-gauss (n)
  ;;  (n * (n + 1) / 2)^2
  (square (/ (* n (1+ n)) 2))
  ) ; => int

;; returns the sum of squares using reduce
(defun sum-of-squares-reduce (n)
  (reduce #'+ (squares n) :initial-value 0)
  ) ; => int

;; returns the square of sums using reduce
(defun square-of-sum-reduce (n)
  (square (reduce #'+ (range n) :initial-value 0))
  ) ; => int

;; returns the square of the sum for a given number
(defun square-of-sum (n)
  "Calculates the square of the sum for a given number."
  (cond
   ((string= sum-method "gauss") (square-of-sum-gauss n))
   ((string= sum-method "reduce") (square-of-sum-reduce n))
   (t (sum-of-squares-gauss n))
   )
  ) ; => int

;; returns the sum of squares for a given number
(defun sum-of-squares (n)
  "Calculates the sum of squares for a given number."
  (cond
   ((string= sum-method "gauss") (sum-of-squares-gauss n))
   ((string= sum-method "reduce") (sum-of-squares-reduce n))
   (t (sum-of-squares-gauss n))
   )
  ) ; => int

;; returns the difference between the square of the sum and the sum of the squares
(defun difference (n)
  "Finds the diff. between the square of the sum and the sum of the squares."
  (- (square-of-sum n) (sum-of-squares n))
  ) ; => int
