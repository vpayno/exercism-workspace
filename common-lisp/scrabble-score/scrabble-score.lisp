(defpackage :scrabble-score
  (:use :cl)
  (:export :score-word))

(in-package :scrabble-score)

;;; return the score of a scrabble letter
;;; letter needs to be treated as a character, not a string
(defun score-letter (letter)
  "Computes the score for a single letter"

  ;; (format t "~A~%" letter)

  (cond
   ((not (alpha-char-p letter)) 0) ; letter not a-z
   ((find letter '(#\d #\g) :test #'equal) 2)
   ((find letter '(#\b #\c #\m #\p) :test #'equal) 3)
   ((find letter '(#\f #\h #\v #\w #\y) :test #'equal) 4)
   ((find letter '(#\k) :test #'equal) 5)
   ((find letter '(#\j #\x) :test #'equal) 8)
   ((find letter '(#\q #\z) :test #'equal) 10)
   (t 1) ; all other letters
   )
  ) ; => 0-10

;;; returns a character list from a string
(defun string-to-char-list (str)
  "Transforms a string into a character list."

  ;; (format t "~A~%" str)

  (coerce str 'list)
  ) ; => (#\a #\f #\q)

;;; returns a score list from a character list
(defun char-list-to-scores (chars)
  "Transforms a character list to a score list."

  ;; (format t "~A~%" chars)

  (mapcar #'score-letter chars)
  ) ; => (1 4 10)

;;; return the score of a scrabble word
(defun score-word (word)
  "Computes the score for an entire word."

  (let ((chars ()) (scores ()))
    (setf chars (string-to-char-list (string-downcase word)))
    (setf scores (char-list-to-scores chars))

    ;; (format t "~A~%" chars)
    ;; (format t "~A~%" scores)

    ;; all of these will return the sum of the integer list
    ;; (apply #'+ scores)
    ;; (eval (cons '+ scores))
    (reduce #'+ scores :initial-value 0)
    )
  ) ; => 15
