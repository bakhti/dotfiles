(use-modules (gnu home)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages version-control)
	     (gnu packages golang)
	     (gnu packages golang-xyz)
	     (gnu packages rust-apps)
	     (gnu packages fonts)
	     (gnu packages shellutils)
	     (ab packages k8s)
	     (ab packages fonts)
	     (ab packages emacs)
	     (gnu home services)
	     (gnu home services shells)
	     (guix gexp))

(home-environment
 (packages
  (list emacs-ef-themes
        emacs-fontaine
        emacs-vertico
        emacs-orderless
        emacs-marginalia
        emacs-corfu
        emacs-consult
        emacs-embark
        emacs-wgrep
        emacs-which-key
        emacs-magit
        emacs-envrc
        emacs-go-mode
	emacs-gptel
        emacs-nerd-icons
	emacs-nerd-icons-completion
	emacs-nerd-icons-corfu
	emacs-nerd-icons-dired
        emacs-vterm
        emacs-ob-go
        emacs-ob-async
        emacs-next-pgtk
        emacs-use-package
        emacs-guix
        emacs-geiser
        emacs-geiser-guile
	emacs-0x0
	emacs-rg
        git
	go
	gopls
	ripgrep
	starship
	kubectl
	kind
	font-jetbrains-mono
	font-iosevka-aile
	font-nerd-iosevka-term
	font-nerd-monofur
	font-nerd-symbols))

 (services
  (list
   (service home-bash-service-type
	    (home-bash-configuration
	     (bashrc
	      (list
	       (local-file "files/bash-prompt"))))))))
