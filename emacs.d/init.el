;;; init.el --- Milkmacs configuration file

(add-to-list 'load-path "~/.emacs.d/use-package")

;; Turn off mouse interface early in startup to avoid momentary display
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please... jeez
(setq inhibit-startup-screen t)

;;;; use-package
(eval-when-compile
 (require 'use-package))
(setq use-package-always-ensure t)


;;;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
 '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(use-package company
; :pin melpa-stable)

(package-initialize)

(use-package evil)

(evil-mode 1)

(setq tramp-default-method "ssh")

(use-package darkokai-theme)

;;;;; Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
