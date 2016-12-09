;; hide menu bar unless it's MacOS
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))

(tool-bar-mode -1)
(scroll-bar-mode -1)

;; font
(cond
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-12"))
 ((find-font (font-spec :name "Menlo"))
  (set-frame-font "Menlo-12")))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "DengXian")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; Auto-install packages
(dolist (package '(magit dracula-theme company slime))
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'dracula t)

;; Set path environment only on macOS
(when (memq window-system '(mac ns))
  (unless (package-installed-p 'exec-path-from-shell)
    (package-install 'exec-path-from-shell))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; highlight current line
(global-hl-line-mode)

;; line number
(global-linum-mode t)
(setq linum-format
      #'(lambda (line)
          (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
            (propertize (format (format " %%%dd " w) line) 'face 'linum))))

;; visual line mode
(global-visual-line-mode 1)
;; (setq-default line-spacing 0.25)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-strict-missing-semi-warning nil)

(require 'recentf)
(recentf-mode 1)

(setq less-css-compile-at-save t)
(setq less-css-lessc-options (quote ("--no-color -x")))

(setq inferior-lisp-program "sbcl")

(require 'slime)
(slime-setup '(slime-repl))
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
 '(package-selected-packages
   (quote
    (exec-path-from-shell slime company dracula-theme magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
