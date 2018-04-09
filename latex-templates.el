;;; latex-templates.el --- LaTeX templates collection and management code -*- lexical-binding: t -*-

;; Copyright (C) 2017 Alexander aka 'CosmonauT' Vynnyk

;; Maintainer: cosmonaut.ok@zoho.com
;; Keywords: internal
;; Package: cosmonaut

;; latex-templates is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; latex-templates is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Cosmonaut.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; TODO:

;;; Code:

;;;
;;; latex-templates
;;;

(defgroup latex-templates nil
  "letex-templates group"
  :group 'emacs
  )

(defcustom latex-templates-global '("/usr/share/latex-templates/")
  "Global latex-templates templates directory."
  :type '(repeat (directory :format "%v"))
  :group 'latex-templates
  )

(defcustom latex-templates-private nil
  "User's latex-templates custom templates directory."
  :type '(repeat (directory :format "%v"))
  :group 'latex-templates
  )

(defun get-latex-templates-list ()
  (let (templates)
    (dolist (dir (append latex-templates-private latex-templates-global))
      (when (file-directory-p dir)
        (setq templates (append templates (directory-files dir nil ".tex")))))
    (remove-duplicates templates :test #'equal)))

(defun insert-latex-template ()
  (interactive)
  (let ((arg (ido-completing-read "Select from list: " (get-latex-templates-list))))
    (block inserting-template
      (dolist (dir (append latex-templates-private latex-templates-global))
        (when (and
               (file-directory-p dir)
               (file-exists-p (concat dir arg)))
          (insert-file-contents (concat dir arg))
          (return-from inserting-template))))))


;; (add-hook 'latex-mode-hook 'insert-latex-template)

(provide 'latex-templates)

;;; latex-templates.el ends here
