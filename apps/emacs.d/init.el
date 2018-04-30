;;----------------------------------------
;; BASIC
;;----------------------------------------

(package-initialize)
(require 'package)

;; configure package archives
(setq package-archives
      '(("GNU ELPA"     . "http://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)))

;;----------------------------------------
;; APPEARANCE
;;----------------------------------------

;; define a function to split the window more sensibly
(defun my-split-window-sensibly (&optional window)
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
             ;; Split window horizontally.                                                                                                          
             (with-selected-window window
               (split-window-right)))
        (and (window-splittable-p window)
             ;; Split window vertically.                                                                                                            
             (with-selected-window window
               (split-window-below)))
        (and (eq window (frame-root-window (window-frame window)))
             (not (window-minibuffer-p window))
             ;; If WINDOW is the only window on its frame and is not the                                                                            
             ;; minibuffer window, try to split it horizontally disregarding                                                                        
             ;; the value of `split-width-threshold'.                                                                                               
             (let ((split-width-threshold 0))
               (when (window-splittable-p window t)
                 (with-selected-window window
                   (split-window-right))))))))

;; activate split-window-sensibly
(setq split-window-preferred-function 'my-split-window-sensibly)

;; turn on IDO
(require 'ido)
(ido-mode t)

;; turn off tool and menu bars
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Set emacs to display column number
(setq column-number-mode t)

;; turn off distracting cursor blink
(blink-cursor-mode 0)

;; server start lets you use "emacsclient" cmd to send files to running emacs instance
(server-start)

;;ignore compiled files
(add-to-list 'ido-ignore-files "\\.com")

;; show line numbers
(global-linum-mode t)

;; theme
(require 'solarized-theme)
(load-theme 'solarized-dark t)

;; hide the splash screen at startup
(setq inhibit-splash-screen t)

;; hide the scroll bars
(scroll-bar-mode -1)

;; line break words not characters
(visual-line-mode t)

;;----------------------------------------
;; AUCTEX/LATEX
;;----------------------------------------

(setq TeX-PDF-mode t)
(setq TeX-parse-self t)
(setq reftex-ref-macro-prompt nil)

;; turn-on-reftex is run when latex mode is started
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; visual-line-mode for latex-mode
(add-hook 'LaTeX-mode-hook 'visual-line-mode)

;; word count latex
(defun latex-word-count ()
  (interactive)
  (shell-command (concat "/usr/bin/texcount "
                         ; "uncomment then options go here "
                         (buffer-file-name))))

;; set the env for pkg-config to find some libraries for pdf-tools
;; see https://github.com/politza/pdf-tools
(setenv "PKG_CONFIG_PATH"
	(concat
	 "/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig" ";"
	 "/usr/local/lib/pkgconfig" ";"
	 "/opt/X11/lib/pkgconfig" ";"
	 (getenv "OKG_CONFIG_PATH")
	)
)


;;----------------------------------------
;; PYTHON
;;----------------------------------------

(require 'pydoc)
(require 'jedi)
(require 'guru-mode)

;; better whitespace
(require 'whitespace)

;; use pylint
(setq-default python-check-command "pylint")

;;----------------------------------------
;; ORG-MODE
;;----------------------------------------

;; languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)))
   
;; org mode keys
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-return-follows-link t)

;; make rendered latex bigger
(setq org-format-latex-options
      '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                   ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; org mode keys
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-return-follows-link t)

;; make rendered latex bigger
(setq org-format-latex-options
      '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                   ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; ----------------------------------------
;; GLOBAL KEY MAPS
;; ----------------------------------------
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)


;; ----------------------------------------
;; LEAVE THESE BE
;; ----------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (pdf-tools pydoc auctex py-autopep8 material-theme flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; add to path
(add-to-list 'exec-path "/usr/local/bin")

;; fix common error on mac
(set-keyboard-coding-system nil)