(defpackage :key-comparison
  (:use :cl)
  (:export
   :key-object-identity
   :key-numbers
   :key-numbers-of-different-types
   :key-characters
   :key-characters-case-insensitively
   :key-strings
   :key-strings-case-insensitively
   :key-conses-of-symbols
   :key-conses-of-characters
   :key-conses-of-numbers
   :key-conses-of-characters-case-insensitively
   :key-conses-of-numbers-of-different-types
   :key-arrays
   :key-arrays-loosely))
(in-package :key-comparison)

;;; test if two objects are identical
(defun key-object-identity (x y)
  (eq x y)
  ) ; => t or nil

;;; test if two objects are of the same type and value
(defun key-numbers (x y)
  (eql x y)
  ) ; => t or nil

;;; test if two objects have the same values, case/int-float insensitive
(defun key-numbers-of-different-types (x y)
  (equalp x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-characters (x y)
  (key-numbers x y)
  ) ; => t or nil

;;;  test if two objects have the same close enough value
(defun key-characters-case-insensitively (x y)
  (key-numbers-of-different-types x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-strings (x y)
  (equal x y)
  ) ; => t or nil

;;; test if two objects have the same close enough value
(defun key-strings-case-insensitively (x y)
  (key-numbers-of-different-types x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-conses-of-symbols (x y)
  (key-strings x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-conses-of-characters (x y)
  (key-strings x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-conses-of-numbers (x y)
  (key-strings x y)
  ) ; => t or nil

;;; test if two objects have the same close enough value
(defun key-conses-of-characters-case-insensitively (x y)
  (key-numbers-of-different-types x y)
  ) ; => t or nil

;;; test if two objects have the same close enough value
(defun key-conses-of-numbers-of-different-types (x y)
  (key-numbers-of-different-types x y)
  ) ; => t or nil

;;; test if two objects have the same strict value
(defun key-arrays (x y)
  (key-strings x y)
  ) ; => t or nil

;;; test if two objects have the same close enough value
(defun key-arrays-loosely (x y)
  (key-numbers-of-different-types x y)
  ) ; => t or nil
