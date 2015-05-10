;;; project-persist-drawer.el --- Use a project drawer with project-persist.
;;
;; Copyright (c) @YEAR Robert Dallas Gray
;;
;; Author: Robert Dallas Gray <mail@robertdallasgray.com>
;; URL: https://github.com/rdallasgray/project-persist-drawer.git
;; Version: @VERSION
;; Keywords: defaults

;; This file is not part of GNU Emacs.

;;; Commentary:

;@COMMENTARY

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;;;###autoload
(define-minor-mode project-persist-drawer-mode
  "Use a project drawer with project-persist."
  :global t
  :group 'project-persist
  (if project-persist-drawer-mode
      (project-persist-drawer-on)
    (project-persist-drawer-off)))

(defun project-persist-drawer--no-adaptor ()
  (message "project-persist-drawer: no adaptor loaded, \
or adaptor does not provide this function"))

;; Adaptor interface

(defun project-persist-drawer--get-window ()
  "Return the window associated with the project drawer."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--before-open (dir)
  "Function run before the drawer is opened."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--open (dir)
  "Open the project drawer."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--after-open (dir)
  "Function run after the drawer is opened."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--before-close ()
  "Function run before the drawer is closed."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--close ()
  "Close the project drawer."
  (project-persist-drawer--no-adaptor))

(defun project-persist-drawer--after-close ()
  "Function run after the drawer is closed."
  (project-persist-drawer--no-adaptor))

;;;

(defun project-persist-drawer-open ()
  (interactive)
  (let ((project-root project-persist-current-project-root-dir))
    (setq default-directory project-root)
    (project-persist-drawer--before-open project-root)
    (project-persist-drawer--open project-root)
    (project-persist-drawer--after-open project-root)))

(defun project-persist-drawer-close ()
  (interactive)
    (project-persist-drawer--before-close)
    (project-persist-drawer--close)
    (project-persist-drawer--after-close))

(defun project-persist-drawer-toggle ()
  (interactive)
  (if (project-persist-drawer--get-window)
      (project-persist-drawer-close)
    (project-persist-drawer-open)))

(defun project-persist-drawer-on ()
  "Turn on the project-persist drawer."
  (eval-after-load 'project-persist
    '(add-hook 'project-persist-after-load-hook 'project-persist-drawer-open)))

(defun project-persist-drawer-off ()
  "Turn off the project-persist drawer."
  (eval-after-load 'project-persist
    '(remove-hook 'project-persist-after-load-hook 'project-persist-drawer-open)))

(provide 'project-persist-drawer)
;;; project-persist-drawer.el ends here
