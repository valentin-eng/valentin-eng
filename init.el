(setq modus-themes-bold-constructs t)
(setq modus-themes-paren-match '(bold intense))
(setq modus-themes-italic-constructs t)
(setq modus-themes-region '(bg-only))
(setq modus-themes-mode-line '(borderless padded))
(load-theme 'modus-vivendi t) ;; Load modus-vivendi theme and confirm that it is safe
(setq inhibit-startup-message t) ;; Don't show welcome screen.
(tool-bar-mode -1) ;; Disable tool bar icons.
(scroll-bar-mode -1) ;; Disable scroll bar.
(menu-bar-mode -1) ;; Disable menu bar.
(global-display-line-numbers-mode 1)
(hl-line-mode 1)
(setq history-length 30)
(savehist-mode 1)
(save-place-mode 1) ;; Remember and restore the last cursor location of opended file.
(setq custom-file (locate-user-emacs-file "custom-vars.el")) ;; Move customization variables to a separate file and load it. This keeps our handcrafted init.el file clean.
(load custom-file 'noerror 'nomessage)
(setq use-dialog-box nil) ;; Don't pop-up UI dialogs when prompting.
(global-auto-revert-mode 1) ;; Revert buffers when the underlying file has changed.
(setq global-auto-revert-non-file-buffers t) ;; Revert Dired and other buffers.
