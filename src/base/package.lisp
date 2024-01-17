(defpackage :lem-base/indent
  (:use :cl)
  (:export
   :back-to-indentation
   :indent-tabs-mode
   :calc-indent-function
   :indent-when-yank
   :indent-line
   :indent-points
   :indent-buffer
   :insert-string-and-indent))

(defpackage :lem-base/encodings
  (:use :cl)
  (:export
   :encoding
   :internal-encoding
   :encoding-external-format
   :encodings
   :encoding-read
   :encoding-write
   :register-encoding
   :encoding-end-of-line
   :unregister-encoding
   :encoding-read-detect-eol
   :encoding-check))

(defpackage :lem-base/file
  (:use :cl)
  (:local-nicknames (:encodings :lem-base/encodings))
  (:export
   :*find-file-hook*
   :before-save-hook
   :after-save-hook
   :*external-format-function*
   :*find-directory-function*
   :*default-external-format*
   :encoding-read-error
   :insert-file-contents
   :find-file-buffer
   :write-to-file
   :write-region-to-file
   :update-changed-disk-date
   :changed-disk-p))

(uiop:define-package :lem-base
  (:use :cl
        :lem-base/line
        :lem-base/syntax-table)
  (:use-reexport :lem-base/utils)
  (:use-reexport :lem-base/icon)
  (:use-reexport :lem-base/string-width-utils)
  (:use-reexport :lem-base/errors)
  (:use-reexport :lem-base/hooks)
  (:use-reexport :lem-base/file-utils)
  (:use-reexport :lem-base/buffer-list-manager)
  (:use-reexport :lem-base/file)
  (:use-reexport :lem-base/indent)
  (:use-reexport :lem-base/encodings)
  (:use-reexport :lem-base/var)
  (:use-reexport :lem-base/interrupt)
  ;; editor-variables.lisp
  (:export
   :tab-width)
  ;; var-buffer.lisp
  (:export
   :make-per-buffer-hook)
  ;; macros.lisp
  (:export
   :with-point
   :with-buffer-read-only)
  ;; mark.lisp
  (:export
   :mark
   :mark-point
   :mark-active-p
   :mark-cancel
   :mark-set-point)
  ;; buffer.lisp
  (:export
   :fundamental-mode
   :primordial-buffer
   :current-buffer
   :make-buffer
   :buffer
   :text-buffer
   :bufferp
   :buffer-start-point
   :buffer-end-point
   :deleted-buffer-p
   :buffer-name
   :buffer-temporary-p
   :buffer-modified-tick
   :buffer-modified-p
   :buffer-read-only-p
   :buffer-syntax-table
   :buffer-major-mode
   :buffer-minor-modes
   :buffer-mark-object
   :buffer-mark-p
   :buffer-mark
   :buffer-point
   :buffer-nlines
   :buffer-encoding
   :buffer-last-write-date
   :buffer-enable-undo-p
   :buffer-enable-undo
   :buffer-disable-undo
   :buffer-filename
   :buffer-directory
   :buffer-unmark
   :buffer-mark-cancel
   :buffer-attributes
   :buffer-rename
   :buffer-undo
   :buffer-redo
   :buffer-undo-boundary
   :buffer-enable-undo-boundary
   :buffer-disable-undo-boundary
   :buffer-value
   :buffer-unbound
   :clear-buffer-variables
   :with-buffer-point
   :with-current-buffer)
  (:export
   :buffer-list
   :any-modified-buffer-p
   :modified-buffers
   :get-buffer
   :get-or-create-buffer
   :unique-buffer-name
   :delete-buffer
   :get-next-buffer
   :get-previous-buffer
   :unbury-buffer
   :bury-buffer
   :get-file-buffer)
  ;; buffer-insert.lisp
  (:export
   :*inhibit-read-only*
   :*inhibit-modification-hooks*
   :before-change-functions
   :after-change-functions)
  ;; point.lisp
  (:export
   :current-point
   :point
   :pointp
   :copy-point-using-class
   :copy-point
   :delete-point
   :point-buffer
   :point-charpos
   :point-kind
   :point=
   :point/=
   :point<
   :point<=
   :point>
   :point>=
   :point-closest
   :point-min
   :point-max)
  ;; basic.lisp
  (:export
   :first-line-p
   :last-line-p
   :start-line-p
   :end-line-p
   :start-buffer-p
   :end-buffer-p
   :same-line-p
   :move-point
   :line-start
   :line-end
   :buffer-start
   :buffer-end
   :line-offset
   :character-offset
   :character-at
   :line-string
   :text-property-at
   :put-text-property
   :remove-text-property
   :next-single-property-change
   :previous-single-property-change
   :insert-character
   :insert-string
   :delete-character
   :erase-buffer
   :region-beginning
   :region-end
   :map-region
   :points-to-string
   :count-characters
   :delete-between-points
   :count-lines
   :apply-region-lines
   :line-number-at-point
   :point-column
   :move-to-column
   :position-at-point
   :move-to-position
   :point-bytes
   :move-to-bytes
   :move-to-line
   :set-current-mark
   :blank-line-p
   :skip-chars-forward
   :skip-chars-backward
   :insert-buffer
   :buffer-text)
  ;; syntax-table.lisp
  (:export
   :syntax-table
   :set-syntax-parser
   :fundamental-syntax-table)
  ;; syntax-predicates.lisp
  (:export
   :current-syntax
   :with-current-syntax
   :make-syntax-table
   :syntax-word-char-p
   :syntax-space-char-p
   :syntax-symbol-char-p
   :syntax-open-paren-char-p
   :syntax-closed-paren-char-p
   :syntax-string-quote-char-p
   :syntax-escape-char-p
   :syntax-expr-prefix-char-p
   :syntax-skip-expr-prefix-forward
   :syntax-skip-expr-prefix-backward)
  ;; search.lisp
  (:export
   :*case-fold-search*
   :search-forward
   :search-backward
   :search-forward-regexp
   :search-backward-regexp
   :search-forward-symbol
   :search-backward-symbol
   :looking-at
   :match-string-at)
  ;; syntax-scan.lisp
  (:export
   :skip-space-and-comment-forward
   :skip-space-and-comment-backward
   :form-offset
   :scan-lists
   :forward-down-list
   :forward-up-list
   :backward-up-list
   :backward-down-list
   :skip-whitespace-forward
   :skip-whitespace-backward
   :skip-symbol-forward
   :skip-symbol-backward
   :symbol-region-at-point
   :symbol-string-at-point
   :make-pps-state
   :pps-state-type
   :pps-state-token-start-point
   :pps-state-end-char
   :pps-state-block-comment-depth
   :pps-state-block-pair
   :pps-state-paren-stack
   :pps-state-paren-depth
   :parse-partial-sexp
   :syntax-ppss
   :pps-state-string-p
   :pps-state-comment-p
   :pps-state-string-or-comment-p
   :in-string-p
   :in-comment-p
   :in-string-or-comment-p
   :maybe-beginning-of-string
   :maybe-beginning-of-comment
   :maybe-beginning-of-string-or-comment)
  ;; syntax-parser.lisp
  (:export
   :syntax-string-attribute
   :syntax-comment-attribute
   :syntax-keyword-attribute
   :syntax-constant-attribute
   :syntax-function-name-attribute
   :syntax-variable-attribute
   :syntax-type-attribute
   :*global-syntax-highlight*
   :before-syntax-scan-hook
   :after-syntax-scan-hook
   :enable-syntax-highlight
   :enable-syntax-highlight-p
   :syntax-scan-region)
  ;; tmlanguage.lisp
  (:export
   :make-tmlanguage
   :make-tm-repository
   :make-tm-match
   :make-tm-region
   :make-tm-include
   :make-tm-patterns
   :make-tm-name
   :add-tm-repository
   :add-tm-pattern))

(use-package :lem-base :lem-base/encodings)
(use-package :lem-base :lem-base/indent)
(use-package :lem-base :lem-base/file)

#+sbcl
(sb-ext:lock-package :lem-base)
