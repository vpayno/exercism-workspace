(defpackage :character-study
  (:use :cl)
  (:export
   :compare-chars
   :size-of-char
   :change-size-of-char
   :type-of-char))
(in-package :character-study)

;;; returns the different size comparison keyword to describe the two characters
;;; case sensitive
(defun compare-chars (char1 char2)
  (cond
   ((char= char1 char2) :equal-to)
   ((char> char1 char2) :greater-than)
   ((char< char1 char2) :less-than)
   )
  ) ; => :greater-than, :less-than, :equal-to

;;; returns the "size" (keyword) of the character
(defun size-of-char (char)
  (cond
   ((upper-case-p char) :big)
   ((lower-case-p char) :small)
   (t :no-size)
   )
  ) ; => :big, :small, :no-size

;;; returns a transformed char based on the requested transformation
(defun change-size-of-char (char wanted-size)
  (case wanted-size
	(:big (char-upcase char))
	(:small (char-downcase char))
	(otherwise char)
	)
  ) ; => char

;;; returns the type (keyword) of the given char
(defun type-of-char (char)
  (cond
   ((alpha-char-p char) :alpha)
   ((digit-char-p char) :numeric)
   ((char= char #\Space) :space)
   ((char= char #\Newline) :newline)
   (t :unknown)
   )
  ) ; => :alpha, :numeric, :space, :newline, :unknown
