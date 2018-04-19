(package-initialize)

;;----------------------------------------
;; BASIC
;;----------------------------------------

(require 'package)
(require 'ido)

;; configure package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))

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

;; get solarized xterm colors
;;(require 'xterm-color)

;; show line numbers
(global-linum-mode t)

;;----------------------------------------
;; AUCTEX/LATEX
;;----------------------------------------

(setq TeX-PDF-mode t)
(setq TeX-parse-self t)
(setq reftex-ref-macro-prompt nil)

;; "add-hook" lets you run functions when modes are turned on
;; in this case, turn-on-reftex is run latex mode is started
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; word count latex
(defun latex-word-count ()
  (interactive)
  (shell-command (concat "/usr/bin/texcount "
                         ; "uncomment then options go here "
                         (buffer-file-name))))



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
 '(package-selected-packages
   (quote
    (auctex py-autopep8 material-theme flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
