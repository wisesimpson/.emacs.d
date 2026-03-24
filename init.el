;;; init.el --- Modernized Emacs Configuration
;;; Optimized for Common Lisp & AI-assisted development

(require 'package)
(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

;; 自动安装并加载 use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; --- 界面与基础设置 ---
(use-package doom-themes
  :config (load-theme 'doom-one t))

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-frame-font "SF Mono-14" nil t)
  (setq-default line-spacing 4))

(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(setq inhibit-startup-screen t)
(setq select-enable-clipboard t) ;; 自动处理 macOS 剪贴板

;; --- 现代交互套件 (查找与补全) ---
(use-package vertico :init (vertico-mode 1))
(use-package orderless :init (setq completion-styles '(orderless basic)))
(use-package consult 
  :bind (("C-x C-r" . consult-recent-file)
         ("C-x b" . consult-buffer)))

;; --- 文件与位置记录 ---
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(save-place-mode 1)
(savehist-mode 1)

;; --- 核心语言环境 (Common Lisp) ---
;; 彻底移除 SLIME，全面拥抱 SLY
(use-package sly
  :config
  (setq inferior-lisp-program "sbcl")
  (setq sly-contribs '(sly-fancy)))

(use-package vterm
  :ensure t)

(defun my/claude ()
  (interactive)
  (vterm)
  (vterm-send-string "claude")
  (vterm-send-return))

(global-set-key (kbd "C-c a") 'my/claude)

;; --- 生产力插件 ---
(use-package magit)
(use-package corfu :init (global-corfu-mode))

(provide 'init)
;;; init.el ends here
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
