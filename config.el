;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)

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
 '(lsp-eldoc-render-all nil)
 '(lsp-eslint-auto-fix-on-save t)
 '(lsp-html-format-wrap-line-length 80)
 '(lsp-prefer-flymake nil)
 '(lsp-rust-analyzer-display-chaining-hints t)
 '(lsp-rust-analyzer-display-parameter-hints t)
 '(lsp-rust-analyzer-proc-macro-enable t)
 '(lsp-rust-analyzer-server-display-inlay-hints t)
 '(lsp-rust-server 'rust-analyzer)
 '(lsp-typescript-implementations-code-lens-enabled t)
 '(lsp-typescript-preferences-quote-style "single")
 '(lsp-typescript-references-code-lens-enabled t)
 '(lsp-typescript-suggest-complete-function-calls t)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-position 'top)
 '(lsp-ui-doc-use-childframe t)
 '(lsp-ui-doc-use-webkit nil)
 '(lsp-ui-flycheck-enable t)
 '(lsp-vetur-format-default-formatter-html "prettier")
 '(lsp-vetur-format-options-tab-size 2)
 '(lsp-vetur-format-script-initial-indent nil)
 '(lsp-vetur-use-workspace-dependencies t)
 '(make-backup-files nil)
 '(package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(compat org dart-mode xref ssass-mode vue-html-mode tree-mode company rainbow-mode queue))
 '(php-mode-coding-style 'psr2)
 '(python-check-command "/usr/bin/pyflakes3")
 '(python-shell-interpreter "/usr/bin/python3")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python3")
 '(rustic-format-trigger 'on-save)
 '(rustic-kill-buffer-and-window t)
 '(rustic-lsp-server 'rust-analyzer)
 '(size-indication-mode t)
 '(smerge-refine-ignore-whitespace t t)
 '(typescript-enabled-frameworks '(typescript))
 '(typescript-indent-level 2)
 '(vue-html-extra-indent 0)
 '(vue-html-tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "WenQuanYi Zen Hei Mono" :weight normal :width normal :height 160)))))

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)
    (require 'el-get-elpa)
    (el-get-elpa-build-local-recipes)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; demo zh_TW: 示範文字示範文字:示範;文字 english()#[]-+_ 示範文字示範文字示範文字简体中文
;; 英文對照組: o01I223344556677:8899;0Oaa english()#[]-+_ bbccddeeffgghhiijjkk1lmmnnOoppqq
;;(set-fontset-font "fontset-startup" 'latin (font-spec :family "DejaVu Sans Mono" :size 18))
;;(set-fontset-font "fontset-startup" 'han (font-spec :family "WenQuanYi Micro Hei Mono" :size 22))
;;(add-to-list 'default-frame-alist '(font . "fontset-startup"))
;;(add-to-list 'default-frame-alist '(font . "WenQuanYi Zen Hei Mono"))
;; (set-fontset-font "fontset-startup" 'latin (font-spec :family "WenQuanYi Zen Hei Mono" :size 20))
;; (set-fontset-font "fontset-startup" 'han (font-spec :family "WenQuanYi Zen Hei Mono" :size 20))
;; (add-to-list 'default-frame-alist '(font . "fontset-startup"))

(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))

(setq
 el-get-sources
 '(
   (:name flycheck
   	  :after (global-flycheck-mode))
   (:name yasnippet
          :after (yas-global-mode t))

   (:name treemacs
          :after (progn
                   (add-hook 'treemacs-mode-hook
                             (lambda ()
                               (treemacs-follow-mode t)
                               (treemacs-filewatch-mode t)))
                   (global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
                   (global-set-key (kbd "C-x t B") 'treemacs-bookmark)
                   (global-set-key (kbd "C-x t C-f") 'treemacs-find-file)
                   (global-set-key (kbd "C-x t M-t") 'treemacs-find-tag)
                   (global-set-key (kbd "C-x t t") 'treemacs)))

   ;; lsp
   (:name lsp-mode
          :after (progn
                   (add-hook 'js-mode-hook #'lsp-deferred)
                   (add-hook 'html-mode-hook #'lsp-deferred)
                   (add-hook 'lsp-mode-hook
                             (lambda ()
                               (define-key lsp-mode-map (kbd "C-c w r") #'lsp-workspace-restart)
                               (define-key lsp-mode-map (kbd "C-c p d") #'lsp-describe-thing-at-point)
                               (define-key lsp-mode-map (kbd "C-c s d") #'lsp-find-definition)
                               (define-key lsp-mode-map (kbd "C-c s r") #'lsp-find-references)
                               (define-key lsp-mode-map (kbd "C-c g t") #'lsp-goto-type-definition)
                               (define-key lsp-mode-map (kbd "C-c g i") #'lsp-goto-implementation)
                               (define-key lsp-mode-map (kbd "C-c f i") #'lsp-organize-imports)
                               (define-key lsp-mode-map (kbd "C-c f f") #'lsp-format-buffer)))))
   
   ;; git
   (:name magit
          :info nil
	  :after (global-set-key (kbd "C-c C-a") 'magit-status))
   (:name magit-filenotify
	  :after (add-hook 'magit-status-mode-hook #'magit-filenotify-mode))

   ;; golang
   (:name go-mode
	  :after (progn
                   (add-hook 'go-mode-hook #'lsp-deferred)
		   (add-hook 'go-mode-hook
			     (lambda ()
                               (lsp-ui-mode t)
			       (company-mode t)
			       (flycheck-mode)
			       (yas-minor-mode t)))
		   (custom-set-variables '(gofmt-command "goimports")
					 '(flycheck-go-gofmt-executable "goimports"))
		   (setq go-packages-function 'go-packages-go-list
			 go-play-browse-function 'browse-url)
		   (add-hook 'before-save-hook #'gofmt-before-save)))

   ;; php
   (:name php-mode
	  :after (progn
		   (setq flycheck-phpcs-standard "PSR-2")
                   (add-hook 'php-mode-hook #'lsp-deferred)
		   (add-hook 'php-mode-hook
			     (lambda ()
                               (lsp-ui-mode t)
			       (company-mode t)
			       (flycheck-mode)
			       (yas-minor-mode t)))))

   ;; js
   (:name typescript-mode
          :after (progn
                   (add-hook 'typescript-mode-hook #'lsp)
                   (add-hook 'typescript-mode-hook #'prettier-js-mode)
                   (add-hook 'typescript-mode-hook #'add-node-modules-path)
		   (add-hook 'typescript-mode-hook
			     (lambda ()
			       (yas-minor-mode t)
			       (company-mode t)
			       (flycheck-mode)
                               (lsp-ui-mode t)))))
   (:name vue-mode
          :after (progn
                   (add-hook 'vue-mode-hook #'lsp)
                   (add-hook 'vue-mode-hook #'prettier-js-mode)
                   (add-hook 'vue-mode-hook #'add-node-modules-path)
		   (add-hook 'vue-mode-hook
			     (lambda ()
			       (yas-minor-mode t)
			       (company-mode t)
			       (flycheck-mode)
                               (lsp-ui-mode t)))))
   

   ;; html
   (:name emmet-mode
	  :after (progn
                   (add-hook 'html-mode-hook #'emmet-mode)
                   (add-hook 'web-mode-hook #'emmet-mode)))

   ;; dart
   (:name dart-mode
          :after (progn
                   (add-hook 'dart-mode-hook 'lsp)
                   (add-hook 'lsp-mode-hook (lambda nil (define-key lsp-mode-map (kbd "C-c f r") #'lsp-dart-dap-flutter-hot-reload)))
                   (setq gc-cons-threshold (* 100 1024 1024)
                         read-process-output-max (* 1024 1024)
                         company-minimum-prefix-length 1
                         lsp-lens-enable t
                         lsp-signature-auto-activate nil)))

   ;; solidity
   (:name solidity-mode
          :after (progn
		   (add-hook 'solidity-mode-hook
			     (lambda ()
                               (require 'solidity-flycheck)
                               (require 'company-solidity)
                               (set (make-local-variable 'company-backends)
		                    (append '((company-solidity company-capf company-dabbrev-code))
			                    company-backends))
                               (setq flycheck-solidity-solc-addstd-contracts t)
                               (setq solidity-flycheck-solium-checker-active t)
                               (setq solidity-flycheck-solc-checker-active t)
                               (setq solidity-comment-style (quote slash))
                               (setq solidity-solium-path "solium")
		               (yas-minor-mode t)
			       (company-mode t)
			       (flycheck-mode)
                               (lsp-ui-mode t)))))
   
   (:name markdown-mode+  :depends (markdown-mode)
	  :type github :pkgname "milkypostman/markdown-mode-plus")

   (:name eaf
	  :type github :pkgname "emacs-eaf/emacs-application-framework"
          :autoloads nil)))


;; fix elpa bug
(setq package-check-signature nil)

(setq
 my:el-get-packages
 '(el-get
   ;; common tools
   company-mode
   ;; company-tabnine
   yasnippet
   xcscope

   ;; lsp and treemacs
   treemacs
   lsp-mode
   lsp-docker
   lsp-origami
   dap-mode
   lsp-ui
   lsp-treemacs

   ;; git
   magit
   magit-filenotify
   magit-tramp
   with-editor ; magit dep

   ;; golang
   go-mode

   ;; php
   php-mode

   ;; docker
   docker
   docker-tramp
   dockerfile-mode

   ;; html
   web-mode
   company-web
   emmet-mode

   ;; typescript and javascript
   js2-mode
   json-mode
   json-reformat
   typescript-mode
   vue-mode
   tide
   prettier-js
   add-node-modules-path

   ;; css tools
   css-eldoc

   ;; protobuf
   protobuf-mode

   ;; rust
   projectile
   xterm-color
   rustic

   ;; dart
   dart-mode
   lsp-dart
   hover

   ;; ethereum
   solidity-mode
   
   ;; misc mode
   rainbow-mode
   jsonnet-mode
   nginx-mode
   yaml-mode
   toml-mode
   markdown-mode
   markdown-mode+
   markdown-preview-mode
   easy-hugo

   ;; misc tools
   eaf
   xml-rpc-el
   weblogger-el
   restclient))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)
(put 'upcase-region 'disabled nil)

(with-eval-after-load 'tramp
  (cl-pushnew '("-A")
              (cadr (assoc 'tramp-login-args
                           (assoc "ssh" tramp-methods)))
              :test #'equal))

;; (with-eval-after-load 'company
;;   (add-to-list 'company-backends 'company-tabnine))
(defun open-eaf-browser ()
  "fuc"
  (interactive)
  (require 'eaf)
  (require 'eaf-browser)
  (call-interactively 'eaf-open-browser))
(global-set-key (kbd "C-c C-x b") 'open-eaf-browser)

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
