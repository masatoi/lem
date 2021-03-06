(in-package :lem)

(export '(*prompt-activate-hook*
          *prompt-deactivate-hook*
          *prompt-buffer-completion-function*
          *prompt-file-completion-function*
          prompt-start-point
          prompt-active-p
          active-prompt-window
          prompt-for-character
          prompt-for-y-or-n-p
          prompt-for-string
          prompt-for-integer
          prompt-for-buffer
          prompt-for-file
          prompt-for-directory))

(defvar *prompt-activate-hook* '())
(defvar *prompt-deactivate-hook* '())

(defvar *prompt-buffer-completion-function* nil)
(defvar *prompt-file-completion-function* nil)

(defgeneric prompt-start-point (prompt))
(defgeneric caller-of-prompt-window (prompt))
(defgeneric prompt-active-p (prompt))
(defgeneric active-prompt-window ())
(defgeneric prompt-for-character (prompt-string))
(defgeneric prompt-for-line (prompt initial comp-f existing-p history-name &optional syntax-table))

(defun prompt-for-y-or-n-p (prompt-string)
  (do () (nil)
    (let ((c (prompt-for-character (format nil "~a [y/n]? " prompt-string))))
      (case c
        (#\y (return t))
        (#\n (return nil))))))

(defun prompt-for-string (prompt &key initial-value
                                      completion-function
                                      test-function
                                      (history-symbol nil)
                                      (syntax-table (current-syntax)))
  (prompt-for-line prompt
                   initial-value
                   completion-function
                   test-function
                   history-symbol
                   syntax-table))

(defun prompt-for-integer (prompt &optional min max)
  (parse-integer
   (prompt-for-string prompt
                      :test-function (lambda (str)
                                       (multiple-value-bind (n len)
                                           (parse-integer str :junk-allowed t)
                                         (and
                                          n
                                          (/= 0 (length str))
                                          (= (length str) len)
                                          (if min (<= min n) t)
                                          (if max (<= n max) t))))
                      :history-symbol 'prompt-for-integer)))

(defun prompt-for-buffer (prompt &optional default-value existing)
  (let ((result (prompt-for-string
                 (if default-value
                     (format nil "~a(~a) " prompt default-value)
                     prompt)
                 :completion-function *prompt-buffer-completion-function*
                 :test-function (and existing
                                     (lambda (name)
                                       (or (alexandria:emptyp name)
                                           (get-buffer name))))
                 :history-symbol 'prompt-for-buffer)))
    (if (string= result "")
        default-value
        result)))

(defun prompt-for-file (prompt &optional directory (default (buffer-directory)) existing)
  (let ((result
          (prompt-for-string (if default
                                 (format nil "~a(~a) " prompt default)
                                 prompt)
                             :initial-value (when directory (princ-to-string directory))
                             :completion-function
                             (when *prompt-file-completion-function*
                               (lambda (str)
                                 (or (alexandria:emptyp str)
                                     (funcall *prompt-file-completion-function*
                                              str (or directory
                                                      (namestring (user-homedir-pathname)))))))
                             :test-function (and existing #'virtual-probe-file)
                             :history-symbol 'prompt-for-file)))
    (if (string= result "")
        default
        result)))

(defun prompt-for-directory (prompt &optional directory (default (buffer-directory)) existing)
  (let ((result
          (prompt-for-string prompt
                             :initial-value directory
                             :completion-function
                             (when *prompt-file-completion-function*
                               (lambda (str)
                                 (or (alexandria:emptyp str)
                                     (funcall *prompt-file-completion-function*
                                              str directory :directory-only t))))
                             :test-function (and existing #'virtual-probe-file)
                             :history-symbol 'prompt-for-directory)))
    (if (string= result "")
        default
        result)))

(defun prompt-for-library (prompt history-name)
  (macrolet ((ql-symbol-value (symbol)
               `(symbol-value (uiop:find-symbol* ,symbol :quicklisp))))
    (let ((systems
            (append
             (mapcar (lambda (x) (pathname-name x))
                     (directory
                      (merge-pathnames "**/lem-*.asd"
                                       (asdf:system-source-directory :lem-contrib))))
             (set-difference
              (mapcar #'pathname-name
                      (loop for i in (ql-symbol-value :*local-project-directories*)
                            append (directory (merge-pathnames "**/lem-*.asd" i))))
              (mapcar #'pathname-name
                      (directory (merge-pathnames "**/lem-*.asd"
                                                  (asdf:system-source-directory :lem))))
              :test #'equal))))
      (setq systems (mapcar (lambda (x) (subseq x 4)) systems))
      (prompt-for-string prompt
                         :completion-function (lambda (str) (completion str systems))
                         :test-function (lambda (system) (find system systems :test #'string=))
                         :history-symbol history-name))))

(defun prompt-for-encodings (prompt history-name)
  (let (encodings)
    (maphash (lambda (x y)
               (declare (ignore y))
               (push (string-downcase x) encodings))
             lem-base::*encoding-collections*)
    (let ((name (prompt-for-string
                 (format nil "~A(~(~A~))" prompt lem-base::*default-external-format*)
                 :completion-function (lambda (str) (completion str encodings))
                 :test-function (lambda (encoding) (or (equal encoding "")
                                                       (find encoding encodings :test #'string=)))
                 :history-symbol history-name)))
      (cond ((equal name "") lem-base::*default-external-format*)
            (t (read-from-string (format nil ":~A" name)))))))
