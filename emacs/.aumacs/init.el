;; My Emacs from scratch
(setq inhibit-startup-message t)

(scroll-bar-mode -1)          ; Disable visible scrollbar
(tool-bar-mode -1)            ; Disable the toolbar
(tooltip-mode -1)             ; Disable tooltips
(set-fringe-mode 10)          ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Iosevka SS10" :height 120)

(load-theme 'tango-dark t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

;; Set up Ivy
(use-package ivy
  :diminish (ivy-mode . "")
  :init (ivy-mode 1)
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (setq ivy-user-virtual-buffers t))

(use-package counsel
  :bind*
  (("M-x"      . counsel-M-x))
  :config
  (setq ivy-initial-inputs-alist nil))  ;; Don't start searches with ^

(use-package which-key
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
	which-key-side-window-max-width 0.33
	which-key-idle-delay 1)
  :diminish which-key-mode)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 28))
  :config
  (set-face-attribute 'mode-line nil :family "Envy Code R" :height 120)
  (set-face-attribute 'mode-line-inactive nil :family "Envy Code R" :height 120))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :ensure t
  :config
  (general-create-definer anes/leader-keys
    :keymaps '(normal insert visual emacs)   
    :prefix "SPC"
    :global-prefix "C-SPC")

  (anes/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

(defun anes/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (evil-mode 1)
  :hook (evil-mode . anes/evil-hook)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(anes/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projetile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package org
  :ensure t
  :custom
  (org-log-done t)
  (org-agenda-files (list "~/org/gtd.org"))
  (org-todo-keywords
   '((sequence "TODO" "DOING" "WAIT" "VERIFY" "|" "DONE" "CANCEL" "DELEGATE")))
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-babel-default-header-args '((:eval . "never-export")))
  (org-ascii-headline-spacing (quote (1 . 1)))
  (org-startup-indented t)
  (org-pretty-entities t)
  (org-hide-emphasis-markers t)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(300))
  :hook
  (org-mode . variable-pitch-mode)
  (org-mode . visual-line-mode)
  (org-mode . org-indent-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (emacs-lisp . t)
     (org . t)
     (shell . t)
     (python . t)
     (awk . t)
     ))
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)))

(use-package org-superstar
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  (set-face-attribute 'org-superstar-item nil :height 0.7)
  (set-face-attribute 'org-superstar-header-bullet nil :height 0.7)
  (set-face-attribute 'org-superstar-leading nil :height 0.8)
  :custom
  ;; Set different bullets, with one getting a terminal fallback
  ;;(org-superstar-headline-bullets-list
  ;; '("◉" ("🞛" ?◈) "○" "▷"))
  ;; Stop cycling bullets to emphasize hierarchy of headlines
  (org-superstar-cycle-headline-bullets nil)
  ;; Hide away leading stars on terminal
  (org-superstar-leading-fallback ?\s))

(use-package org-autolist
  :config
  (add-hook 'org-mode-hook (lambda () (org-autolist-mode 1))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-v2-ack t)
  (org-roam-directory (file-truename "~/org-roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n c" . org-roam-capture)
	 ;; Dailies
	 ("C-c n d" . org-roam-dailies-goto-today)
	 ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

(use-package org-tree-slide
  :ensure t
  :bind (("<f8>" . org-tree-slide-mode)
	 ("S-<f8>" . org-tree-slide-skip-done-toggle)
	 :map org-tree-slide-mode-map
	 ("<f9>" . org-tree-slide-move-previous-tree)
	 ("<f10>" . org-tree-slide-move-next-tree)
	 ("<f11>" . org-tree-slide-content))
  :custom
  (org-tree-slide-skip-outline-level 4)
  (org-tree-slide-skip-done nil)
  :config
  (org-tree-slide-presentation-profile))

;; Python
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; Editing stuff
;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;; Highlight current line
(global-hl-line-mode 1)

(setq inihibit-compacting-font-caches t)
(let* ((variable-tuple
	(cond ((x-list-fonts "Noto Sans")      '(:font "Noto Sans"))
	      ((x-list-fonts "Roboto")         '(:font "Roboto"))
	      ((x-list-fonts "Fira Sans")      '(:font "Fira Sans"))
	      ((x-list-fonts "Sans Serif")     '(:family "Sans Serif"))
	      (nil (warn "Cannot find a Sans Serif Font. Install Fira Sans."))))
       (base-font-color (face-foreground 'default nil 'default))
       (headline       `(:inherit default :weight bold :foreground, base-font-color)))
  (custom-theme-set-faces
   'user
   `(variable-pitch ((t (:family "Noto Sans" :height 120 :weight medium))))
   `(fixed-pitch ((t (:family "Iosevka SS10" :height 120))))
   `(org-block ((t (:inherit fixed-pitch))))
   `(org-code ((t (:inherit (shadow fixed-pitch)))))
   `(org-document-info ((t (:foreground "dark-orange"))))
   `(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   `(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   `(org-link ((t (:foreground "royal blue" :underline t))))
   `(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   `(org-property-value ((t (:inherit fixed-pitch))) t)
   `(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   `(org-table ((t (:inherit fixed-pitch))))
   `(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.9))))
   `(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
   `(org-todo ((t (:inherit fixed-pitch))))
   `(org-done ((t (:inherit fixed-pitch)))) 
   `(org-date ((t (:inherit fixed-pitch))))
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1 :weight bold))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2 :weight bold))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.4 :weight bold))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.6 :weight bold))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 1.8 :underline nil))))))

;; References
;; https://zzamboni.org/post/beautifying-org-mode-in-emacs/
