;;; echo-sth-functions.el --- Sample functions for echo-sth  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Thibaut Verron

;; Author: Thibaut Verron <thibaut-suse@sherlock-suse>
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

;;; Code:

(require 'org-timer)

(define-namespace echo-sth-

(defun org-timer-countdown ()
  (org-timer-show-remaining-time))

)

