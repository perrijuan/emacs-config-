;; Inicialização do gerenciador de pacotes
(require 'package)
(setq package-check-signature nil) ; Ignorar erros de assinatura
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Atualizar e instalar pacotes se necessário
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Configurações básicas
(setq inhibit-startup-message t) ; Desativa a mensagem de inicialização
(global-display-line-numbers-mode t) ; Ativa números de linha globais
(column-number-mode t) ; Mostra o número da coluna
(setq make-backup-files nil) ; Não cria arquivos de backup
(setq auto-save-default nil) ; Desativa salvamento automático
(fset 'yes-or-no-p 'y-or-n-p) ; Usa respostas curtas para perguntas
(setq ring-bell-function 'ignore) ; Desativa o som de alerta
(show-paren-mode 1) ; Destaca parênteses correspondentes
(setq-default indent-tabs-mode nil) ; Usa espaços ao invés de tabulações
(setq-default tab-width 4) ; Define a largura da tabulação para 4 espaços

;; Org Mode
(use-package org
  :config
  (setq org-ellipsis " ▾") ;; Símbolo para colapsar/expandir
  (setq org-startup-indented t) ;; Indentar visualmente
  (setq org-hide-emphasis-markers t) ;; Ocultar marcadores de ênfase
  (setq org-src-tab-acts-natively t) ;; Ativa indentação nativa para blocos de código
  (setq org-agenda-files '("~/org/agenda.org")) ;; Arquivos de agenda padrão
  (setq org-default-notes-file "~/org/notes.org")) ;; Arquivo de notas padrão

;; Pacotes de melhoria de interface
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.5))

(use-package ivy
  :init (ivy-mode 1)
  :config (setq ivy-use-virtual-buffers t
                ivy-count-format "(%d/%d) "))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

;; Gerenciamento de arquivos e buffers
(use-package projectile
  :init (projectile-mode)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config (setq projectile-completion-system 'ivy))

;; Interface visual
(use-package doom-themes
  :init
  (load-theme 'doom-one t)
  :config
  (set-face-attribute 'default nil :background "unspecified-bg"))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-height 15))

;; Edição de código
(use-package company
  :init (global-company-mode)
  :config (setq company-idle-delay 0.2
                company-minimum-prefix-length 2))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package magit
  :bind (("C-x g" . magit-status)))

;; Sintaxe destacada
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlighting para qualquer linguagem
(use-package tree-sitter)
(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Parede de texto automático
(use-package undo-tree
  :init (global-undo-tree-mode))

;; Expansão de texto
(use-package expand-region
  :bind (("C-=" . er/expand-region)))

;; Comentários fáceis
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; Outras conveniências
(use-package avy
  :bind (("M-s" . avy-goto-char)
         ("M-g f" . avy-goto-line)))

(use-package yasnippet
  :init (yas-global-mode 1))

;; Melhor navegação
(use-package windmove
  :init (windmove-default-keybindings))

;; Parede de textos recentes
(use-package recentf
  :init (recentf-mode 1)
  :config (setq recentf-max-menu-items 25))

;; Evil Mode para usuários de Vim
(use-package evil
  :init (setq evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :config
  (general-create-definer leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode
  (leader
    "f" '(:ignore t :wk "Find file")
    "f f" '(find-file :wk "Find file directly"))
  (leader
    "b" '(:ignore t :wk "Buffer")
    "b f" '(switch-to-buffer :wk "Find a buffer, or create a new one")
    "b k" '(kill-this-buffer :wk "Kill the current buffer")
    "b r" '(revert-buffer :wk "Reload the current buffer"))
  (leader
    "c" '(:ignore t :wk "Comment")
    "c r" '(comment-region :wk "Comment selection")
    "c l" '(comment-line :wk "Comment line"))
  (leader
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Help function")
    "h v" '(describe-variable :wk "Help variable")
    "h m" '(describe-mode :wk "Help mode")
    "h c" '(describe-char :wk "Help character")
    "h k" '(describe-key :wk "Help key/keybind")))

(use-package key-chord
  :init (key-chord-mode 1)
  :config
  (setq key-chord-two-keys-delay 0.5
        key-chord-one-key-delay 0.2)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state))

;; Melhor autocompletar
(use-package vertico
  :init (vertico-mode))

(use-package marginalia
  :init (marginalia-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :init
  (global-corfu-mode)
  (setq corfu-auto t
        corfu-cycle t
        corfu-preselect 'prompt
        corfu-auto-delay 0.2
        corfu-auto-prefix 2)
  (corfu-popupinfo-mode)
  (corfu-history-mode))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; Suporte para Common Lisp
(setq inferior-lisp-program "sbcl")
(use-package slime
  :config
  (setq slime-contribs '(slime-fancy)))

;; Suporte para leitura de PDFs
(use-package pdf-tools
  :init
  (pdf-tools-install) ;; Instala o pdf-tools
  :config
  (setq-default pdf-view-display-size 'fit-page)
  (setq-default pdf-view-resize-factor 1.1))

;; Suporte ao Codeium
(use-package codeium
  :config
  (setq codeium-enable t)
  (setq codeium-completion-mode 'auto))

;; Configurações de transparência para o terminal
(defun set-terminal-transparency ()
  "Configura a transparência para o terminal."
  (interactive)
  (set-frame-parameter nil 'alpha 90)) ;; 90% opaco, ajuste conforme necessário

(add-hook 'after-init-hook 'set-terminal-transparency)

