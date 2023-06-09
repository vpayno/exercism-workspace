(defpackage :pal-picker
  (:use :cl)
  (:export :pal-picker :habitat-fitter :feeding-time-p
           :pet :play-fetch))

(in-package :pal-picker)

;;; returns the animal type (str) that matches a personality keyword
(defun pal-picker (personality)
  (case personality
	(:lazy "Cat")
	(:energetic "Dog")
	(:quiet "Fish")
	(:hungry "Rabbit")
	(:talkative "Bird")
	(otherwise "I don't know... A dragon?")
	)
  ) ; => animal str

;;; returns the habbitat size (str) based on the weight (kg)
(defun habitat-fitter (weight)
  (cond
   ;; weight >= 40kg
   ((>= weight 40) :massive)
   ;; 20kg <= weight <= 39kg
   ((and (>= weight 20) (<= weight 39)) :large)
   ;; 10kg <= weight <= 19kg
   ((and (>= weight 10) (<= weight 19)) :medium)
   ;; 01kg <= weight <= 09kg
   ((and (>= weight 1) (<= weight 9)) :small)
   ;; weight <= 0kg
   ((<= weight 0) :just-your-imagination)
   )
  ) ; => size (str)

;;; returns an message (str) regarding feeding time
(defun feeding-time-p (fullness)
  (cond
   ;; food level > 20%
   ((> fullness 20) "All is well.")
   ;; food level <= 20%
   ((<= fullness 20) "It's feeding time!")
   )
  ) ; => message (str)

;;; this one is weird
;;; returns nil if the the pet is pettable (why not true?)
;;; returns a warning message (str) if the pet is not pettable - ah, because a string is true? :(
(defun pet (pet)
  ;; all pets except fish may be pet
  ;; case keywords need to be in upper-case
  (case (intern (string-upcase pet) :keyword)
	(:FISH "Maybe not with this pet...")
	(otherwise nil)
	)
  ) ; => nil or message

;;; returns nil if the pet will play fetch
;;; returns a warning message (str) if the pet won't play fetch
(defun play-fetch (pet)
  ;; only dogs will play fetch
  ;; case keywords need to be in upper-case
  (case (intern (string-upcase pet) :keyword)
	(:DOG nil)
	(otherwise "Maybe not with this pet...")
	)
  ) ; => nil or message
