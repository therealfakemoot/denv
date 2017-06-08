;;; ~/.emacs.d/init.el

;;; Startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(fset 'yes-or-no-p 'y-or-n-p)
(global-visual-line-mode t)
(show-paren-mode t)
(xterm-mouse-mode t)

(load-theme 'tango-dark)
(set-face-attribute
 'default nil
 :family "Monospace" :weight 'normal
 :height 96 :width 'normal)


;;; Better Defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq initial-scratch-message nil
      inhibit-splash-screen t
      inhibit-startup-buffer-menu t
      column-number-mode t
      visible-bell t

      prefer-coding-system 'utf-8
      set-default-coding-systems 'utf-8
      set-language-environment "UTF-8"
      set-locale-environment "en_US.UTF-8"

      tab-width 4
      c-basic-offset 4
      js-indent-level 2
      indent-tabs-mode nil

      auto-save-default nil
      auto-save-file-name-transforms `((".*" "~/.emacs.d/backup/" t))
      backup-directory-alist `((".*" . "~/.emacs.d/backup/"))
      delete-by-moving-to-trash t
      delete-old-versions t
      delete-selection-mode t
      kept-new-versions 2
      load-prefer-newer t
      vc-follow-symlinks t
      vc-make-backup-files t
      version-control t

      mouse-wheel-follow-mouse 't
      mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(3 ((shift) . 3))
      mouse-yank-at-point t

      require-final-newline t
      save-interprogram-paste-before-kill t
      select-enable-primary nil

      auto-window-vscroll nil
      scroll-conservatively 101
      scroll-down-aggressively 0.0
      scroll-margin 0
      scroll-preserve-screen-position 1
      scroll-step 1
      scroll-up-aggressively 0.0

      eshell-cmpl-cycle-completions nil
      eshell-error-if-no-glob t
      eshell-hist-ignoredups t
      eshell-history-size 4096
      eshell-prefer-lisp-functions nil
      eshell-prompt-function
      (lambda nil
	(concat
	 "[" (user-login-name)"@"(system-name)" "
	 (if (= (length (eshell/pwd))
		(length (getenv "HOME")))
	     "~"
	   (eshell/basename (eshell/pwd)))
	 "]"
	 (if (= (user-uid) 0) "# " "$ ")))

      eshell-prompt-regexp "^[^#$\n]*[#$] "
      eshell-save-history-on-exit t
      eshell-scroll-to-bottom-on-input 'all)


;;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-faces)

(custom-set-variables)


;;; Repositories ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-user-dir "~/.emacs.d/pkg/"
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://stable.melpa.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(use-package package-utils)


;;; Server ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'server)
(unless (server-running-p)
  (server-start))

(defun server-reinstall()
  "Remove packages, then run server-reload"
  (interactive)
  (if (file-exists-p "~/.emacs.d/pkg")
      (delete-directory "~/.emacs.d/pkg" t))
  (server-reload))

(defun server-kill()
  "Delete current Emacs server, then kill Emacs"
  (interactive)
  (server-force-delete)
  (kill-emacs))

(defun server-reload()
  "Reload init file"
  (interactive)
  (if (file-exists-p "~/.emacs.d/init.el")
      (load-file "~/.emacs.d/init.el"))
  (eshell-exports))

(defun server-stop()
  "Prompt to save buffers, then kill Emacs."
  (interactive)
  (save-buffers-kill-emacs))

(defun server-update()
  "Refresh package contents, then update all packages."
  (interactive)
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-utils-upgrade-all))


;;; Extras ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eshell-exports()
  "Store desired environment variables for eshell."
  (setenv "EDITOR" "emacsclient")
  (setenv "GIT_EDITOR" "emacsclient")
  (setenv "PATH" (getenv "PATH"))
  (setenv "PROMPT_COMMAND" "")
  (setenv "SHELL" (getenv "SHELL"))
  (setenv "TERM" (getenv "TERM")))

(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))

(defun eww-new()
  "Open a new instance of eww."
  (interactive)
  (let ((url (read-from-minibuffer "Enter URL or keywords: ")))
    (switch-to-buffer (generate-new-buffer "*eww*"))
    (eww-mode)
    (eww url)))

(defun scratch-new()
  "Open a new scratch buffer."
  (interactive)
  (switch-to-buffer (generate-new-buffer "*scratch*"))
  (lisp-mode))


;;; Input ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x x")           'kill-buffer-and-window)
(global-set-key (kbd "<C-iso-lefttab>") 'previous-buffer)
(global-set-key (kbd "<backtab>")       'previous-buffer)
(global-set-key (kbd "<C-tab>")         'next-buffer)
(global-set-key (kbd "C-x b")           'ibuffer)
(global-set-key (kbd "C-x C-b")         'ibuffer)
(global-set-key (kbd "<M-down>")        'windmove-down)
(global-set-key (kbd "<M-left>")        'windmove-left)
(global-set-key (kbd "<M-right>")       'windmove-right)
(global-set-key (kbd "<M-up>")          'windmove-up)
(global-set-key (kbd "C-c <down>")      'windmove-down)
(global-set-key (kbd "C-c <left>")      'windmove-left)
(global-set-key (kbd "C-c <right>")     'windmove-right)
(global-set-key (kbd "C-c <up>")        'windmove-up)
(global-set-key (kbd "<mouse-4>") (lambda() (interactive)(scroll-down 4)))
(global-set-key (kbd "<mouse-5>") (lambda() (interactive)(scroll-up 4)))

(global-set-key
 (kbd "C-x C-c")
 (lambda() (interactive)
   (if (y-or-n-p "Quit Emacs? ")
       (server-stop))))

(global-set-key
 (kbd "M--")
 (lambda() (interactive)
   (split-window-vertically)
   (other-window 1 nil)
   (switch-to-next-buffer)))

(global-set-key
 (kbd "M-=")
 (lambda() (interactive)
   (split-window-horizontally)
   (other-window 1 nil)
   (switch-to-next-buffer)))

(global-set-key
 (kbd "C-c -")
 (lambda() (interactive)
   (split-window-vertically)
   (other-window 1 nil)
   (switch-to-next-buffer)))

(global-set-key
 (kbd "C-c =")
 (lambda() (interactive)
   (split-window-horizontally)
   (other-window 1 nil)
   (switch-to-next-buffer)))


;;; Editor ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'lisp-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'text-mode-hook 'linum-mode)

(add-hook
 'before-save-hook
 (lambda()
   (delete-trailing-whitespace)
   (if (not indent-tabs-mode)
       (untabify (point-min)(point-max))
     nil)))

(use-package diff-hl
  :init
  (add-hook 'prog-mode-hook 'diff-hl-mode)
  (add-hook 'text-mode-hook 'diff-hl-mode))

;; (use-package highlight-indent-guides
;;   :init
;;   (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;   :config
;;   (setq highlight-indent-guides-method 'character))

(use-package ibuffer-vc
  :init
  (add-hook
   'ibuffer-hook
   (lambda()
     (ibuffer-vc-set-filter-groups-by-vc-root)
     (ibuffer-do-sort-by-alphabetic)
     (ibuffer-do-sort-by-major-mode))))

(use-package rainbow-delimiters
  :init
  (add-hook 'markdown-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'text-mode-hook 'rainbow-delimiters-mode))

(use-package smartparens
  :init
  (add-hook 'markdown-mode-hook 'smartparens-mode)
  (add-hook 'prog-mode-hook 'smartparens-mode)
  (add-hook 'text-mode-hook 'smartparens-mode)
  :config
  (setq sp-highlight-pair-overlay nil
	sp-highlight-wrap-overlay nil
	sp-highlight-wrap-tag-overlay nil))


;;; Languages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package elpy
  :init
  (add-hook 'elpy-mode-hook (lambda() (setq indent-tabs-mode 1)))
  :config
  (elpy-enable))

(use-package geiser)

(use-package go-mode
  :init
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook (lambda() (setq indent-tabs-mode 1))))

(use-package rtags)


;;; Utilities ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package async
  :init
  (async-bytecomp-package-mode '(all)))

(use-package auto-compile
  :init
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package auto-dictionary)

;; (use-package cmake-ide
;;   :init
;;   (cmake-ide-setup))

(use-package company
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'text-mode-hook 'company-mode))

(use-package company-go
  :init
  (setq company-tooltip-limit 20
	company-idle-delay .5
	company-echo-delay 0
	company-begin-commands '(self-insert-command)))

(use-package counsel
  :config
  (global-set-key (kbd "M-x")     'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f")  'counsel-describe-function)
  (global-set-key (kbd "<f1> v")  'counsel-describe-variable)
  (global-set-key (kbd "<f1> l")  'counsel-find-library)
  (global-set-key (kbd "<f2> i")  'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u")  'counsel-unicode-char)
  (global-set-key (kbd "C-c g")   'counsel-git)
  (global-set-key (kbd "C-c j")   'counsel-git-grep)
  (global-set-key (kbd "C-c l")   'counsel-ag)
  (global-set-key (kbd "C-x l")   'counsel-locate)
  (global-set-key (kbd "C-S-o")   'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package flycheck
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode))

(use-package flymake)

(use-package flyspell
  :init
  (add-hook 'flyspell-mode-hook (auto-dictionary-mode 1))
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-mode)
  (add-hook 'text-mode-hook 'flyspell-mode))

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>")    'ivy-resume))

(use-package swiper
  :init
  (global-set-key "\C-s" 'swiper))

(use-package undo-tree
  :init
  (global-undo-tree-mode))

(use-package xclip
  :init
  (xclip-mode 1))


;;; Misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package circe
  :init
  (add-hook 'circe-chat-mode-hook 'my-circe-prompt)
  (add-hook 'circe-message-option-functions 'my-circe-message-option-chanserv)
  (add-hook 'lui-mode-hook (lambda() (my-lui-setup)(my-circe-set-margin)))
  :config
  (require 'circe-chanop)
  (enable-circe-color-nicks)
  (setq circe-default-part-message ""
	circe-default-quit-message ""
	circe-format-server-topic "*** Topic change by {userhost}: {topic-diff}"
	circe-reduce-lurker-spam t
	circe-use-cycle-completion t
	lui-fill-type nil
	lui-flyspell-alist '((".*" "american"))
	lui-flyspell-p t
	lui-time-stamp-format "%H:%M:%S"
	lui-time-stamp-position 'left-margin)
  (defun my-circe-set-margin() (setq left-margin-width 8))
  (setf (cdr (assoc 'continuation fringe-indicator-alist)) nil)
  (defun my-lui-setup()
    (setq fringes-outside-margins t
	  left-margin-width 8
	  word-wrap t
	  wrap-prefix " "))
  (defun my-circe-prompt()
    (lui-set-prompt
     (concat (propertize
              (concat (buffer-name) ">")
              'face 'circe-prompt-face)
             " ")))
  (defun my-circe-message-option-chanserv (nick user host command args)
    (when (and (string= "ChanServ" nick)
               (string-match "^\\[#.+?\\]" (cadr args)))
      '((dont-display . t))))
  (if (file-exists-p "~/.emacs.d/circe.el")
      (load-file "~/.emacs.d/circe.el")))

(add-hook
 'eshell-mode-hook
 (lambda()
   (eshell-exports)
   (add-to-list 'eshell-visual-commands "htop")
   (add-to-list 'eshell-visual-commands "less")
   (add-to-list 'eshell-visual-commands "nano")
   (add-to-list 'eshell-visual-commands "ssh")
   (add-to-list 'eshell-visual-commands "tail")
   (add-to-list 'eshell-visual-commands "top")
   (add-to-list 'eshell-visual-commands "vi")
   (add-to-list 'eshell-visual-commands "vim")
   (add-to-list 'eshell-visual-commands "watch")
   (eshell/alias "clear" "\clear $*")
   (eshell/alias "cr" "cp -ir $*")
   (eshell/alias "df" "df -h $*")
   (eshell/alias "di" "df -hi $*")
   (eshell/alias "dit" "dig +noall +nocmd +answer +multiline $*")
   (eshell/alias "du" "du -h --max-depth=1 | sort -hr $*")
   (eshell/alias "free" "free -h $*")
   (eshell/alias "hurl" "curl --fail --location --remote-name-all --progress-bar $*")
   (eshell/alias "l" "ls -hSC --color=auto --group-directories-first $*")
   (eshell/alias "la" "ls -ahSC --color=auto --group-directories-first $*")
   (eshell/alias "ll" "ls -halS --color=auto --group-directories-first $*")
   (eshell/alias "ls" "ls -hSC --color=auto --group-directories-first $*")
   (eshell/alias "mkdir" "mkdir -vp $*")
   (eshell/alias "mkgz" "tar -vzcf $1.tar.gz $1")
   (eshell/alias "mkxz" "tar -vcJf $1.tar.xz $1")
   (eshell/alias "more" "less $*")
   (eshell/alias "pss" "ps aux | grep -v grep | sort -hrk3 $*")
   (eshell/alias "psw" "watch 'ps aux | grep -v grep | sort -hrk3'")
   (eshell/alias "rf" "rm -rf $*")
   (eshell/alias "rm" "rm -i $*")
   (eshell/alias "rr" "rm -ir $*")
   (eshell/alias "untar" "tar -vxf $*")))

(use-package eww
  :config
  (setq browse-url-browser-function 'eww-browse-url
	shr-blocked-images "http"))

(use-package eww-lnum
  :config
  (define-key eww-mode-map "f" 'eww-lnum-follow)
  (define-key eww-mode-map "F" 'eww-lnum-universal))
