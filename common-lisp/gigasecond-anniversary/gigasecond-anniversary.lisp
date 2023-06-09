(defpackage :gigasecond-anniversary
  (:use :cl)
  (:export :from))
(in-package :gigasecond-anniversary)

;;; returns the date of the gigasecond annyversary for the given date-time stamp
(defun from (year month day hour minute sec) ; second returns the second item in a list
  (multiple-value-bind
   (se mi hr dy mo yr)
   (let (
         (date (encode-universal-time sec minute hour day month year 0))
         (giga (expt 10 9))
         )
     (decode-universal-time (+ date giga) 0)
     )
   (multiple-value-list (values yr mo dy hr mi se))
   )
  ) ; => (year month day hour min sec)
