(defpackage :matching-brackets
  (:use :cl)
  (:export :pairedp))

(in-package :matching-brackets)

;;;; scan string
;;;; closing bracket fail before open bracket
;;;; push open brackets into list
;;;; when closing bracket found, see if it matches last open bracket

;;; set to t to enable debugging; to nil to disable debugging
(defparameter debug-mode nil)

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
  (let ((popped nil))
    (values (setq popped (last a)) (setq a (butlast a)))
    )
  ) ; => (G) ; (A B C D E F)

;;; remove the last value on the open bracket stack and also return the new stack
(defun remove-last (a)
  (setq a (butlast a))
  ) ; => (A B C D E F)

;;; let's you peek at the tail of the open bracket stack to see if it's a match
;;; for the closing bracket you just found
(defun peek (a)
  (first (last a))
  ) ; => G or nil

;;; only print debug messages when degugging
(defun debug-format (message)
  (if debug-mode
      (format t message)
    )
  ) ; nil

;;; look for matching bracket pairs
(defun pairedp (value)
  ;; fast return on corner cases
  (when (= 0 (length value))
    (return-from pairedp t)
    )

  ;; using a list as a stack
  (let ((bracket-stack ()) (result t))
    (loop for c across value do
          (when (bracket-either c)
            (debug-format (format nil "~A" c))
            (if (bracket-open c)
		(setq bracket-stack (push-last c bracket-stack))
              (if (and (bracket-close c) (= 0 (length bracket-stack)))
                  (progn
                    (setq result nil)
                    (debug-format (format nil "return from close '~A' before open '~A'" c bracket-stack))
                    (return-from pairedp result)
                    )
                (if (bracket-match (peek bracket-stack) c)
                    (progn
                      (setq bracket-stack (remove-last bracket-stack))
                      (debug-format (format nil "matched, removing last from stack: '~A'~%" bracket-stack))
                      )
                  (progn
                    (setq result nil)
                    (debug-format (format nil "return from close '~A' doesn't match open '~A' stack:'~A'~%" c (peek bracket-stack) bracket-stack))
                    (return-from pairedp result)
                    )
                  ) ; if closing matches open; else unmatched
                ) ; if open and stack empty; else open and stack not empty
              ) ; if open; else close
            ) ; when either
	  ) ; loop
    (debug-format (format nil "~%"))
    (if (= 0 (length bracket-stack))
        (progn
          (debug-format (format nil "return from bracket-stack is empty~%"))
          (return-from pairedp t)
          )
      (progn
        (debug-format (format nil "return from bracket-stack '~A' is not empty~%" bracket-stack))
        (return-from pairedp nil)
        )
      )
    ) ; let
  ) ; => t or nil
