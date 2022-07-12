(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)

;; Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

(custom-set-variables
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (slime magit)))
 '(scroll-bar-mode nil)
 ;; '(global-hl-line-mode 1)
 '(global-display-line-numbers-mode t)
 '(global-visual-line-mode 1))
(package-install-selected-packages)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 100)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

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
