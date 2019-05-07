;;; package --- summary
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;; 以上是Emacs包管理仓库，使用M+x package-list-packages可列出所有包。请不要改变它的位置

; 设置Emacs环境变量，与系统环境变量统一
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     EMacs快捷键配置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mac系统键盘设置
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)

; 在当前窗口打开buffer list，该操作总是在另一个窗口打开，后来就禁用掉了
; 按下 C-x k 立即关闭掉当前的 buffer
(global-set-key "\C-xk" 'kill-this-buffer)

; 查看文件，翻页比较方便，不用 C-v M-v 了。
(global-set-key "\C-c\C-v" 'view-mode)

; 很多文件的时候，在几个文件中跳转到曾经用过的 mark 地方。
(global-set-key "\C-c\C-z" 'pop-global-mark)

; 设置Mark位置
; 操作技巧：C-z C-z设置Mark，C-u C-z回到刚才的位置
(global-set-key "\C-z" 'set-mark-command)

; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)

; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no。
(fset 'yes-or-no-p 'y-or-n-p)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     EMacs行为配置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 设置UTF-8
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'chinese-gbk)

; Mac系统字体设置
(set-face-attribute
 'default nil :font "Monaco Bold 9")
; Chinese Font 配制中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Monaco Bold" :size 6)))

; 不显示工具栏
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil)
(setq-default indent-tabs-mode nil)

;; 启用时间显示设置，在minibuffer上面的那个杠上
(display-time-mode t)
 
;; 使用24小时制 
(setq display-time-24hr-format t)

; 显示行号
(global-linum-mode t)


; 启动后窗口最大化
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; 启动后的默认路径
(setq default-directory "/home/fayecat/code/")

; 不显示 Emacs 的开始画面。
(setq inhibit-startup-message t)

; 任意的打开一个新文件时，缺省使用 text-mode。
(setq default-major-mode 'text-mode)

; 存盘的时候，要求最后一个字符时换行符。
(setq require-final-newline t)

; mini buffer 的大小保持不变。
(setq resize-mini-windows nil)

; 当光标在行尾上下移动的时候，始终保持在行尾。
(setq track-eol t)

;; 开启匹配括号高亮
(show-paren-mode 1)
; 如果括号高亮可用的话高亮括号，否则高亮表达式
(setq show-paren-style 'mixed)

; 当有两个文件名相同的缓冲时，使用前缀的目录名做 buffer 名字，不用原来的
(setq uniquify-buffer-name-style 'forward)

; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。
(setq suggest-key-bindings 1)

; 当行数超过一定数值，不再显示行号。
(setq line-number-display-limit 1000000)

; Emacs 中，改变文件时，默认都会产生备份文件(以 ~ 结尾的文件)。可以完全去掉
; (并不可取)，也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一
; 个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的两个版本和最新的
; 五个版本。并且备份的时候，备份文件是复本，而不是原件。
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/var/tmp")))
(setq backup-by-copying t)

; 语法高亮。除 shell-mode 和 text-mode 之外的模式中使用语法高亮。
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

; 使用 ediff-file 比较两个文件时，窗口为左右分布
(setq ediff-split-window-function 'split-window-horizontally 
     ediff-window-setup-function 'ediff-setup-windows-plain)

; 困扰已久的TAB
(setq-default  tab-width 2)
(setq js-indent-level 2)
;; 设置主题
;; color-theme-modern 来源https://github.com/emacs-jp/replace-colorthemes
;;(load-theme 'bharadwaj-slate t t)
;;(enable-theme 'bharadwaj-slate)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'solarized-dark t)
(load-theme 'molokai t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     EMacs辅助工具配置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 代码片断
(add-to-list 'load-path
             "~/.emacs.d/elpa/yasnippet-20180620.1750")
(require 'yasnippet)
;(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     编程语言相关配置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 以下是golang的相关设置
; 设置golang路径
(setenv "GOPATH" "/home/fayecat/code/go")
(add-to-list 'exec-path "/home/fayecat/code/go/bin")
; 设置golang代码跳转
(defun my-go-mode-hook ()
  ; 没有该项将导致代码无法跳转
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; 代码跳转快捷键
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; golang 代码保存时自动格式化，并且可以自动调整 import
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

; 设置golang代码自动匹配
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

;; golang代码拼写检查
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     文件模式
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dockerfile 文件模式
(add-to-list 'load-path "/.emacs.d/elpa/dockerfile-mode-20180628.1659")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; yaml 文件模式
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


; 永久启用语法检查器
(add-hook 'after-init-hook #'global-flycheck-mode)

; 保存时检查缓冲区
(setq flycheck-check-syntax-automatically '(mode-enabled save))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     工具配置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck代码语法检查 http://www.flycheck.org/en/latest/
; 永久启用语法检查器
(add-hook 'after-init-hook #'global-flycheck-mode)
; 保存时检查缓冲区
(setq flycheck-check-syntax-automatically '(mode-enabled save))


;; ivy配置，文件查找
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")


;; magit git工具配置，使用起来如丝绸般滑顺
;; 打开当前项目的状态窗口
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)  
  (interactive (if (use-region-p)  
                   (list (region-beginning) (region-end) nil)  
                 (list (line-beginning-position)  
                       (line-beginning-position 2))))  
  (comment-or-uncomment-region beg end arg)  
)  
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)
;move line up down
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [S-C-up] 'move-text-up)
(global-set-key [S-C-down] 'move-text-down)

(global-set-key [M-p] 'move-text-up)
(global-set-key [M-n] 'move-text-down)

(with-eval-after-load 'web-mode
    (setq
     ;; 这些是根层级的style/script/html的缩进(即<style>、<script>等)
     web-mode-style-padding 0
     web-mode-script-padding 0
     web-mode-block-padding 0
     ;; 拒绝默认的/* */样式注释
     web-mode-comment-formats '(("java" . "//") ("javascript" . "//") ("php" . "//")))
    (setq-default
     ;; 这里是通常说的缩进
     web-mode-markup-indent-offset 2
     web-mode-code-indent-offset 2
     web-mode-css-indent-offset 2)
    ;; 单引号和backstick识别为string
    (modify-syntax-entry ?' "\"" web-mode-syntax-table)
    (modify-syntax-entry ?` "\"" web-mode-syntax-table)
    (setq company-backends-web-mode (cdr company-backends-web-mode)) ;; company-css & company-html super slow on osx
    (flycheck-add-mode 'javascript-eslint 'web-mode)
)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; load Indium from its source code
(add-to-list 'load-path "~/projects/indium")
(require 'indium)

;;(require 'company)
;;(require 'company-tern)
;;
;;(add-to-list 'company-backends 'company-tern)
;;(add-hook 'js2-mode-hook (lambda ()
;;                           (tern-mode)
;;                           (company-mode)))
;;                           
;;;; Disable completion keybindings, as we use xref-js2 instead
;;(define-key tern-mode-keymap (kbd "M-.") nil)
;;(define-key tern-mode-keymap (kbd "M-,") nil)
(put 'erase-buffer 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c5204945ca5cdf119390fe7f0b375e8d921e92076b416f6615bbe1bd5d80c88" "cb39485fd94dabefc5f2b729b963cbd0bac9461000c57eae454131ed4954a8ac" "b8c5adfc0230bd8e8d73450c2cd4044ad7ba1d24458e37b6dec65607fc392980" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (company-quickhelp ac-js2 js2-mode yasnippet mark-multiple cider auto-compile slime flycheck-cstyle flycheck emmet-mode auto-complete window-numbering react-snippets vue-mode go-dlv go-mode solarized-theme yaml-mode web-mode use-package neotree markdown-mode magit indium helm go-guru go-autocomplete flymd flycheck-mmark flycheck-golangci-lint exec-path-from-shell dockerfile-mode dash-functional counsel company-web company-go color-theme-modern cnfonts avy-flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq js2-mode-show-strict-warnings nil)

(require 'window-numbering)
(window-numbering-mode 1)

;;;;slime configure
(add-to-list 'load-path "/home/fayecat/.emacs.d/elpa/slime-20190105.2006/")
(require 'slime)
(slime-setup '(slime-fancy slime-banner))
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)

(global-auto-complete-mode t)
