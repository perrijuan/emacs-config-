;;; init.el --- Configuração do Emacs para iniciantes
;;; Commentary:
;; Esta configuração inclui Evil Mode (Vim), sintaxe highlighting,
;; auto-complete e outros pacotes úteis para iniciantes.
;;; Code:

;; Configuração básica
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell t)

;; Configuração de pacotes
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Instalar use-package se não estiver instalado
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Evil Mode (Vim)
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Tema (Modus Operandi - tema claro com opções para cores pastéis)
(use-package modus-themes
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-region '(bg-only no-extend)
        modus-themes-paren-match '(bold intense)
        modus-themes-mode-line '(borderless)
        modus-themes-syntax '(alt-syntax)
        modus-themes-hl-line '(accented)
        modus-themes-subtle-line-numbers t
        modus-themes-intense-mouseovers nil
        modus-themes-deuteranopia t
        modus-themes-tabs-accented t
        modus-themes-variable-pitch-ui nil
        modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

        modus-themes-fringes nil ; {nil,'subtle,'intense}

        ;; Options for `modus-themes-lang-checkers' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `straight-underline', `text-also', `background',
        ;; `intense' OR `faint'.
        modus-themes-lang-checkers nil

        ;; Options for `modus-themes-mode-line' are either nil, or a list
        ;; that can combine any of `3d' OR `moody', `borderless',
        ;; `accented', a natural number for extra padding (or a cons cell
        ;; of padding and NATNUM), and a floating point for the height of
        ;; the text relative to the base font size (or a cons cell of
        ;; height and FLOAT)
        modus-themes-mode-line '(accented borderless (padding . 4) (height . 0.9))

        ;; Same as above:
        ;; modus-themes-mode-line '(accented borderless 4 0.9)

        ;; Options for `modus-themes-markup' are either nil, or a list
        ;; that can combine any of `bold', `italic', `background',
        ;; `intense'.
        modus-themes-markup '(background italic)

        ;; Options for `modus-themes-syntax' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
        modus-themes-syntax '(faint green-strings)

        ;; Options for `modus-themes-hl-line' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `accented', `underline', `intense'
        modus-themes-hl-line '(underline accented)

        ;; Options for `modus-themes-paren-match' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `bold', `intense', `underline'
        modus-themes-paren-match '(intense)

        ;; Options for `modus-themes-links' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
        ;; `bold', `italic', `background'
        modus-themes-links '(neutral-underline faint)

        ;; Options for `modus-themes-box-buttons' are either nil (the
        ;; default), or a list that can combine any of `flat', `accented',
        ;; `faint', `variable-pitch', `underline', `all-buttons', the
        ;; symbol of any font weight as listed in `modus-themes-weights',
        ;; and a floating point number (e.g. 0.9) for the height of the
        ;; button's text.
        modus-themes-box-buttons '(variable-pitch flat faint 0.9)

        ;; Options for `modus-themes-prompts' are either nil (the
        ;; default), or a list of properties that may include any of those
        ;; symbols: `background', `bold', `gray', `intense', `italic'
        modus-themes-prompts '(intense bold)

        ;; The `modus-themes-completions' is an alist that reads three
        ;; keys: `matches', `selection', `popup'.  Each accepts a nil
        ;; value (or empty list) or a list of properties that can include
        ;; any of the following (for WEIGHT read further below):
        ;; `matches' means search candidates can be `background', `intense',
        ;; `underline', `italic', WEIGHT
        ;; `selection' means selected result can be `accented', `intense',
        ;; `underline', `italic', `text-also' WEIGHT
        ;; `popup' means the popup interface can be `accented', `intense'
        ;; WEIGHT
        ;; For WEIGHT possible values are `light', `semibold', `bold'
        modus-themes-completions '((matches . (extrabold))
                                   (selection . (semibold accented))
                                   (popup . (accented)))

        modus-themes-mail-citations nil ; {nil,'intense,'faint,'monochrome}

        ;; Options for `modus-themes-region' are either nil (the default),
        ;; or a list of properties that may include any of those symbols:
        ;; `no-extend', `bg-only', `accented'
        modus-themes-region '(accented no-extend)

        ;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
        modus-themes-diffs 'desaturated

        modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

        modus-themes-org-agenda ; this is an alist: read the manual or its doc string
        '((header-block . (variable-pitch 1.3))
          (header-date . (grayscale workaholic bold-today 1.1))
          (event . (accented varied))
          (scheduled . uniform)
          (habit . traffic-light))

        modus-themes-headings ; this is an alist: read the manual or its doc string
        '((1 . (overline background variable-pitch 1.3))
          (2 . (rainbow overline 1.1))
          (t . (semibold))))

  :config
  ;; Load the theme of your choice:
  (load-theme 'modus-operandi t)
  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;; Auto-complete
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  ;; Adicione mais backends se necessário
  (setq company-backends '((company-files
                            company-keywords
                            company-capf
                            company-dabbrev
                            company-dabbrev-code
                            company-yasnippet
                            company-gtags
                            company-etags
                            company-abbrev))))

;; Sintaxe highlighting aprimorada
(use-package tree-sitter
  :config
  (global-tree-sitter-mode))
(use-package tree-sitter-langs)

;; Verificação de sintaxe em tempo real
(use-package flycheck
  :init (global-flycheck-mode))

;; Gerenciamento de projetos
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Framework de conclusão
(use-package ivy
  :diminish
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
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config (counsel-mode 1))

;; Transparência no Emacs quando usado no terminal
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; `pdf-tools`
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))

;; Codeium
(use-package codeium
  :init
  (setq use-dialog-box nil) ; do not use dialog boxes since they are graphical
  (setq codeium/metadata/api_key "your-api-key-here"))

;; SCBL para Lisp
(use-package scbl
  :ensure t
  :hook (emacs-lisp-mode . scbl-mode)
  :config
  (setq scbl-indent-level 2))

;; Adicionar SCBL ao company-mode para Lisp
(use-package company-scbl
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-scbl))

;; Função para customizar a linha de modo
(defun chin/set-mode-line ()
  "Customiza a aparência da linha de modo."
  (let ((focus-bg "#d5d5d5")
        (bg "#e0e0e0")
        (focus-fg "#202020")
        (fg "#404040"))
    (custom-set-faces
     `(mode-line ((t (:background ,focus-bg :foreground ,focus-fg :box (:line-width 4 :color ,focus-bg)))))
     `(mode-line-inactive ((t (:background ,bg :foreground ,fg :box (:line-width 4 :color ,bg))))))))

;; Chame a função para aplicar as mudanças
(chin/set-mode-line)

;;; init.el ends here
