(defsystem "lem-tests"
  :class :package-inferred-system
  :depends-on ("lem-tests/main")
  :pathname "tests"
  :perform (test-op (o c)
                    (symbol-call :lem-tests '#:run-all-tests)))

(asdf:register-system-packages "lem-lisp-syntax" '(:lem-lisp-syntax.defstruct-to-defclass))
