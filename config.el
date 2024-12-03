;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they accept
;; NOTE: Use 'M-x doom/reload-font and eval-region to test fonts'
;;
;; FONTS
;; Monaspice
;; NOTE: I like this setup a lot. The major advantage is having a bunch of fonts
;; that are made to work together. I feel like there's a lot of room for customization here.
(setq doom-font (font-spec :family "MonaspiceNe Nerd Font" :size 13 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "MonaspiceNe Nerd Font" :size 16)
      doom-symbol-font (font-spec :family "MonaspiceNe Nerd Font")
      doom-big-font (font-spec :family "MonaspiceNe Nerd Font" :size 24))

(custom-set-faces!
  '(font-lock-comment-face :family "MonaspiceRn Nerd Font" :weight light)
  '(font-lock-constant-face :weight medium)
  '(font-lock-doc-face :family "MonaspiceXe Nerd Font")
  ;; '(font-lock-type-face)
  ;; '(font-lock-function-name-face)
  '(font-lock-string-face :slant oblique))

;; VictorMono
;; (setq doom-font (font-spec :family "VictorMono Nerd Font" :size 13 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "VictorMono Nerd Font" :size 14)
;;       doom-symbol-font (font-spec :family "VictorMono Nerd Font")
;;       doom-big-font (font-spec :family "VictorMono Nerd Font" :size 24))

;; (custom-set-faces!
;;   '(font-lock-comment-face :family "VictorMono Nerd Font" :slant italic)
;;   '(font-lock-constant-face :slant italic)
;;   '(font-lock-doc-face :family "VictorMono Nerd Font")
;;   ;;'(font-lock-type-face)
;;   ;;'(font-lock-function-name-face)
;;   '(font-lock-string-face :slant oblique))

;; Caskaydia
;; (setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 13 :weight 'normal)
;;       doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 14)
;;       doom-symbol-font (font-spec :family "CaskaydiaCove Nerd Font")
;;       doom-big-font (font-spec :family "CaskaydiaCove Nerd Font" :size 24))

;; ;; custom facing
;; (custom-set-faces!
;;   '(font-lock-comment-face :family "CaskaydiaCove Nerd Font" :weight light :slant oblique)
;;   '(font-lock-constant-face :weight medium)
;;   '(font-lock-doc-face :family "CaskaydiaCove Nerd Font")
;;   ;;'(font-lock-type-face)
;;   ;;'(font-lock-function-name-face)
;;   '(font-lock-string-face :slant oblique))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Use 'jk' as an alternate to escape to exit meow-insert-mode
;; https://github.com/meow-edit/meow/discussions/168
(after! meow
  (setq meow-two-char-escape-sequence "jk")
  (setq meow-two-char-escape-delay 0.5)

  (defun meow--two-char-exit-insert-state (s)
    (when (meow-insert-mode-p)
      (let ((modified (buffer-modified-p)))
        (insert (elt s 0))
        (let* ((second-char (elt s 1))
               (event
                (if defining-kbd-macro
                    (read-event nil nil)
                  (read-event nil nil meow-two-char-escape-delay))))
          (when event
            (if (and (characterp event) (= event second-char))
                (progn
                  (backward-delete-char 1)
                  (set-buffer-modified-p modified)
                  (meow--execute-kbd-macro "<escape>"))
              (push event unread-command-events)))))))

  (defun meow-two-char-exit-insert-state ()
    (interactive)
    (meow--two-char-exit-insert-state meow-two-char-escape-sequence))

  (define-key meow-insert-state-keymap (substring meow-two-char-escape-sequence 0 1)
              #'meow-two-char-exit-insert-state))
