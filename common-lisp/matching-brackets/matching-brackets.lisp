(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

;;;; scan string
;;;; closing bracket fail before open bracket
;;;; push open brackets into list
;;;; when closing bracket found, see if it matches last open bracket

;;; test to see if closing bracket matches open bracket
(defun bracket-match (open-bracket close-bracket)
  (cond
    ((and (char= #\[ open-bracket) (char= #\] close-bracket)) t)
    ((and (char= #\( open-bracket) (char= #\) close-bracket)) t)
    ((and (char= #\{ open-bracket) (char= #\} close-bracket)) t)
    (t nil)
    )
  ) ; => t or nil

;;; test to see if character is an opening bracket
(defun bracket-open (c)
  ;; you do need the if here, member returns the list if true, nil if false
  ;; we just want t or nil
  (if (member c '( #\[ #\( #\{ )) t nil)
  ) ; => t or nil

;;; test to see if character is a closing bracket
(defun bracket-close (c)
  ;; you do need the if here, member returns the list if true, nil if false
  ;; we just want t or nil
  (if (member c '( #\] #\) #\} )) t nil)
  ) ; => t or nil

;;; test to see if character is a bracket
(defun bracket-either (c)
  (or (bracket-open c) (bracket-close c))
  ) ; => t or nil

;;; pushes an open bracket to the stack
(defun push-last (i a)
  (nconc a (list i))
  ) ; => (A B C D E F)

;;; pops the last value on the open bracket stack and also return the new stack
(defun pop-last (a)
  (let ((result nil))
    (values (setq result (last a)) (setq a (butlast a)))
    )
  ) ; => (G) ; (A B C D E F)

;;; let's you peek at the tail of the open bracket stack to see if it's a match
;;; for the closing bracket you just found
(defun peek (a)
  (first (last a))
  ) ; => G or nil

;;; look for matching bracket pairs
(defun pairedp (value)
  ;; using a list as a stack
  (let ((bracket-stack ()))
    (loop for c across value do
          (when (bracket-either c)
            (if (bracket-open c)
              (setq bracket-stack (push-last c bracket-stack))
              (if (and (bracket-close c) (= 0 (length bracket-stack)))
                      (return nil)
                      (if (bracket-match (peek bracket-stack) c)
                        (multiple-value-bind
                          (last-open bracket-stack)
                          (pop-last bracket-stack)
                          ) ; multiple-value-bind
                        (return nil)
                      ) ; if closing matches open; else unmatched
                ) ; if open and stack empty; else open and stack not empty
              ) ; if open; else close
            ) ; when either
      ) ; loop
    ) ; let
  ) ; => t or nil
