
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
 '(custom-enabled-themes (quote (tsdh-dark)))
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
 '(go-eldoc-gocode-args (quote ("-cache")))
 '(godoc-reuse-buffer t)
 '(gofmt-command "goimports")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-chain-indent t)
 '(js-indent-align-list-continuation nil)
 '(js-indent-level 4)
 '(js-switch-indent-offset 4)
 '(lsp-clients-go-server "gopls")
 '(lsp-eldoc-render-all nil)
 '(lsp-html-format-wrap-line-length 80)
 '(lsp-prefer-flymake nil)
 '(lsp-typescript-implementations-code-lens-enabled t)
 '(lsp-typescript-preferences-quote-style "single")
 '(lsp-typescript-references-code-lens-enabled t)
 '(lsp-typescript-suggest-complete-function-calls t)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-position (quote top))
 '(lsp-ui-doc-use-childframe t)
 '(lsp-ui-doc-use-webkit nil)
 '(lsp-ui-flycheck-enable t)
 '(lsp-vetur-format-default-formatter-html "prettier")
 '(lsp-vetur-format-options-tab-size 2)
 '(lsp-vetur-format-script-initial-indent nil)
 '(lsp-vetur-use-workspace-dependencies t)
 '(make-backup-files nil)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(php-boris-command "boris.phar")
 '(php-mode-coding-style (quote psr2))
 '(phpcbf-standard "PSR2")
 '(python-check-command "/usr/bin/pyflakes3")
 '(python-shell-interpreter "/usr/bin/python3")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python3")
 '(rustic-format-trigger (quote on-save))
 '(rustic-indent-method-chain t)
 '(rustic-indent-where-clause t)
 '(safe-local-variable-values
   (quote
    ((python-shell-interpreter . "python")
     (python-shell-virtualenv-root . "/home/ronmi/play/python/ordering/env")
     (python-shell-virtualenv-root . "../env")
     (pyvenv-activate . "../env")
     (python-shell-interpreter-args . "manage.py shell")
     (python-shell-interpreter . "../env/bin/python3")
     (python-shell-interpreter . "python3")
     (python-shell-interpreter . "./env/bin/python3")
     (python-shell-interpreter . "env/bin/python3")
     (python-shell-virtualenv-path . "env")
     (pyvenv-activate . "env"))))
 '(size-indication-mode t)
 '(smerge-refine-ignore-whitespace t t)
 '(typescript-enabled-frameworks (quote (typescript)))
 '(typescript-indent-level 2)
 '(vue-html-extra-indent 0)
 '(vue-html-tab-width 2)
 '(web-mode-code-indent-offset 2)
 '(weblogger-config-alist
   (quote
    (("81k" "https://81k.today/xmlrpc.php" "ronmi" "" "1")
     ("food" "https://food.ronmi.tw/xmlrpc.php" "ronmi" "" "1")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; demo zh_TW: 示範文字示範文字:示範;文字 english()#[]-+_ 示範文字示範文字示範文字简体中文
;; 英文對照組: o01I223344556677:8899;0Oaa english()#[]-+_ bbccddeeffgghhiijjkk1lmmnnOoppqq
(set-fontset-font "fontset-startup" 'latin (font-spec :family "DejaVu Sans Mono" :size 18))
(set-fontset-font "fontset-startup" 'han (font-spec :family "WenQuanYi Micro Hei Mono" :size 22))
(add-to-list 'default-frame-alist '(font . "fontset-startup"))

(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))
;; (setenv "GOPATH" (concat (getenv "HOME") "/go"))
;; (setenv "PATH" (concat (getenv "GOROOT") "/bin:"
;; 		       (getenv "GOPATH") "/bin:"
;; 		       (getenv "HOME") "/bin:"
;; 		       (getenv "PATH")))
;; (setq exec-path (append (list (concat (getenv "GOROOT") "/bin")
;; 			  (concat (getenv "GOPATH") "/bin")
;; 			  (concat (getenv "HOME") "/bin")) exec-path))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq
 el-get-sources
 '(
   (:name flycheck
   	  :after (global-flycheck-mode))
   (:name yasnippet
          :after (yas-global-mode t))

   ;; treemacs
   (:name pfuture
          :type github :pkgname "Alexander-Miller/pfuture")
   (:name treemacs
          :type github :pkgname "Alexander-Miller/treemacs"
          :depends (f s dash cl-lib ace-window pfuture ht hydra)
          :load-path ("./src/elisp" "./src/extra")
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
   (:name dap-mode
          :website "https://github.com/emacs-lsp/dap-mode"
          :description "Emacs client/library for the Debugger Adaptor Protocol"
          :type github
          :pkgname "emacs-lsp/dap-mode")
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
   (:name lsp-treemacs
          :type github :pkgname "emacs-lsp/lsp-treemacs")
   
   ;; git
   (:name magit
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
   (:name php-extras :depends (php-mode)
	  :type github :pkgname "arnested/php-extras"
	  :after (add-hook 'php-mode-hook #'eldoc-mode))
   (:name phpcbf :depends (php-mode)
	  :type github :pkgname "nishimaki10/emacs-phpcbf")
   (:name php-boris :depends (php-mode)
	  :type github :pkgname "tomterl/php-boris")

   ;; js
   (:name typescript-mode
          :after (progn
                   (add-hook 'typescript-mode-hook #'lsp)
		   (add-hook 'typescript-mode-hook
			     (lambda ()
			       (yas-minor-mode t)
			       (company-mode t)
			       (flycheck-mode)
                               (lsp-ui-mode t)))))
   (:name edit-indirect
          :type github :pkgname "Fanael/edit-indirect")
   (:name ssass-mode
          :type github :pkgname "AdamNiederer/ssass-mode")
   (:name vue-html-mode
          :type github :pkgname "AdamNiederer/vue-html-mode")
   (:name vue-mode :depends (mmm-mode edit-indirect vue-html-mode ssass-mode)
          :type github :pkgname "AdamNiederer/vue-mode"
          :after (progn
                   (add-hook 'vue-mode-hook #'lsp)
                   (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
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

   ;; rust
   (:name rustic
          :type github :pkgname "brotzeit/rustic")
   
   ;; misc modes
   (:name jsonnet-mode
	  :type github :pkgname "mgyucht/jsonnet-mode")
   (:name nginx-mode
	  :type github :pkgname "ajc/nginx-mode")
   (:name markdown-mode+  :depends (markdown-mode)
	  :type github :pkgname "milkypostman/markdown-mode-plus")))

;; fix elpa bug
(setq package-check-signature nil)

(setq
 my:el-get-packages
 '(el-get
   ;; common tools
   company-mode
   yasnippet
   flycheck
   xcscope

   ;; lsp and treemacs
   treemacs
   lsp-mode
   dap-mode
   lsp-ui
   company-lsp
   lsp-treemacs

   ;; git
   magit
   magit-filenotify
   magit-tramp
   with-editor ; magit dep

   ;; golang
   go-mode
   go-company

   ;; php
   php-mode
   php-extras
   phpcbf
   php-boris

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

   ;; css tools
   css-eldoc

   ;; protobuf
   protobuf-mode

   ;; rust
   projectile
   xterm-color
   rustic
   
   ;; misc mode
   jsonnet-mode
   nginx-mode
   yaml-mode
   toml-mode
   markdown-mode
   markdown-mode+
   markdown-preview-mode

   ;; misc tools
   xml-rpc-el
   weblogger-el
   restclient))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)
(put 'upcase-region 'disabled nil)
(defun add-ssh-agent-to-tramp ()
  (cl-pushnew '("-A")
              (cadr (assoc 'tramp-login-args
                                        ; if on Windows using Putty with Pageant,
                                        ; replace "ssh" with "plink"
                           (assoc "ssh" tramp-methods)))
              :test #'equal))
