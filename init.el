;; hide menu bar unless it's MacOS
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))

(tool-bar-mode -1)
(scroll-bar-mode -1)

;; font
(set-fontset-font "fontset-startup" 'unicode (font-spec :name "Consolas" :size 32) nil)
(set-fontset-font "fontset-startup" 'unicode (font-spec :name "Menlo") nil 'append)

;; line number
(global-linum-mode t)
(setq linum-format
      #'(lambda (line)
          (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
            (propertize (format (format " %%%dd" w) line) 'face 'linum))))

(global-visual-line-mode 1)
(setq-default line-spacing 2)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-strict-missing-semi-warning nil)

(require 'recentf)
(recentf-mode 1)

(setq less-css-compile-at-save t)
(setq less-css-lessc-options (quote ("--no-color -x")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq inferior-lisp-program "sbcl")

(require 'slime)
(define-key slime-mode-map (kbd "C-c e") 'slime-eval-buffer)

;; key binding
(when (eq system-type 'darwin)
  (global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
  (global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("427fed191e7a766152e59ef0e2904283f436dbbe259b9ccc04989f3acde50a55" default))))
