(defpackage :high-scores
  (:use :cl)
  (:export :make-high-scores-table :add-player
           :set-score :get-score :remove-player))

(in-package :high-scores)

;; returns an empty hash table
(defun make-high-scores-table ()
  (make-hash-table)
  ) ; => #S(HASH-TABLE :TEST FASTHASH-EQL)

;; adds a player to the score table and sets their default score to 0
(defun add-player (scores player)
  (setf (gethash player scores) 0)
  ) ; => 0 (default score for player)

;; sets the player's score
(defun set-score (scores player score)
  (setf (gethash player scores) score)
  ) ; => 1234 (new score for player)

;; returns the player's score
;; return 0 if the player doesn't exist - bad, can't tell the difference between a user that exists and doesn't exist
(defun get-score (scores player)
  (gethash player scores 0)
  ) ; => 1234 (current score for player) || 0 if player doesn't exist

;; Define remove-player function
(defun remove-player (scores player)
  (remhash player scores)
  ) ; => t or nil
