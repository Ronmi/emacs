(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(calendar-chinese-all-holidays-flag t)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(make-backup-files nil)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(php-boris-command "boris.phar")
 '(php-mode-coding-style (quote psr2))
 '(phpcbf-standard "PSR2")
 '(size-indication-mode t)
 '(typescript-enabled-frameworks (quote (typescript)))
 '(typescript-indent-level 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setenv "GOPATH" (concat (getenv "HOME") "/go"))
(setenv "GOROOT" (concat (getenv "HOME") "/goroot"))
(setenv "PATH" (concat (getenv "GOROOT") "/bin:"
		       (getenv "GOPATH") "/bin:"
		       (getenv "HOME") "/bin:"
		       (getenv "PATH")))
(setq exec-path (append (list (concat (getenv "GOROOT") "/bin")
			  (concat (getenv "GOPATH") "/bin")
			  (concat (getenv "HOME") "/bin")) exec-path))

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
			       (auto-complete-mode t)
			       (flycheck-mode)
			       (yas-global-mode t)))
		   (custom-set-variables '(gofmt-command "goimports")
					 '(flycheck-go-gofmt-executable "goimports"))
		   (setq go-packages-function 'go-packages-go-list
			 go-play-browse-function 'browse-url)
		   (add-hook 'before-save-hook #'gofmt-before-save)))
   (:name go-eldoc
	  :after (add-hook 'go-mode-hook #'go-eldoc-setup))
   (:name go-guru :depends (go-mode)
	  :type github :pkgname "golang/tools"
	  :load-path ("cmd/guru")
	  :after (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode))
   (:name go-autocomplete :depends (go-mode)
	  :type github :pkgname "nsf/gocode"
	  :load-path ("emacs"))
   
   ;; php
   (:name php-mode
	  :after (progn
		   (setq flycheck-phpcs-standard "PSR-2")
		   (add-hook 'php-mode-hook
			     (progn
			       (auto-complete-mode t)
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
			       (auto-complete-mode t)
			       (add-to-list 'write-file-functions 'delete-trailing-whitespace)
			       (setq indent-tabs-mode nil)))
		   (add-hook 'web-mode-hook
                             (lambda ()
		   	       (interactive)
		   	       (when (string-equal "tsx" (file-name-extension buffer-file-name))
		   	         (tide-mode t)
		   	         (tide-setup)
		   	         (eldoc-mode t)
		   	         (auto-complete-mode t)
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
   auto-complete
   yasnippet
   flycheck
   projectile
   xcscope

   ;; git
   magit
   magit-filenotify
   magit-tramp

   ;; golang
   go-mode
   go-guru
   go-eldoc
   go-errcheck
   go-autocomplete
   go-projectile

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
   ac-html
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

   ;; misc mode
   nginx-mode
   yaml-mode
   markdown-mode
   markdown-mode+

   ;; misc tools
   restclient))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)

(create-fontset-from-fontset-spec
 "-unknown-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-fontset-myfontset")
(set-fontset-font "fontset-myfontset" 'han (font-spec :family "WenQuanYi Micro Hei Mono" :size 20))
(add-to-list 'default-frame-alist '(font . "fontset-myfontset"))
