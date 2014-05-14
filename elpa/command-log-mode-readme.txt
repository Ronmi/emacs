This add-on can be used to demo Emacs to an audience.  When
activated, keystrokes get logged into a designated buffer, along
with the command bound to them.

To enable, use e.g.:

(require 'command-log-mode)
(add-hook 'LaTeX-mode-hook 'command-log-mode)

To see the log buffer, call M-x clm/open-command-log-buffer.
