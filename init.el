(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(column-number-mode t)
 '(current-language-environment "Chinese-GB18030")
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(dired-listing-switches "-ahlp")
 '(dired-use-ls-dired nil)
 '(evil-mode t)
 '(global-evil-surround-mode t)
 '(ido-mode t nil (ido))
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tab-always-indent (quote complete))
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(which-key-idle-delay 0.125)
 '(which-key-key-replacement-alist
   (quote
    (("ESC" . "⎋")
     ("SPC" . "␣")
     ("DEL" . "⌫")
     ("RET" . "⏎")
     ("TAB" . "⇥")
     ("<\\([[:alnum:]-]+\\)>" . "\\1")
     ("left" . "←")
     ("right" . "→"))))
 '(which-key-mode t)
 '(which-key-show-remaining-keys t)
 '(which-key-side-window-location (quote (right bottom))))

(add-to-list 'default-frame-alist '(font . "Input-14"))
(add-to-list 'initial-frame-alist '(font . "Input-14"))

(load-theme 'spacemacs-light)

(require 'evil)
(require 'evil-surround)

(global-set-key (kbd "<f1>") 'neotree-toggle)
(global-set-key (kbd "M-<f1>") 'neotree-find)

(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
            (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
            (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
            (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
            (define-key evil-normal-state-local-map (kbd "v") 'neotree-enter-vertical-split)))

(ac-config-default)

(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-hook 'js-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
