;;; echo-sth.el --- Use an empty echo area to display some message

;; Copyright (C) 2015 Thibaut Verron
;; Licensed under the GNU General Public License.

;; Package-requires: ((names "0.5") (emacs "24"))

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;;; Commentary:

;; Activate `echo-sth-mode' to use the echo area to display something
;; when empty. Set `echo-sth-display-function' to the name of the
;; function returning the string you want to display.

;; For example, the following code displays the remaining time in the
;; current `org-timer' countdown:

;; (require 'org-timer)
;; (defun echo-sth-org-timer-cd-display-function ()
;;   (org-timer-show-remaining-time))
;; (setq echo-sth-display-function #'echo-sth-org-timer-cd-display-function)

;;; Code:


(define-namespace echo-sth-

(defcustom refresh-delay 1
  "Refresh rate for the empty echo area message")

(defcustom delay 1
  "How long to wait after the echo area is empty to start using it")

(defun -default-function ()
  "Please set `echo-sth-display-function' to a useful value!")

(defcustom display-function #'-default-function
  "Function generating the string to display in the echo area")



(defvar -display-active nil)
(defvar -timer-objects nil)

:autoload
(define-minor-mode mode
  "Use the echo area to display something if it is empty"
  :init-value nil
  :global t
  (cond (mode (and display-function
                   (setq -timer-objects
                         (list (run-with-timer 0 refresh-delay #'-redisplay)
                               (run-with-idle-timer delay t #'-display)))
                   (add-hook 'pre-command-hook #'-display-end)))
        (t (remove-hook 'pre-command-hook #'-display-end)
           (mapc 'cancel-timer -timer-objects))))

(defun -display ()
  "Activate empty echo area display."
  (interactive)
  (unless (active-minibuffer-window)
    (let* ((message-log-max nil)) ; do not insert to *Messages* buffer
      (message "%s" (funcall display-function))) 
    (setq -display-active t)))

(defun -redisplay ()
  "Update empty echo area display."
  (when -display-active (-display)))

(defun -display-end ()
  "Deactivate empty echo area display."
  (setq -display-active nil))

)




(provide 'echo-sth)
 


;;; echo-sth.el ends here
