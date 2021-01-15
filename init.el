(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (slime magit company)))
 '(scroll-bar-mode nil))
(package-install-selected-packages)

;; (load-theme 'monokai t)

;; Set path environment only on macOS
;; (when (memq window-system '(mac ns))
;;   (unless (package-installed-p 'exec-path-from-shell)
;;     (package-install 'exec-path-from-shell))
;;   (require 'exec-path-from-shell)
;;   (exec-path-from-shell-initialize))

;; highlight current line
(global-hl-line-mode 1)

;; line number
(global-display-line-numbers-mode)
;; (global-linum-mode t)
;; (setq linum-format
;;       #'(lambda (line)
;;           (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
;;             (propertize (format (format " %%%dd " w) line) 'face 'linum))))

;; visual line mode
(global-visual-line-mode 1)
;; (setq-default line-spacing 0.4)
;; Set the padding between lines
;; (defvar line-padding 3)
;; (defun add-line-padding ()
;;   "Add extra padding between lines"
;;   ;; remove padding overlays if they already exist
;;   (let ((overlays (overlays-at (point-min))))
;;     (while overlays
;;       (let ((overlay (car overlays)))
;;         (if (overlay-get overlay 'is-padding-overlay)
;;             (delete-overlay overlay)))
;;       (setq overlays (cdr overlays))))
;;   ;; add a new padding overlay
;;   (let ((padding-overlay (make-overlay (point-min) (point-max))))
;;     (overlay-put padding-overlay 'is-padding-overlay t)
;;     (overlay-put padding-overlay 'line-spacing (* .1 line-padding))
;;     (overlay-put padding-overlay 'line-height (+ 1 (* .1 line-padding))))
;;   (setq mark-active nil))

;; (add-hook 'buffer-list-update-hook 'add-line-padding)

(add-hook 'after-init-hook 'global-company-mode)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 1000)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; (setq less-css-compile-at-save t)
;; (setq less-css-lessc-options (quote ("--no-color -x")))

(setq inferior-lisp-program "sbcl")

(require 'slime)
(slime-setup '(slime-repl))
(define-key slime-mode-map (kbd "C-c e") 'slime-eval-buffer)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
