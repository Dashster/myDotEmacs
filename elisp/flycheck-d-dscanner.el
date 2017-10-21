;;; flycheck-d-dscanner.el --- Add D Dscanner support to flycheck

;; Copyright (C) 2016 by Per Nordlöw

;; Author: Per Nordlöw <per.nordlow@gmail.com>
;; Package-Requires: ((flycheck "0.21-cvs1") (dash "1.4.0"))
;; Keywords: flycheck, d

;;; Code:
(require 'flycheck)
(require 'dash)

(flycheck-define-checker d-dscanner-syntax
  "A D syntax checker using Dscanner.
See URL `https://github.com/Hackerpilot/Dscanner/'."
  :command ("dscanner" "--syntaxCheck" source)
  :error-patterns ((error line-start (file-name) "(" line ":" column ")[error]: " (message) line-end)
                   (warning line-start (file-name) "(" line ":" column ")[warn]: " (message) line-end))
  :modes d-mode
  :next-checkers (d-dscanner-style))

(flycheck-define-checker d-dscanner-style
  "A D style checker using Dscanner.
See URL `https://github.com/Hackerpilot/Dscanner/'."
  :command ("dscanner" "--styleCheck" source)
  :error-patterns ((error line-start (file-name) "(" line ":" column ")[error]: " (message) line-end)
                   (warning line-start (file-name) "(" line ":" column ")[warn]: " (message) line-end))
  :modes d-mode
  :next-checkers (d-dmd-all))

;;;###autoload
(defun setup-flycheck-d-dscanner ()
  "Set up for flycheck D dscanner checkers."
  (add-to-list 'flycheck-checkers 'd-dscanner-syntax 'append)
  (add-to-list 'flycheck-checkers 'd-dscanner-style 'append)
  (flycheck-add-next-checker 'd-dmd '(warning . d-dscanner-style)))

(provide 'flycheck-d-dscanner)
;;; flycheck-d-dscanner.el ends here
