;;; pushbullet-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (pushbullet pushbullet-clear-devices) "pushbullet"
;;;;;;  "pushbullet.el" (21316 44458 428219 214000))
;;; Generated autoloads from pushbullet.el

(autoload 'pushbullet-clear-devices "pushbullet" "\


\(fn)" t nil)

(autoload 'pushbullet "pushbullet" "\
Pushes the selection as a note. Title defaults to buffer-name
   but is accepted as a user input. If there is no selection, the
   entire buffer is sent. With a prefix arg send to shared
   devices as well 

\(fn START END ALL\\? TITLE)" t nil)

;;;***

;;;### (autoloads nil nil ("pushbullet-pkg.el") (21316 44458 436353
;;;;;;  198000))

;;;***

(provide 'pushbullet-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pushbullet-autoloads.el ends here
