(defpackage :space-age
  (:use :cl)
  (:export :on-mercury
           :on-venus
           :on-earth
           :on-mars
           :on-jupiter
           :on-saturn
           :on-uranus
           :on-neptune))

(in-package :space-age)

;;;; Regretably, the tests are written so there's a function for each planet.

;;;; data

;;;; Let's use a constant and a hash table.
(defconstant +earth-seconds+ (* 365.25 24 60 60)) ; 31557600.0
;;; (defconstant +earth-seconds+ 31557600)
(defparameter *planets* (make-hash-table :size 8 :test 'eql))

;;;; helper functions

;;; returns the orbital period for a planet
(defun orbital-period (planet)
  (setf (gethash (intern (string-upcase "mercury")) *planets*) 0.2408467)
  (setf (gethash (intern (string-upcase "venus")) *planets*) 0.61519726)
  (setf (gethash (intern (string-upcase "earth")) *planets*) 1.0)
  (setf (gethash (intern (string-upcase "mars")) *planets*) 1.8808158)
  (setf (gethash (intern (string-upcase "jupiter")) *planets*) 11.862615)
  (setf (gethash (intern (string-upcase "saturn")) *planets*) 29.447498)
  (setf (gethash (intern (string-upcase "uranus")) *planets*) 84.016846)
  (setf (gethash (intern (string-upcase "neptune")) *planets*) 164.79132)

  (nth-value 0 (gethash (intern (string-upcase planet)) *planets*))
  ) ; => float

;;; returns space-age on given planet
(defun on-planet (planet seconds)
  (/ seconds (* +earth-seconds+ (orbital-period planet)))
  ) ; => seconds on planet

;;;; I was trying to auto-generate the do-planetname functions but couldn't get
;;;; it to work, this is the closest I got to ot (the do-xxx functions have no
;;;; value associated with them. :(

;;; generates the do-name function name which needs to be a symbol
(defun gen-func-name (name)
  (intern (string-upcase (concatenate 'string "fancy-do-" (string name)) ) )
  ) ; => symbol

;;; returns a list of keys (symbols) in the given hash
(defun hash-table-list-keys (table)
  (loop for key being the hash-keys of table collect key)
  ) ; => (key1 key2 ...)

;;; loops through the hash keys and creates the do-keyname() functions
(defun create-do-planet-functions ()
  (loop for planet in
        (mapcar #'gen-func-name (hash-table-list-keys *planets*)) do
        (setf (symbol-function planet)
              (lambda (seconds)
                (apply #'do-planet (cons planet seconds) )
                ) ; lambda
              ) ; setf
        ) ; loop
  ) ; => nil

;;; create the functions instead of doing it by hand (not working)
;;; (create-do-planet-functions)

;;;; create the functions by hand :(

;;; returns space-age on mercury planet
(defun on-mercury (seconds)
  (on-planet "mercury" seconds)
  ) ; => seconds on planet mercury

;;; returns space-age on venus planet
(defun on-venus (seconds)
  (on-planet "venus" seconds)
  ) ; => seconds on planet venus

;;; returns space-age on earth planet
(defun on-earth (seconds)
  (on-planet "earth" seconds)
  ) ; => seconds on planet earth

;;; returns space-age on mars planet
(defun on-mars (seconds)
  (on-planet "mars" seconds)
  ) ; => seconds on planet mars

;;; returns space-age on jupiter planet
(defun on-jupiter (seconds)
  (on-planet "jupiter" seconds)
  ) ; => seconds on planet jupiter

;;; returns space-age on saturn planet
(defun on-saturn (seconds)
  (on-planet "saturn" seconds)
  ) ; => seconds on planet saturn

;;; returns space-age on uranus planet
(defun on-uranus (seconds)
  (on-planet "uranus" seconds)
  ) ; => seconds on planet uranus

;;; returns space-age on neptune planet
(defun on-neptune (seconds)
  (on-planet "neptune" seconds)
  ) ; => seconds on planet neptune
