;;(require 'package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anaconda-mode-eldoc-as-single-line nil)
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(autopep8-args " -")
 '(autopep8-path "/home/ronmi/.py/bin/autopep8")
 '(calendar-chinese-all-holidays-flag t)
 '(column-number-mode t)
 '(custom-enabled-themes '(tsdh-dark))
 '(default-input-method "rime")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(ediff-window-setup-function ediff-window-setup-plain)
 '(emmet-indentation 2)
 '(flycheck-go-gofmt-executable "goimports")
 '(flycheck-go-vet-executable "go vet")
 '(flycheck-go-vet-shadow t)
 '(flycheck-json-python-json-executable "/usr/bin/python3")
 '(flycheck-phpcs-standard "PSR2")
 '(flycheck-python-pycompile-executable "/usr/bin/python3")
 '(global-company-mode t)
 '(gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
 '(go-eldoc-gocode-args '("-cache"))
 '(godoc-reuse-buffer t)
 '(gofmt-command "goimports")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-chain-indent t)
 '(js-indent-align-list-continuation nil)
 '(js-indent-level 2)
 '(js-switch-indent-offset 4)
 '(lsp-clients-go-server "gopls")
 '(lsp-dired-mode t)
 '(lsp-eldoc-enable-hover t)
 '(lsp-eldoc-render-all nil)
 '(lsp-eslint-auto-fix-on-save t)
 '(lsp-html-format-wrap-line-length 80)
 '(lsp-prefer-flymake nil)
 '(lsp-rust-analyzer-display-chaining-hints t)
 '(lsp-rust-analyzer-display-parameter-hints t)
 '(lsp-rust-analyzer-proc-macro-enable t)
 '(lsp-rust-analyzer-server-display-inlay-hints t)
 '(lsp-rust-server 'rust-analyzer)
 '(lsp-signature-auto-activate '(:on-trigger-char :after-completion :on-server-request))
 '(lsp-treemacs-sync-mode t)
 '(lsp-typescript-implementations-code-lens-enabled t)
 '(lsp-typescript-preferences-quote-style "single")
 '(lsp-typescript-references-code-lens-enabled t)
 '(lsp-typescript-suggest-complete-function-calls t)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-max-width 80)
 '(lsp-ui-doc-position 'top t)
 '(lsp-ui-doc-show-with-cursor t)
 '(lsp-ui-doc-show-with-mouse nil t)
 '(lsp-ui-doc-use-childframe t)
 '(lsp-ui-doc-use-webkit t)
 '(lsp-ui-flycheck-enable t)
 '(lsp-ui-sideline-diagnostic-max-line-length 80)
 '(lsp-ui-sideline-show-code-actions t)
 '(lsp-ui-sideline-show-symbol nil)
 '(lsp-vetur-format-default-formatter-html "prettier")
 '(lsp-vetur-format-options-tab-size 2)
 '(lsp-vetur-format-script-initial-indent nil)
 '(lsp-vetur-use-workspace-dependencies t)
 '(make-backup-files nil)
 '(marginalia-mode t)
 '(php-mode-coding-style 'psr2)
 '(python-check-command "/usr/bin/pyflakes3")
 '(python-shell-interpreter "/usr/bin/python3")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python3")
 '(rustic-format-trigger 'on-save)
 '(rustic-kill-buffer-and-window t)
 '(rustic-lsp-server 'rust-analyzer)
 '(size-indication-mode t)
 '(smerge-refine-ignore-whitespace t)
 '(typescript-enabled-frameworks '(typescript))
 '(typescript-indent-level 2)
 '(vertico-mode t)
 '(vue-html-extra-indent 0)
 '(vue-html-tab-width 2)
 '(warning-suppress-types '((comp))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 165 :width normal :foundry "文泉驛等寬正黑Nerd")))))
;; demo zh_TW: 示範文字示範文字:示範;文字 english()#[]-+_ 示範文字示範文字示範文字简体中文
;; 英文對照組: o01I223344556677:8899;0Oaa english()#[]-+_ bbccddeeffgghhiijjkk1lmmnnOoppqq

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
(use-package company
  :bind (:map prog-mode-map
         ("C-i" . company-indent-or-complete-common))
  :config (global-company-mode t))
(use-package vertico :config (vertico-mode t))
(use-package consult-lsp)
(use-package consult-company)
(use-package marginalia :config (marginalia-mode t))
(use-package yasnippet
  :config (yas-global-mode t)
  :hook ((go-mode
         js-mode json-mode
         typescript-mode vue-mode
         php-mode web-mode
         python-mode
         markdown-mode toml-mode yaml-mode
         rustic) . yas-minor-mode)
  )
(use-package xcscope)
(use-package treemacs)

(use-package lsp-mode
  :hook (go-mode
         js-mode json-mode
         typescript-mode vue-mode
         php-mode web-mode
         python-mode
         markdown-mode toml-mode yaml-mode
         rustic)
  :bind (("C-c w r" . lsp-workspace-restart)
         ("C-c s d" . lsp-find-definition)
         ("C-c s r" . lsp-find-references)))
(use-package lsp-ui
  :init
  (setq lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-mouse nil)
  :bind (("C-c d" . lsp-ui-doc-show)
         ("C-c I" . lsp-ui-imenu)))
(use-package lsp-docker)
(use-package lsp-origami)
(use-package dap-mode)
(use-package lsp-treemacs)

(use-package flycheck
  :hook (go-mode
         js-mode json-mode
         typescript-mode vue-mode
         php-mode web-mode
         python-mode
         markdown-mode toml-mode yaml-mode
         rustic)
  :defer)
(use-package magit :bind (("C-c C-a" . magit-status)))
(use-package magit-filenotify)
(use-package magit-tramp)
(use-package with-editor)

(use-package go-mode :config (progn
		               (custom-set-variables '(gofmt-command "goimports")
					             '(flycheck-go-gofmt-executable "goimports"))
		               (setq go-packages-function 'go-packages-go-list
			             go-play-browse-function 'browse-url)
		               (add-hook 'before-save-hook #'gofmt-before-save)))
(use-package php-mode)
(use-package protobuf-mode)
(use-package xterm-color)
(use-package rustic)
(use-package rainbow-mode)
(use-package jsonnet-mode)
(use-package nginx-mode)
(use-package yaml-mode)
(use-package toml-mode)
(use-package markdown-mode+)
(use-package markdown-preview-mode)

(use-package web-mode)
(use-package company-web)
(use-package emmet-mode
  :hook html-mode)
(use-package js2-mode)
(use-package json-mode)
(use-package json-reformat)
(use-package typescript-mode
  :config (add-hook 'typescript-mode-hook
		    (lambda ()
                      (add-node-modules-path)
		      (yas-minor-mode t)
		      (company-mode t)
		      (flycheck-mode)
                      (lsp-ui-mode t))))

(use-package vue-mode
  :config (add-hook 'vue-mode-hook
		    (lambda ()
                      (add-node-modules-path)
		      (yas-minor-mode t)
		      (company-mode t)
		      (flycheck-mode)
                      (lsp-ui-mode t))))
(use-package tide)
(use-package prettier-js :hook ((vue-mode typescript-mode) . prettier-js-mode))
(use-package add-node-modules-path)
(use-package css-eldoc)

(use-package docker)
(use-package dockerfile-mode)
(use-package k8s-mode)
(use-package kubernetes)

(use-package rime)
;; (use-package eaf
;;   :straight (eaf
;;              :type git
;;              :host github
;;              :repo "emacs-eaf/emacs-application-framework"           
;;              :files ("*.el" "*.py" "core" "app" "*.json")
;;              :includes (eaf-pdf-viewer eaf-browser eaf-terminal eaf-music-player eaf-video-player)
;;              :pre-build (("python" "install-eaf.py" "--install" "pdf-viewer" "browser" "terminal" "video-player" "music-player" "--ignore-sys-deps"))
;;              ))
;; (use-package eaf-browser
;;   :custom
;;   (eaf-browser-continue-where-left-off t)
;;   (eaf-browser-enable-adblocker t))
;; (use-package eaf-pdf-viewer)
;; (use-package eaf-music-player)
;; (use-package eaf-video-player)
;; (use-package eaf-terminal)

;; (defun open-eaf-browser ()
;;   "fuc"
;;   (interactive)
;;   (require 'eaf)
;;   (require 'eaf-browser)
;;   (call-interactively 'eaf-open-browser))
;; (global-set-key (kbd "C-c C-x b") 'open-eaf-browser)

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
