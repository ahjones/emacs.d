(add-to-list 'load-path "~/.emacs.d/user-lisp/")

(setq custom-file "~/.emacs.d/user-lisp/customised.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(set-frame-font "DejaVu Sans Mono-8")

(blink-cursor-mode -1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq inhibit-startup-screen t)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq require-final-newline t)

(global-auto-revert-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key
 (kbd "<f12>")
 (lambda ()
   (interactive)
   (find-file "~/.emacs.d/init.el")))

(global-hl-line-mode 1)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package paredit
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)

(use-package clojure-mode
  :ensure t
  :pin melpa-stable
  :config
  (defun clojure-config ()
    "Configure clojure mode"
    (local-set-key (kbd "C-S-k") 'paredit-copy-as-kill)
    (yas-minor-mode))
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook #'clojure-config)
  (add-hook 'clojure-mode-hook #'eldoc-mode))

(use-package cider
  :ensure t
  :hook clojure-setup
  :pin melpa-stable
  :init
  (setq cider-repl-pop-to-buffer-on-connect nil)
  :config
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (add-hook 'cider-repl-mode-hook #'subword-mode)
  (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
  (setq cider-repl-use-pretty-printing t)
  (setq cider-repl-print-length 50)
  (setq cider-repl-print-level 10))

(use-package clj-refactor
  :ensure t
  :pin melpa-stable
  :init
  (setq cljr-warn-on-eval nil)
  (add-hook 'clojure-mode-hook 'clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-c C-m")
  :diminish clj-refactor-mode)

(use-package solarized-theme
  :ensure t)

(use-package ace-jump-mode
  :ensure t
  :bind (("C-c SPC" . ace-jump-mode)
         ("C-x SPC" . ace-jump-mode-pop-mark)))

(use-package restclient
  :ensure t)

(use-package better-defaults
  :ensure t)

(use-package smart-mode-line
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (color-theme-sanityinc-tomorrow-bright))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("M-y". helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("M-<f5>" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf)))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package use-package-ensure-system-package
  :ensure t)

(use-package rg
  :ensure t
  :ensure-system-package rg
  :config
  (rg-enable-default-bindings))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode t))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  :config
  (global-company-mode))

(use-package markdown-mode
  :ensure t)

(use-package terraform-mode
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)))
