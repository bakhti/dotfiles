(use-package emacs
  :init
  ;; UI tweaks
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (setq visible-bell t)

  ;; Separate custom file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (when (file-exists-p custom-file)
    (load custom-file))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

(use-package ef-themes
  :config
  (load-theme 'ef-elea-dark t))

(use-package fontaine
  :custom
  (fontaine-presets
   '((regular
      :default-family "JetBrains Mono"
      :default-weight normal
      :default-height 150
      :fixed-pitch-family "JetBrains Mono"
      :fixed-pitch-weight nil ; falls back to :default-weight
      :fixed-pitch-height 1.0
      :variable-pitch-family "Iosevka Aile"
      :variable-pitch-weight normal
      :variable-pitch-height 1.2
      :line-spacing 1)
     (large
      :inherit regular
      :default-height 175
      :variable-pitch-height 1.3)))
  :config
  (add-hook 'enable-theme-functions #'fontaine-apply-current-preset)
  (fontaine-set-preset 'regular))

;;; Icons
(use-package nerd-icons)

(use-package nerd-icons-completion
  :after marginalia
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package vertico
  :config
  (setq vertico-resize nil
	vertico-cycle t)
  :init
  (vertico-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package corfu
  :hook (after-init . global-corfu-mode)
  ;; I also have (setq tab-always-indent 'complete) for TAB to complete
  ;; when it does not need to perform an indentation change.
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete
	corfu-preview-current nil
	corfu-min-width 20

	corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package consult
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(use-package embark
  :after vertico
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult
  :after (embark consult))

(use-package wgrep
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))

(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :hook (after-init . which-key-mode))

(use-package project
  :config
  (setq project-vc-extra-root-markers '(".project")))

(use-package magit)

(use-package envrc
  :config
  (envrc-global-mode))

(use-package go-ts-mode
  :mode "\\.go\\'"
  :hook
  ((go-ts-mode . eglot-ensure)
   (go-ts-mode . (lambda ()
		(add-hook 'before-save-hook #'eglot-format-buffer -10 t)
		(add-hook 'before-save-hook #'eglot-code-action-organize-imports nil t)))))

(use-package eglot
  :defer t
  :config
  (setq eglot-sync-connect nil
	eglot-autoshutdown t))

(use-package vterm
  :hook
  (vterm-mode . (lambda ()
		  (face-remap-add-relative
		   'default '(:family "Monofur Nerd Font Mono" :height 150)))))

(use-package org
  :config
  (require 'org-tempo)
  ;; Enable babel support for listed languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)
     (go . t)))
  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil)
  :hook (org-mode . visual-line-mode))

(use-package ob-go
  :after org)

(use-package ob-async
  :after org)

(use-package rg
  :config
  (rg-enable-default-bindings))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package 0x0)

(use-package gptel
  :init
  (setq gptel-default-mode 'org-mode
        gptel-use-curl nil
        gptel-stream t)
  (gptel-make-openai "OpenRouter"
     :host "https://openrouter.ai/api/v1"
     :key (auth-source-pick-first-password :host "openrouter.ai")
     :models '("mistralai/Mixtral-8x7B-Instruct-v0.1"
               "meta-llama/Llama-3-8b-chat-hf"))
  (gptel-make-openai "Together"
     :host "https://api.together.xyz/v1"
     :key (auth-source-pick-first-password :host "api.together.xyz")
     :models '("mistralai/Mixtral-8x7B-Instruct-v0.1"))
  :config
  (setq gptel-backend
        (gptel-make-openai "Ollama"
          :host "http://localhost:11434/v1"
          :stream t
          :models '("llama3"))))
