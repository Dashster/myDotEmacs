; comments in Emacs Lisp are designated by a semi-colon

; https://www.emacswiki.org/emacs/InitFile
; Init File
; Your init file contains personal EmacsLisp code that you want to execute when you start Emacs.
; See the Emacs manual (‘C-h r’), node Init File.

; For GnuEmacs, your init file is ~/.emacs, ~/.emacs.el, or ~/.emacs.d/init.el.
;         You can choose to use any of these names. ‘~/’ stands for your home directory.
; For XEmacs, it is ~/.xemacs or ~/.xemacs/init.el.
; For AquamacsEmacs, it is ~/.emacs or ~/Library/Preferences/Aquamacs Emacs/Preferences.el

; load-path is the Emacs Lisp equivalent to PATH
(add-to-list 'load-path "~/.emacs.d/elisp")     ; routines by others
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/EmacsLisp") ; routines by me


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq user-mail-address "simonsdash@aol.com")

(global-set-key (kbd "<f12>") 'shell)
(global-set-key (kbd "<f11>") 'shell)
(global-set-key (kbd "<f10>") 'shell)

 ; turn off tab insertion
(setq indent-tabs-mode nil)
(setq tab-width  4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

; show column numbers (with line numbers) - off by default
; (12,n) if on, versus L12 if off (row and column, versus just row)

(setq line-number-mode t)
(setq column-number-mode t)

;(setq c-default-style "linux"
(setq c-default-style "ellemtel"
          c-basic-offset 3)





; http://emacs.stackexchange.com/questions/2999/how-to-maximize-my-emacs-frame-on-start-up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'color-theme)
(color-theme-initialize)
; (color-theme-xp) ; white background
; (color-theme-dark-blue) ; actually not that dark of a blue
; (color-theme-word-perfect) ; a pretty bright blue, but status line is not showing buffer name on switch buffers
; (color-theme-xemacs) ; this is a light gray/blue background
(color-theme-blue-mood)

; kbd converts string constants - the values that are returned by
; "ctrl-h k"  - into the internal Emacs key representation
(global-set-key (kbd "<f10>") 'replace-string)
(global-set-key (kbd "<f12>") 'shell)


; major-mode for a pascal ("*.pas") file is: pascal-mode

;(if major-mode eq pascal-mode)

; full path of the current file - buffer-filename - both a function and a variable

; http://stackoverflow.com/questions/8397319/how-to-bind-a-key-to-run-a-shell-commmand-in-dired-emacs
; This standard version will put output in an "echo area" at bottom unless output exceeds a 
; certain amouont and then it will create a new window on the right
(global-set-key (kbd "<f4>") (lambda () (interactive) (shell-command "gcc --version")))

; always put output in new window on the right nversus a small amount of lines
; being shown down in the bottom of the program message area
(global-set-key (kbd "<f4>")
                (lambda () 
		  (interactive)
		  ; (with-current-buffer BUFFER-OR-NAME &rest BODY)
                  ; Execute the forms in BODY with BUFFER-OR-NAME temporarily current.
		  ; BUFFER-OR-NAME must be a buffer or the name of an existing buffer.
                  ; The value returned is the value of the last form in BODY. See also
                  ; `with-temp-buffer`.
                  (with-current-buffer 
		     ; (get-buffer-create BUFFER-OR-NAME)
		     ; Return the buffer specified by BUFFER-OR-NAME, creating a new one if needed.
                     (get-buffer-create "*Shell Command Output*")
		     ; Delete the entire contents of the current buffer.
                     (erase-buffer)
		     ; (insert &rest ARGS)
                     (insert 
		         ; Execute shell command COMMAND and return its output as a string.
		         (shell-command-to-string "echo 'hello'"))
                     (display-buffer (current-buffer)))))

; example of defining a function
(defun my_ls ()
  "Lists the contents of the current directory."
  (interactive)
  (shell-command "ls -al /home/user"))


(global-set-key (kbd "<f3>") 'my_ls); Or whatever key you want...

; http://emacswiki.org/emacs/IndentingC
; *****************
; Indenting in C
; *****************

; Curly braces lead to anger. Anger leads to fear. Fear leads to suffering.
;    – kensanata on #emacs

; CC mode for C, C++, Java

; The CC modes (C, C++, Java, etc.) have their own manual, the CC mode manual. 
; (http://cc-mode.sourceforge.net/html-manual/index.html)
; Read it. It’s good for you.

; If you just want to change the indentation level, set ‘c-basic-offset’:

; C indentation to 4 positions
; (setq-default c-basic-offset 4)

; Add it to your ~/.emacs . (or ~/.emacs.d/init.el)

; You can also set it within Emacs: 
; Options → Customize Emacs → Top-level Customization Group → Programming → Languages → C. 
; Here, change ‘C Basic Offset’ and save for future sessions. 
; This will only affect buffers opened after setting, not the ones already open.

; *****************
; Different Styles
; *****************

; Instead of just changing the basic offset, consider switching to a particular style.
; A style defines much more than just the basic offset. There are a number of predefined styles. 
; Take a look at the variable ‘c-style-alist’ to see a list of them.

; You probably don’t want the default style. This is how Emacs indents out of the box:

;    if(foo)
;      {
;        bar++;
;      }

; That’s the “gnu” style. If you don’t want to indent the braces, add something like the following to your ~/.emacs:

;  (setq c-default-style "linux"
;          c-basic-offset 4)

; When this is in effect, Emacs will indent like below instead:

;    if(foo)
;    {
;        bar++;
;    }

; A lower-level way to achieve this is (c-set-offset 'substatement-open 0),
; where substatement-open is the braces’ syntactic context. Press ‘C-c C-o’ to 
; see the syntax at point (and customize its indentation).

; A partial list of the better known C styles:

;    “gnu”: The default style for GNU projects
;    “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;    “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;    “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;    “stroustrup”: What Stroustrup, the author of C++ used in his book
;    “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;    “linux”: What the Linux developers use for kernel development
;    “python”: What Python developers use for extension modules
;    “java”: The default style for java-mode (see below)
;    “user”: When you want to define your own style

; See Indent style article on Wikipedia with examples how different predefined C styles looks like.

; name is from Ellemtel Telecommunications Systems Laboratories in Sweden where 
; Mats Henricson and Erik Nyquist worked in 1990-1992
;(setq c-default-style "linux"
(setq c-default-style "ellemtel"
c-basic-offset 3)


; editing mode add-ons

(require 'd-mode "d-mode.el")
;;   (autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))


