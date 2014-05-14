
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-indent-assign-indent-level 4)
 '(auto-indent-multiple-indent-modes (quote (php-mode python-mode coffee-mode haskell-mode haml-mode yaml-mode slim-mode scss-mode)))
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(erc-modules (quote (autoaway autojoin button completion dcc keep-place list log match menu move-to-prompt notifications page readonly services smiley stamp spelling track ercn hl-nicks netsplit fill networks ring noncommands irccontrols menu)))
 '(foreground-color "#839496")
 '(indent-tabs-mode nil)
 '(ispell-dictionary "american")
 '(make-backup-files nil)
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(php-completion-file "~/.emacs.d/php/php-completion-file")
 '(php-manual-path "/usr/share/doc/php-doc/html")
 '(php-manual-url "nil")
 '(speedbar-indentation-width 2)
 '(tramp-gvfs-methods (quote ("dav" "davs" "obex" "synce" "ftp" "sftp" "smb")))
 '(yas/use-menu t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; run php codesniffer when press f8 key
;; php lint
(defun phpcs-thisfile ()
  (interactive)
  (compile (format "phpcs --standard=PSR2 %s" (buffer-file-name))))
(add-hook 'php-mode-hook
          '(lambda ()
             (local-set-key [f8] 'phpcs-thisfile)
             (yas-minor-mode t)))
(add-hook 'php-mode-hook
          (lambda ()
            (auto-complete t)
            (auto-complete-mode t)
            (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)))
;; end of php lint
(setq php-auto-yasnippet-php-program "~/.emacs.d/Create-PHP-YASnippet.php")

(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(defun unindent-closure ()
  "Fix php-mode indent for closures"
  (let ((syntax (mapcar 'car c-syntactic-context)))
    (if (and (member 'arglist-cont-nonempty syntax)
             (or
              (member 'statement-block-intro syntax)
              (member 'brace-list-intro syntax)
              (member 'brace-list-close syntax)
              (member 'block-close syntax)))
       (save-excursion
          (beginning-of-line)
          (delete-char (* (count 'arglist-cont-nonempty syntax)
                          c-basic-offset))) )))

(add-hook 'php-mode-hook
          (lambda ()
            (add-hook 'c-special-indent-hook 'unindent-closure)))

(load-file "~/.emacs.d/liu.el")
