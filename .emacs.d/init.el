;; 简化是否选择
(fset 'yes-or-no-p 'y-or-n-p)

;; 使用 UTF-8 作为默认语言环境
(set-language-environment "UTF-8")

;; 编辑时隐藏鼠标的光标
(mouse-avoidance-mode 'cat-and-mouse)

;; 为 Emoji 图标指明可用的字体（macOS）
(set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)

;; 关闭无用的内建模式
(mapc (lambda (mode)
        (when (fboundp mode) (funcall mode -1)))
      '(tool-bar-mode
        scroll-bar-mode
        fringe-mode
        global-linum-mode
        global-hl-line-mode))

;; 开启有用的内建模式
(mapc (lambda (mode)
        (when (fboundp mode) (funcall mode)))
      '(mwheel-install
        winner-mode
        windmove-default-keybindings
        column-number-mode
        auto-image-file-mode
        auto-compression-mode
        global-font-lock-mode
        global-auto-revert-mode
        temp-buffer-resize-mode))

;; 排除 TRAMP 文件备份
(add-to-list 'backup-directory-alist (cons tramp-file-name-regexp nil))

(setq-default
 ;; 光标形状
 cursor-type 'bar

 ;; 用空格代替制表符
 indent-tabs-mode nil

 ;; 制表符宽度
 tab-width 4
 )

(setq
 ;; 永远加载较新的 elisp
 load-prefer-newer t

 ;; 遵从加载文件设定的本地变量
 enable-local-eval t
 
 ;; 默认窗体
 default-frame-alist '((top . 20) (left . 20)
                       (width . 120) (height . 60)
                       (vertical-scroll-bars . nil)
                       (font . "Input-14"))

 ;; 初始窗体
 initial-frame-alist '((top . 2) (left . 2)
                       (width . 158) (height . 67))

 ;; 禁用首屏
 inhibit-splash-screen t

 ;; Just In Time font-locking
 font-lock-maximum-decoration t
 font-lock-support-mode 'jit-lock-mode

 ;; 即使有版本控制也备份
 vc-make-backup-files t
 
 ;; 集中备份文件存放位置
 backup-directory-alist `(("." . ,(expand-file-name "backup" user-emacs-directory)))

 ;; 禁用自动备份
 ;; make-backup-files nil

 ;; 禁用自动保存
 auto-save-default nil

 ;; 可视响铃
 visible-bell t

 ;; 调整行距
 line-spacing 3

 ;; 通用缩进
 standard-indent 2
 tab-always-indent 'complete

 ;; 永远增加末尾空行
 require-final-newline t

 ;; 搜索高亮
 search-highlight t

 ;; 非贪婪的搜索全部
 search-whitespace-regexp ".*?"

 ;; 编译窗口高度
 compilation-window-height 10

 ;; 编译询问是否保存
 compilation-ask-about-save nil

 ;; 滚动至编译的首条错误
 compilation-scroll-output 'first-error

 ;; 静默自动更新缓冲
 auto-revert-verbose nil

 ;; 自动更新非文件的缓冲
 global-auto-revert-non-file-buffers t

 ;; 安全禁用 create-lockfiles
 safe-local-variable-values '((create-lockfiles) create-lockfiles))

;; ==============================================================================

;; 初始化包管理机制
(require 'package)
(setq package-enable-at-startup nil)
(nconc package-archives '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;; 使用 use-package 作为包管理器
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 为 use-package 提供键位绑定和模式标识抑制的附加能力
(eval-when-compile
  (eval-after-load 'advice `(setq ad-redefinition-action 'accept))
  (require 'use-package))
(require 'bind-key)
(require 'diminish)

;; 使用 quelpa 增强 use-package
(use-package quelpa-use-package
  :ensure t
  :config
  (setq quelpa-checkout-melpa-p nil))

;; ==============================================================================

(defun open-user-init-file()
  "打开用户的初始化配置文件"
  (interactive)
  (find-file-other-frame "~/.emacs.d/init.el"))

(defun hidden-dos-eol ()
  "隐藏烦人的 DOS end of line 字符"
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "删除恼人的 DOS end of line 标记"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun smart-split-window (window)
  "Split window side by side as long as screen is wide enough."
  (let ((split-height-threshold (and (< (window-width window)
                                        split-width-threshold)
                                     split-height-threshold)))
    (split-window-sensibly window)))
(setq split-window-preferred-function #'smart-split-window)

(defun imenu-use-package ()
  "Extract use-package lines to be used as anchors in imenu."
  (add-to-list 'imenu-generic-expression
               '(nil "\\(^\\s-*(use-package +\\)\\(\\_<.+\\_>\\)" 2)))
(add-hook 'emacs-lisp-mode-hook #'imenu-use-package)

(defun occur-on-point ()
  "根据光标所在位置查找关键词的出现位置"
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s M-o") #'occur-on-point)

;; ==============================================================================

;; show-paren-mode
(setq show-paren-delay 0.1
      show-paren-style 'parenthesis
      show-trailing-whitespace t)

(add-hook 'prog-mode-hook #'show-paren-mode)

;; not sure why this fails...
;; (define-advice show-paren-function (:around (fn) find-nearest-parenthsis)
;;   (cond ((looking-at-p "\\s(") (funcall fn))
;;         (t (save-excursion
;;              (ignore-errors (backward-up-list))
;;              (funcall fn)))))

;; ido-mode
(use-package ido
  :ensure t
  :defer t
  :init
  (setq ido-enable-regexp t
        ido-enable-dot-prefix t
        ido-max-window-height 0.2
        ido-enable-flex-matching t
        ido-use-virtual-buffers 'auto
        ido-rotate-file-list-default t
        ido-enter-matching-directory 'only)
  (add-hook 'after-init-hook 'ido-mode)
  (add-hook 'ido-setup-hook 'ido-everywhere))

;; until we find the limits of ido mode...
;; (use-package swiper
;;   :ensure t
;;   :diminish ivy-mode
;;   :init (setq ivy-height 3
;;               ivy-use-virtual-buffers t
;;               ivy-count-format "(%d/%d) ")
;;   :config (add-hook 'after-init-hook 'ivy-mode))

;; dired-mode
(setq dired-use-ls-dired nil
      dired-recursive-copies 'always
      dired-listing-switches "-Ahlp")
(add-hook 'dired-load-hook '(lambda () (load "dired-x")))
(add-hook 'dired-load-hook #'dired-async-mode)

(with-eval-after-load 'dired
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "RET") #'dired-find-alternate-file))

;; other useful modes
(add-hook 'after-init-hook #'recentf-mode)
(add-hook 'after-init-hook #'delete-selection-mode)

(use-package exec-path-from-shell
  :ensure t
  :defer 1
  :config (when (memq window-system '(mac ns))
            (exec-path-from-shell-initialize)))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init (setq which-key-idle-delay 0.2
              which-key-secondary-delay 0.1
              which-key-max-description-length 30
              which-key-sort-order #'which-key-local-then-key-order)  
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :init
  (setq company-idle-delay 0.1
        company-tooltip-limit 10
        company-require-match 'never
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t)
  (add-hook 'prog-mode-hook #'company-mode)
  :bind (("C-TAB" . company-complete)
         ("<C-tab>" . company-complete)
         :map company-active-map
         ("M-n" . nil)
         ("M-p" . nil)
         ("<up>" . nil)
         ("<down>" . nil)
         ("C-n" . company-select-next-or-abort)
         ("C-p" . company-select-previous-or-abort)
         ("C-o" . company-filter-candidates)
         ("S-TAB" . company-select-previous)
         ("<backtab>" . company-select-previous)
         ("TAB" . company-complete-common-or-cycle)
         ("<tab>" . company-complete-common-or-cycle)))

(use-package evil
  :ensure t
  :diminish evil-mode
  :init
  (setq evil-default-state 'emacs
        evil-echo-state t
        evil-cross-lines t
        evil-shift-width 2
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-emacs-state-cursor 'bar
        evil-disable-insert-state-bindings t)
  (use-package undo-tree
    :ensure t
    :diminish undo-tree-mode)
  (use-package evil-leader
    :ensure t
    :init (global-evil-leader-mode)
    :config
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "f d" #'ido-dired
      "f f" #'ido-find-file
      )
    (evil-mode))
  ;; 下面的几个全局按键绑定不是一定要写在这里——
  ;; 而写在这里的唯一理由是帮助修复错误的缩进……
  :bind (("<f8>" . open-user-init-file)
         ("C-/" . comment-or-uncomment-region)
         ;; 现在开始才是有用的按键绑定
         :map evil-ex-map
         ("e" . ido-find-file)
         ("b" . ido-switch-buffer)
         :map evil-normal-state-map
         ("j" . evil-next-visual-line)
         ("k" . evil-previous-visual-line))
  :config (use-package evil-surround
            :ensure t
            :config (global-evil-surround-mode)))

(use-package web-mode
  :ensure t
  :init
  (setq web-mode-jsx-depth-faces t
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-enable-element-tag-fontification t)
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode)))

(use-package css-mode
  :ensure t
  :init (setq css-indent-offset 2)
  :config (add-hook 'css-mode-hook #'company-mode))

(use-package js
  :ensure t
  :init (setq js-indent-level 2
              js-enabled-frameworks '(javascript)
              js-switch-indent-offset 2))

(use-package json-mode
  :ensure t
  :init (setq json-reformat:indent-width 2
              json-reformat:pretty-string? t))

(use-package ember-mode
  :ensure t
  :diminish ember-mode)

;; 和 org-mode 相关的配置，有待研究……
(setq org-src-fontify-natively t)

(use-package powerline
  :ensure t
  :config (add-hook 'after-init-hook 'powerline-center-theme))

(use-package spacemacs-theme
  :ensure t
  :defer t
  :init (load-theme 'spacemacs-light t))

(provide 'init)
