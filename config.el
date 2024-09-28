
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))


(setq package-enable-at-startup nil
      straight-use-package-by-default t)
(straight-use-package 'use-package)

(straight-use-package
 '(systemd :type git :host github :repo "widefox/systemd-mode"))

(use-package emacs
  :custom
  (ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
  (custom-enabled-themes '(tsdh-dark))
  (gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (make-backup-files nil)
  (size-indication-mode t)
  (column-number-mode t)
  (smerge-refine-ignore-whitespace t)
  (warning-suppress-types '((comp)))
  :config
  ;; demo zh_TW: 示範文字示範文字:示範;文字 english()#[]-+_ 示範文字示範文字示範文字简体中文
  ;; 英文對照組: o01I223344556677:8899;0Oaa english()#[]-+_ bbccddeeffgghhiijjkk1lmmnnOoppqq
  (custom-set-faces
   '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 165 :width normal :foundry "文泉驛等寬正黑Nerd"))))))

(use-package all-the-icons)

;; auto complete and related layout packages
(use-package company
  :bind (:map prog-mode-map
              ("C-i" . company-indent-or-complete-common))
  :config (global-company-mode t))
(use-package company-box
  :after (company all-the-icons)
  :hook (company-mode . company-box-mode)
  :init (setq company-box-icons-alist 'company-box-icons-all-the-icons))
(use-package consult-lsp)
(use-package consult)
(use-package consult-company)
;;(use-package vertico :config (vertico-mode t))
(use-package marginalia
  :config (marginalia-mode t)
  :after vertico)
(use-package all-the-icons-completion
  :after marginalia
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))
(use-package xcscope)
(use-package treemacs)
(use-package yasnippet
  :diminish yas-minor-mode
  :hook (prog-mode . yas-minor-mode)
  :config (yas-reload-all))
(use-package yasnippet-snippets
  :defer t
  :after yasnippet)

(defconst my-fuck '(go-mode json-mode))

;; lsp with builtin eglot, simple but not guarantee to be fast
;; (use-package eglot
;;   :straight (:type built-in)
;;   :hook (prog-mode . eglot-ensure))

;; lsp with lsp-mode
(use-package lsp-mode
  :hook
  ((go-mode
    php-mode
    rust-mode
    js2-mode json-mode typescript-mode vue-mode tide
    web-mode yaml-mode toml-mode markdown-mode+ css-mode) . lsp-mode)
  :custom
  (read-process-output-max (* 3 1024 1024))
  (lsp-dired-mode t)
  (lsp-eldoc-enable-hover t)
  (lsp-eldoc-render-all nil)
  (lsp-prefer-flymake nil)
  (lsp-signature-auto-activate
   '(:on-trigger-char :after-completion :on-server-request))
  :config
  ;; disable watch in remote
  (add-to-list 'lsp-file-watch-ignored-directories "/sshx?:")
  ;; lsp rust hack
  (require 's)
  (cl-defmethod lsp-clients-extract-signature-on-hover (contents (_server-id (eql rust-analyzer)))
    (-let* (((&hash "value") contents)
            (groups (--partition-by (s-blank? it) (s-lines value)))
            (sig_group (if (s-equals? "```rust" (car (-third-item groups)))
                           (-third-item groups)
                         (car groups)))
            (sig (--> sig_group
                      (--drop-while (s-equals? "```rust" it) it)
                      (--take-while (not (s-equals? "```" it)) it)
                      (s-join "" it))))
      (lsp--render-element (concat "```rust\n" sig "\n```"))))
  :bind (("C-c w r" . lsp-workspace-restart)
         ("C-c s d" . lsp-find-definition)
         ("C-c s r" . lsp-find-references)))
(use-package lsp-ui
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-width 80)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-sideline-diagnostic-max-line-length 80)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-symbol nil)
  :bind
  (("C-c d" . lsp-ui-doc-show)
   ("C-c I" . lsp-ui-imenu)))
(use-package lsp-docker)
(use-package lsp-origami)
(use-package dap-mode
  :hook
  (require 'dap-dlv-go))
(use-package lsp-treemacs
  :custom
  (lsp-treemacs-sync-mode t))
;; using flycheck with lsp-mode
(use-package flycheck
  :init
  (global-flycheck-mode))

;; major modes for programming languages
(use-package go-mode
  :custom
  (gofmt-command "goimports")
  (flycheck-go-gofmt-executable "goimports")
  (lsp-clients-go-server "gopls")
  (flycheck-go-vet-executable "go vet")
  (flycheck-go-vet-shadow t)
  (go-eldoc-gocode-args '("-cache"))
  (godoc-reuse-buffer t)
  :config
  (setq
   go-packages-function 'go-packages-go-list
   go-play-browse-function 'browse-url)
  :hook
  (before-save . gofmt-before-save))
(use-package php-mode
  :custom
  (flycheck-phpcs-standard "PSR2")
  (php-mode-coding-style 'psr2))
(use-package rust-mode
  :custom
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-proc-macro-enable t)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-server 'rust-analyzer))
(use-package js2-mode
  :custom
  (js-chain-indent t)
  (js-indent-align-list-continuation nil)
  (js-indent-level 2)
  (js-switch-indent-offset 4))
(use-package json-mode)
(use-package json-reformat)
(use-package typescript-mode
  :custom
  (typescript-enabled-frameworks '(typescript))
  (typescript-indent-level 2)
  (lsp-typescript-implementations-code-lens-enabled t)
  (lsp-typescript-preferences-quote-style "single")
  (lsp-typescript-references-code-lens-enabled t)
  (lsp-typescript-suggest-complete-function-calls t))
(use-package vue-mode
  :custom
  (vue-html-extra-indent 0)
  (vue-html-tab-width 2))
(use-package tide)
(use-package prettier-js
  :hook
  ((vue-mode typescript-mode) . prettier-js-mode))
(use-package add-node-modules-path
  :hook
  ((vue-mode typescript-mode) . add-node-modules-path))
;; use builtin python mode with lsp-pyright
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

;; major modes for misc lang (mostly markups)
(use-package web-mode)
(use-package company-web)
(use-package emmet-mode
  :custom
  (emmet-indentation 2)
  :hook
  html-mode)
(use-package yaml-mode)
(use-package toml-mode)
(use-package markdown-mode+)
(use-package markdown-preview-mode)
(use-package protobuf-mode)
(use-package css-eldoc)

;; major modes for config files
(use-package nginx-mode)
(use-package dockerfile-mode)

;; general tools
(use-package magit :bind (("C-c C-a" . magit-status)))
(use-package magit-filenotify)
(use-package magit-tramp)
(use-package with-editor)
(use-package docker)
(use-package k8s-mode)
(use-package kubernetes)
(use-package rime
  :custom
  (default-input-method "rime"))
(use-package xterm-color)
(use-package org)
(use-package sql-indent)

(defun my/telega-online-status ()
  (derived-mode-p 'telega-root-mode 'telega-chat-mode
		  'telega-image-mode 'telega-webpage-mode))

(use-package telega
  :straight (:type git :host github :repo "zevlg/telega.el")
  :custom
  (telega-use-docker t)
  (telega-use-images t)
  (telega-emoji-use-images t)
  (telega-online-status-function #'my/telega-online-status)
  :defer t)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)
              ("C-<return>" . copilot-accept-completion))
  :custom
  (copilot-indent-offset-warning-disable t)
  :ensure t)
