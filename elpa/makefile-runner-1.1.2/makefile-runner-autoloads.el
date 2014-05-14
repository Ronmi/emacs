;;; makefile-runner-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (makefile-runner makefile-runner--makefiles makefile-runner--makefile)
;;;;;;  "makefile-runner" "makefile-runner.el" (21356 27484 836683
;;;;;;  344000))
;;; Generated autoloads from makefile-runner.el

(defvar makefile-runner--makefile nil "\
Use this Makefile instead of searching for one. Intended to be
  used as a local variable (e.g. as a file variable: 
  -*- makefile-runner--makefile: \"../../Makefile\" -*-)")

(custom-autoload 'makefile-runner--makefile "makefile-runner" t)

(defvar makefile-runner--makefiles '(("Makefile" makefile-runner--get-targets-make "cd %s; make %s") ("build.xml" makefile-runner--get-targets-ant "cd %s; ant %s")) "\
A list of (MAKEFILE-FILENAME FIND-TARGETS-PROCEDURE MAKEFILE-RUN-STRING).")

(custom-autoload 'makefile-runner--makefiles "makefile-runner" t)

(autoload 'makefile-runner "makefile-runner" "\
Run nearest makefile with TARGET.

When calling interactively. The targets from the nearest makefile
is extracted and the user is asked which target to use.

Closest Makefile means first Makefile found when seacrching
upwards from the directory of the current buffer.

Set `makefile-runner--makefile' to use a specific Makefile rather
than search for one.

By default it searches for 'Makefile' and 'build.xml' files. To
add more makefiles or change the priority ordering see
`makefile-runner--makefiles'.

\(fn TARGET &optional MAKEFILE)" t nil)

;;;***

;;;### (autoloads nil nil ("makefile-runner-pkg.el") (21356 27484
;;;;;;  842625 426000))

;;;***

(provide 'makefile-runner-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; makefile-runner-autoloads.el ends here
