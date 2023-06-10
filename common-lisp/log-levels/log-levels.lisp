(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

;;; "[info]: message"
;;; "[warn]: Message"
;;; "[ohno]: MESSAGE"
;;;  0123456789ABCDEF

;;; returns the message (str) of the log string
(defun log-message (log-string)
  (subseq log-string 8)
  ) ; => "message"

;;; returns the lowercased severity (keyword) of the log string
(defun log-severity (log-string)
  (let (
	(severity (string-downcase (subseq log-string 1 5)))
	)
    (case (intern (string-upcase severity) :keyword)
	  (:INFO :everything-ok)
	  (:WARN :getting-worried)
	  (:OHNO :run-for-cover)
	  (otherwise :unknown-severity)
	  )
    )
  ) ; => :severity

;;; returns a severity formatted message (str)
(defun log-format (log-string)
  (let* (
	 (message (log-message log-string))
	 (severity (log-severity log-string))
	 )
    (case severity
	  (:everything-ok (string-downcase message))
	  (:getting-worried (string-capitalize message))
	  (:run-for-cover (string-upcase message))
	  )
    )
  ) ; => "formatted message"
