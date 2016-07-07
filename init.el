;; shortcut to open init.el file
(defun user/edit-init()
  (interactive)
  (find-file "~/.config/init.el"))
(global-set-key (kbd "C-c e") 'user/edit-init)

;; shorten confirmation prompt from "yes/no" to "y/n"
(fset 'yes-or-no-p 'y-or-n-p)

(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(load-theme 'spacemacs-light t)

(tool-bar-mode -1)
(column-number-mode)
(size-indication-mode t)
(set-scroll-bar-mode nil)

(setq-default indent-tabs-mode nil tab-width 4)
(setq
 ;; just perform auto saving on the visited file instead of individual one
 auto-save-visited-file-name 't

 ;; keep backup files organized
 backup-directory-alist '(("." . "~/.emacs.d/backup"))

 ;; frame's display configurations
 default-frame-alist '((top . 12) (left . 12) (width . 120) (height . 48) (font . "Input-14"))
 initial-frame-alist '((top . 2) (left . 2) (width . 157) (height . 67))
 line-spacing 4

 ;; general indentation configuration
 standard-indent 2
 tab-always-indent 'complete
 )

;; emoji font setting
(set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)

;; evil-leader-mode
(global-evil-leader-mode)
;; evil-mode
(evil-mode)
(evil-leader/set-leader "<SPC>")
;; remap "Y" to "y$" as we always do in vim
(defun evil/copy-to-end-of-line()
  (interactive)
  (evil-yank (point) (point-at-eol)))
(define-key evil-normal-state-map "Y" 'evil/copy-to-end-of-line)
;; evil-surround-mode
(global-evil-surround-mode)

;; ido-mode
(setq ido-max-window-height 0.25
      ido-enable-flex-matching 't
      ido-use-virtual-buffers 'auto
      ido-enter-matching-directory 'first)
(ido-mode t)
(ido-everywhere t)

;; dired-mode
(setq dired-use-ls-dired nil
      dired-listing-switches "-ahlp")
(dired-async-mode t)

;; which-key-mode
(setq which-key-idle-delay 0.1
      which-key-secondary-delay 0.1
      which-key-max-description-length 30
      which-key-sort-order 'which-key-local-then-key-order)
(which-key-mode)
(which-key-setup-side-window-right-bottom)

;; show-paren-mode
(setq show-paren-delay 0.3
      show-paren-style 'parenthesis
      show-trailing-whitespace 't)
(show-paren-mode t)

;; neotree-mode
(evil-leader/set-key
  "f c" 'neotree-find
  "f d" 'neotree-dir
  "f f" 'neotree-toggle)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
            (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
            (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
            (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
            (define-key evil-normal-state-local-map (kbd "v") 'neotree-enter-vertical-split)))

;; company-mode
(setq company-idle-delay 0.2
      company-tooltip-limit 20
      company-require-match 'never
      company-tooltip-align-annotations 't)
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(progn
     (add-to-list 'company-backends 'company-emoji)
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

;; web-mode
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; js-mode
(add-hook 'js-mode-hook (lambda () (setq-local js-indent-level 2)))
