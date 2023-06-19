(load "~/.clisprc.lisp")

(load "./difference-of-squares-test.lisp")

(format t "Testing gaussian functions...~%~%")

(defparameter sum-method "gauss")

(difference-of-squares-test:run-tests)

(format t "Testing reduce functions...~%~%")

(defparameter sum-method "reduce")

(difference-of-squares-test:run-tests)

(quit)
