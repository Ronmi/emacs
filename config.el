
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
 '(flycheck-go-gofmt-executable "goimports")
 '(flycheck-go-vet-executable "go vet")
 '(flycheck-go-vet-shadow t)
 '(flycheck-json-python-json-executable "/usr/bin/python3")
 '(flycheck-phpcs-standard "PSR2")
 '(flycheck-python-pycompile-executable "/usr/bin/python3")
 '(go-eldoc-gocode-args (quote ("-cache")))
 '(gofmt-command "goimports")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 4)
 '(js-switch-indent-offset 4)
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
 '(typescript-indent-level 4)
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

(setenv "GOPATH" (concat (getenv "HOME") "/go"))
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
   (:name exec-path-from-shell
	  :after (progn
		   (setq exec-path-from-shell-variables
			 (quote ("PATH" "GOPATH" "GOROOT")))
		   (exec-path-from-shell-initialize)))
   ;; git
   (:name magit
	  :after (global-set-key (kbd "C-c C-a") 'magit-status))
   (:name magit-filenotify
	  :after (add-hook 'magit-status-mode-hook #'magit-filenotify-mode))

   ;; golang
   (:name go-mode
	  :after (progn
		   (add-hook 'go-mode-hook
			     (progn
			       (company-mode t)
			       (flycheck-mode)
			       (yas-global-mode t)))
		   (custom-set-variables '(gofmt-command "goimports")
					 '(flycheck-go-gofmt-executable "goimports"))
		   (setq go-packages-function 'go-packages-go-list
			 go-play-browse-function 'browse-url)
		   (add-hook 'before-save-hook #'gofmt-before-save)))
   (:name go-eldoc
	  :after (add-hook 'go-mode-hook #'go-eldoc-setup))
   (:name go-company :depends (go-mode)
	  :type github :pkgname "stamblerre/gocode"
	  :load-path ("emacs-company"))

   ;; php
   (:name php-mode
	  :after (progn
		   (setq flycheck-phpcs-standard "PSR-2")
		   (add-hook 'php-mode-hook
			     (progn
			       (company-mode t)
			       (flycheck-mode)
			       (yas-global-mode t)))))
   (:name php-extras :depends (php-mode)
	  :type github :pkgname "arnested/php-extras"
	  :after (add-hook 'php-mode-hook #'eldoc-mode))
   (:name phpcbf :depends (php-mode)
	  :type github :pkgname "nishimaki10/emacs-phpcbf")
   (:name php-boris :depends (php-mode)
	  :type github :pkgname "tomterl/php-boris")

   ;; html
   (:name emmet-mode
	  :after (add-hook 'html-mode-hook #'emmet-mode))

   ;; typescript and javascript
   (:name tide
	  :after (progn
		   (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
		   (add-hook 'typescript-mode-hook
			     (lambda ()
			       (interactive)
			       (tide-mode t)
			       (tide-setup)
			       (eldoc-mode t)
			       (flycheck-mode t)
			       (company-mode t)
			       (add-to-list 'write-file-functions 'delete-trailing-whitespace)
			       (setq indent-tabs-mode nil)))
		   (add-hook 'web-mode-hook
                             (lambda ()
		   	       (interactive)
		   	       (when (string-equal "tsx" (file-name-extension buffer-file-name))
		   	         (tide-mode t)
		   	         (tide-setup)
		   	         (eldoc-mode t)
		   	         (company-mode t)
		   	         (add-to-list 'write-file-functions 'delete-trailing-whitespace)
		   	         (setq indent-tabs-mode nil))))))

   ;; misc modes
   (:name nginx-mode
	  :type github :pkgname "ajc/nginx-mode")
   (:name markdown-mode+  :depends (markdown-mode)
	  :type github :pkgname "milkypostman/markdown-mode-plus")
   ))

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
   exec-path-from-shell

   ;; git
   magit
   magit-filenotify
   magit-tramp
   with-editor ; magit dep

   ;; golang
   go-mode
   go-eldoc
   go-company

   ;; php
   php-mode
   php-extras
   phpcbf
   php-boris
   ac-php

   ;; docker
   docker
   docker-tramp
   dockerfile-mode

   ;; html
   web-mode
   company-web
   emmet-mode
   web-mode-extension

   ;; typescript and javascript
   js2-mode
   ac-js2
   json-mode
   json-reformat
   typescript-mode
   tss
   tide

   ;; css tools
   css-eldoc
   css-palette

   ;; protobuf
   protobuf-mode

   ;; misc mode
   nginx-mode
   yaml-mode
   markdown-mode
   markdown-mode+

   ;; misc tools
   xml-rpc-el
   weblogger-el
   restclient))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)
