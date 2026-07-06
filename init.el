;;; init.el --- Modernized Emacs Configuration
;;; Optimized for Common Lisp & AI-assisted development

(require 'package)
(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

;; 自动安装并加载 use-package
(unless (package-installed-p 'use-package)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; --- 界面与基础设置 ---
(use-package doom-themes
  :config (load-theme 'doom-one t))

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-face-attribute 'default nil :family "Menlo" :height 140)
  (set-fontset-font t 'han (font-spec :family "PingFang SC"))
  (set-fontset-font t 'cjk-misc (font-spec :family "PingFang SC"))
  (setq-default line-spacing 4))

(menu-bar-mode -1)
(dolist (hook '(eat-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                sly-mrepl-mode-hook))
  (add-hook hook (lambda () (display-line-numbers-mode 0))))
(add-hook 'text-mode-hook #'visual-line-mode)
(setq inhibit-startup-screen t)
(setq select-enable-clipboard t) ;; 自动处理 macOS 剪贴板
;; macOS clipboard support for terminal Emacs
(when (and (eq system-type 'darwin)
           (not (display-graphic-p)))
  (defun my/pbcopy (text &optional _push)
    "Copy TEXT to macOS clipboard using pbcopy."
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" nil "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (defun my/pbpaste ()
    "Paste text from macOS clipboard using pbpaste."
    (let ((text (shell-command-to-string "pbpaste")))
      (unless (string= text "")
        text)))

  (setq interprogram-cut-function #'my/pbcopy
        interprogram-paste-function #'my/pbpaste))

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

(use-package eat
  :ensure t)

(defun my/agent ()
  (interactive)
  (eat "codex"))

(global-set-key (kbd "C-c a") 'my/agent)

;; --- 生产力插件 ---
(use-package magit)
(use-package corfu :init (global-corfu-mode))

(provide 'init)
;;; init.el ends here
