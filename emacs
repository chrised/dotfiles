(eval-when-compile
 (require 'use-package))
 (setq use-package-always-ensure t)

(use-package company
 :pin melpa-stable)

(use-package evil)

(package-initialize)

(evil-mode 1)
(setq tramp-default-method "ssh")
