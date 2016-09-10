(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-linum-mode 1)
(global-visual-line-mode 1)
(setq-default line-spacing 2)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
'(js2-strict-missing-semi-warning nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq inferior-lisp-program "sbcl")

(require 'slime)
(define-key slime-mode-map (kbd "C-c e") 'slime-eval-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("427fed191e7a766152e59ef0e2904283f436dbbe259b9ccc04989f3acde50a55" default)))
 '(package-selected-packages
   (quote
    (js2-mode dracula-theme slime-company company slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
