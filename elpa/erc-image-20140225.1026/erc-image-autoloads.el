;;; erc-image-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "erc-image" "erc-image.el" (21316 42338 356337
;;;;;;  983000))
;;; Generated autoloads from erc-image.el

(eval-after-load 'erc '(define-erc-module image nil "Display inlined images in ERC buffer" ((add-hook 'erc-insert-modify-hook 'erc-image-show-url t) (add-hook 'erc-send-modify-hook 'erc-image-show-url t)) ((remove-hook 'erc-insert-modify-hook 'erc-image-show-url) (remove-hook 'erc-send-modify-hook 'erc-image-show-url)) t))

;;;***

;;;### (autoloads nil nil ("erc-image-pkg.el") (21316 42338 363279
;;;;;;  603000))

;;;***

(provide 'erc-image-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; erc-image-autoloads.el ends here
