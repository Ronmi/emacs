
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

(use-package emacs
  :custom
  (ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
  (custom-enabled-themes '(tsdh-dark))
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (make-backup-files nil)
  (size-indication-mode t)
  (column-number-mode t)
  (custom-file "~/.emacs.d/custom.el")
  (smerge-refine-ignore-whitespace t)
  (auth-sources '(password-store))
  (warning-suppress-types '((comp)))
  (warning-minimum-level :emergency)
  :config
  ;; demo zh_TW: 示範文字示範文字:示範;文字 english()#[]-+_ 示範文字示範文字示範文字简体中文
  ;; 英文對照組: o01I223344556677:8899;0Oaa english()#[]-+_ bbccddeeffgghhiijjkk1lmmnnOoppqq
  ;; 長度:01234567 201234567 301234567 401234567 501234567 601234567 7012
 (custom-set-faces
  '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 151 :width normal :foundry "DAMA" :family "UbuntuMono Nerd Font Mono"))))))


(use-package all-the-icons)

;; auto complete and related layout packages
(use-package company
  :bind (:map prog-mode-map
              ("C-i" . company-indent-or-complete-common)
              ("C-'" . consult-company))
  :config (global-company-mode t))
(use-package company-box
  :after (company all-the-icons)
  :hook (company-mode . company-box-mode)
  :init (setq company-box-icons-alist 'company-box-icons-all-the-icons))
(use-package vertico
  :config (vertico-mode t))
;; DEL/M-DEL remove a whole path component in find-file
(use-package vertico-directory
  :straight nil
  :after vertico
  :bind (:map vertico-map
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  ;; keep prefix-style TAB completion for file names
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-c c g" . consult-grep)
         ("C-c c f" . consult-find)
         ("C-c c l" . consult-line)
         ("C-c c m" . consult-mark)
         ))
(use-package consult-lsp)
(use-package consult-jq
  :straight (:host github :repo "elken/consult-jq")
  :bind (("C-c c q" . consult-jq))
  :commands (consult-jq))
(use-package consult-company)
;;(use-package vertico :config (vertico-mode t))
(use-package marginalia
  :config (marginalia-mode t))
(use-package all-the-icons-completion
  :after marginalia
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))
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
    rust-mode
    js-mode json-mode typescript-mode
    web-mode yaml-mode toml-mode markdown-mode css-mode scss-mode) . lsp-mode)
  :custom
  (read-process-output-max (* 10 1024 1024))
  (lsp-dired-mode t)
  (lsp-eldoc-enable-hover t)
  (lsp-eldoc-render-all nil)
  (lsp-signature-auto-activate
   '(:on-trigger-char :after-completion :on-server-request))
  :config
  (add-to-list 'lsp-disabled-clients '(typescript-mode . vue-semantic-server))
  (add-to-list 'lsp-disabled-clients '(js-mode . vue-semantic-server))
  (add-to-list 'lsp-disabled-clients '(json-mode . vue-semantic-server))
  (add-to-list 'lsp-disabled-clients '(css-mode . vue-semantic-server))
  ;; disable watch in remote
  (add-to-list 'lsp-file-watch-ignored-directories "/sshx?:")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]node_modules\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]src-capacitor[/\\\\]android[/\\\\](.+[/\\\\])?build\\'")
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
  :bind (("s-l w r" . lsp-workspace-restart)
         ("s-l s r" . lsp-rename)
         ("s-l f d" . lsp-find-definition)
         ("s-l f t" . lsp-find-type-definition)
         ("s-l f i" . lsp-find-implementation)
         ("s-l f r" . lsp-find-references)
         ("s-l s a" . lsp-ui-sideline-apply-code-actions)
         ;; key maps when s-l is not usable like in wsl
         ("C-c l w" . lsp-workspace-restart)
         ("C-c l n" . lsp-rename)
         ("C-c l d" . lsp-find-definition)
         ("C-c l t" . lsp-find-type-definition)
         ("C-c l i" . lsp-find-implementation)
         ("C-c l r" . lsp-find-references)
         ("C-c l a" . lsp-ui-sideline-apply-code-actions)
         ("C-c l e" . lsp-treemacs-error-list)))
(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-width 80)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-show-with-mouse t)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-sideline-diagnostic-max-line-length 80)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-symbol nil)
  (lsp-ui-sideline-show-hover nil)
  :bind
  (("s-l u d" . lsp-ui-doc-show)
   ("s-l u i" . lsp-ui-imenu)))
(use-package dap-mode
  :config
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
  (flycheck-go-vet-shadow t)
  (godoc-reuse-buffer t)
  :config
  (setq
   go-packages-function 'go-packages-go-list
   go-play-browse-function 'browse-url)
  :hook
  (before-save . gofmt-before-save))
(use-package rust-mode
  :custom
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-proc-macro-enable t)
  (lsp-inlay-hint-enable t)
  (lsp-rust-server 'rust-analyzer))
(use-package js
  :straight (:type built-in)
  :custom
  (js-chain-indent t)
  (js-indent-align-list-continuation nil)
  (js-indent-level 2)
  (js-switch-indent-offset 2))
(use-package json-mode)
(use-package typescript-mode
  :custom
  (typescript-enabled-frameworks '(typescript))
  (typescript-indent-level 2)
  (lsp-clients-typescript-prefer-use-project-ts-server t)
  (lsp-typescript-references-code-lens-enabled t)
  (lsp-typescript-implementations-code-lens-enabled t)
  (lsp-typescript-suggest-complete-function-calls t))
(defun my/jsx-buffer-p ()
  "Return non-nil if current buffer visits a .jsx or .tsx file."
  (and buffer-file-name
       (string-match-p "\\.[jt]sx\\'" buffer-file-name)))
(use-package prettier-js
  :custom
  (prettier-js-args '("exec" "--no" "-p" "prettier" "--"))
  (prettier-js-command "npm")
  :hook
  ((typescript-mode . prettier-js-mode)
   (web-mode . (lambda () (when (my/jsx-buffer-p) (prettier-js-mode))))))
(use-package add-node-modules-path
  :hook
  ((js-mode typescript-mode web-mode) . add-node-modules-path))
;; use builtin python mode with lsp-pyright
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; protobuf mode (with clang-format)
;; lsp mode is not enabled with protobuf mode by default
(use-package clang-format+
  :straight
  (clang-format+
   :type git
   :host github
   :repo "SavchenkoValeriy/emacs-clang-format-plus")
  :hook
  (protobuf-mode . clang-format+-mode)
  :custom
  (clang-format+-context 'buffer))
(use-package protobuf-mode)


;; major modes for misc lang (mostly markups)
(use-package web-mode
  :mode "\\.[jt]sx\\'"
  :custom
  (web-mode-content-types-alist '(("jsx" . "\\.[jt]sx\\'")))
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2))
(use-package emmet-mode
  :custom
  (emmet-indentation 2)
  :hook
  (html-mode web-mode))
(use-package ssass-mode
  :mode "\\.sass\\'")
(use-package yaml-mode
  :hook (yaml-mode . lsp-deferred))
(use-package toml-mode
  :hook (toml-mode . lsp-deferred))
(use-package markdown-mode
  :hook (markdown-mode . lsp-deferred))
(use-package markdown-preview-mode)

;; major modes for config files
(use-package nginx-mode)
(use-package dockerfile-mode)
(use-package nix-mode)
(use-package systemd :straight (:type git :host github :repo "widefox/systemd-mode"))

;; general tools
(use-package tramp
  :straight (:type built-in)
  :defer t
  :config
  ;; (eval-after-load "tramp-sh" '(defun tramp-set-remote-path(vec)))
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path "~/bin")
  (connection-local-set-profile-variables
   'remote-bash
   '((explicit-shell-file-name . "/bin/bash")
     (explicit-bash-args . ("-l" "-i"))))
  (connection-local-set-profiles
   '(:application tramp :protocol "ssh")
   'remote-bash))
(use-package magit :bind (("C-c C-a" . magit-status)))
(use-package with-editor)
(use-package docker)
(use-package k8s-mode)
(use-package kubernetes)
(use-package rime
  :custom
  (default-input-method "rime"))
(use-package xterm-color)
(use-package xclip
  :hook (tty-setup . xclip-mode))
(use-package org :straight (:type built-in))
(use-package sql-indent)
(use-package pass)

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

(defun copilot/cancel-on-electric-indent-chars (arg)
  "Cancel copilot completion eagerly when electric-indent-mode is triggered."

  (interactive "p")

  ;; clear the overlay if visible and keypress is in electric-indent-chars. Not really a rejection, so maybe let's not notify it as such?
  (when (and (copilot--overlay-visible)
             (memq last-command-event electric-indent-chars))
    (delete-overlay copilot--overlay)
    (setq copilot--real-posn nil))

  ;; continue on to self-insert command. With the copilot overlay cleared, electric-indent-mode will not be misbehave.
  (self-insert-command arg))

;; eaf although it does not work on my machine
;; (use-package eaf
;;   :straight (eaf
;;              :type git
;;              :host github
;;              :repo "emacs-eaf/emacs-application-framework"
;;              ;; disable auto install to avoid re-installing every time
;;              ;; :pre-build ("./install-eaf.py" "--install-all-apps")
;;              :files ("*.py" "*.json" "*.el" "core" "app" "extension")
;; 	     :includes (eaf-pdf-viewer
;; 			eaf-git
;; 			eaf-browser
;; 			eaf-map
;; 			eaf-markdown-previewer)))
;; (use-package eaf-browser
;;   :custom
;;     (eaf-browser-continue-where-left-off t)
;;     (eaf-browser-enable-adblocker t))
;; (use-package eaf-markdown-previewer)

;; writing tool

;; enabled wc-mode to count words
(use-package wc-mode)
;; make wc-mode count CJK words correctly
(use-package advance-words-count
  :straight (:host github :repo "LdBeth/advance-words-count.el")
  :hook (wc-mode . (lambda ()
               (setq wc-count-words-function
                     (function
                      (lambda (start end)
                        (let ((cnt (advance-words-count start end)))
                          (+ (car cnt) (car (last cnt))))))))))


;;;;;;;;;;;;;;;;;;;;; AI tools

;; copilot auto completion
(defun copilot/override-electric-keys ()
  "Override electric keys for copilot."
  (dolist (char electric-indent-chars)
    (message "disable electric-indent-mode for %s" (char-to-string char))
    (define-key copilot-completion-map (vector char) 'copilot/cancel-on-electric-indent-chars)))
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)
              ("C-<return>" . copilot-accept-completion))
  :custom
  (copilot-indent-offset-warning-disable t)
  :config
  (add-hook 'typescript-mode-hook 'copilot/override-electric-keys))


;; load last so packages referenced by custom.el are already installed
(load custom-file)
