(add-to-list 'load-path "/nix/store/a9hbnwqmgkwp457lk5p25xjn54a19v36-emacs-vterm-202211f18.1354")
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(require 'vterm)
(require 'package)


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
(setq display-time-day-and-date t display-time-24hr-format t)
(display-time)
(global-set-key (kbd "C-c v") 'vterm-other-window)
;; mu4easy start

;; Add mu4e to the load-path:
(add-to-list 'load-path "/nix/store/d0r2p1f4vfkmrca6j0r5ddy181q742yg-mu-1.8.13/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'smtpmail)


;;SMTP settings:
(setq send-mail-function 'smtpmail-send-it)    ; should not be modified
(setq smtpmail-smtp-server "smtpauths.bluewin.ch") ; host running SMTP server
(setq smtpmail-servers-requiring-authorization ".*bluewin.*")
(setq smtpmail-smtp-service 465)               ; SMTP service port number
(setq smtpmail-stream-type 'ssl)          ; type of SMTP connections to use
(setq user-full-name "Valentin Gasser")
(setq user-mail-address "valentingasser@bluewin.ch")
(setq mu4e-compose-signature (concat
		"Freundliche Grüsse\n\n"	       
           "Valentin Gasser\n"
           "Marktstrasse 1\n"
           "2540 Grenchen\n" 
	   "Phone  +41 (0)32 652 14 70\n"
	   "Mobile +41 (0)79 503 80 73"))
               
(setq mu4e-compose-signature-auto-include t)
(setq message-insert-signature t)
              



;; Mail folders:
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent Items")
(setq mu4e-trash-folder  "/Trash")
(setq mu4e-change-filenames-when-moving t)

;; The command used to get your emails (adapt this line, see section 2.3):
(setq mu4e-get-mail-command "mbsync -a --config ~/.emacs.d/.mbsyncrc Bluewin")
(setq mu4e-get-mail-command "mbsync --config ~/.emacs.d/.mbsyncrc Bluewin2")
(setq mu4e-get-mail-command "mbsync -a --config ~/.emacs.d/.mbsyncrc Gmail")
;; Further customization
(setq mu4e-html2text-command "w3m -T text/html" ; how to handle html-formatted emails
      mu4e-update-interval 300                  ; seconds between each mail retrieval
      mu4e-headers-auto-update t                ; avoid to type `g' to update
      mu4e-view-show-images t                   ; show images in the view buffer
      mu4e-compose-signature-auto-include 1   ; I don't want a message signature
      mu4e-use-fancy-chars t                    ; allow fancy icons for mail threads
      mu4e-view-show-addresses 't)
      

;; Modify the expression introducing a quoted email:
(setq message-citation-line-function 'message-insert-formatted-citation-line)
(setq message-citation-line-format "Am %Y-%m-%d  %T %Z, %f hat geschrieben :\n")
(setq mu4e-view-show-images t)
(setq mu4e-use-fancy-chars t)
(setq mu4e-attachment-dir  "~/Downloads")

;; Configure desktop notifs for incoming emails:
(require 'alert)
(use-package mu4e-alert
  :ensure t
  :init)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
(mu4e-alert-set-default-style 'libnotify)
(alert-add-rule :category "mu4e-alert" :style 'mode-line :predicate (lambda (_) (string-match-p "^mu4e-" (symbol-name major-mode))) :continue t)
(setq mu4e-alert-notify-repeated-mails 1)
;; attachment reminder based on
;; http://emacs-fu.blogspot.co.uk/2008/12/highlighting-todo-fixme-and-friends.html
(set-face-attribute 'font-lock-warning-face nil :foreground "red" :weight 'bold :background "yellow")
(add-hook 'mu4e-compose-mode-hook
          (defun bjm/mu4e-highlight-attachment ()
            "Flag attachment keywords"
            (font-lock-add-keywords nil
                                    '(("\\(attach\\|pdf\\|file\\)" 1 font-lock-warning-face t)))))


