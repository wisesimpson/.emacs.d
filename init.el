(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; (use-package dracula-theme
;;   :ensure t
;;   :config
;;   (load-theme 'dracula t))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  ;; (set-face-attribute 'default nil :font "SF Mono" :height 150)
  (set-frame-font "SF Mono-14" nil t)
  (setq-default line-spacing 4))

(setq inhibit-startup-screen t)

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)

(defun update-kill-ring-from-pbpaste (&rest _)
  "If system clipboard content is different from top of kill ring, push it in."
  (let ((clip (shell-command-to-string "pbpaste")))
    (when (and (not (string= clip ""))
               (or (null kill-ring)
                   (not (string= clip (car kill-ring)))))
      (kill-new clip))))

;; Advice yank to always update from clipboard first
(advice-add 'yank :before #'update-kill-ring-from-pbpaste)

(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(save-place-mode 1)
(savehist-mode 1)

(use-package recentf
  :ensure nil
  :init
  (setq recentf-max-saved-items 200
        recentf-auto-cleanup 'never)
  :config
  (recentf-mode 1)
  (add-hook 'after-init-hook #'recentf-open-files))

(global-set-key (kbd "C-x C-r") #'recentf-open-files)

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

(setq inferior-lisp-program "sbcl")

(use-package slime
  :ensure t)
(slime-setup '(slime-fancy))

(with-eval-after-load 'slime
  (define-key slime-mode-map      (kbd "TAB") #'indent-for-tab-command)
  (define-key slime-repl-mode-map (kbd "TAB") #'indent-for-tab-command)
  (define-key slime-mode-map (kbd "C-c e") #'slime-eval-buffer))

(use-package magit :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
