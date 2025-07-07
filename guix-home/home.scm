(use-modules (gnu home)
	     (gnu home services)
	     (gnu home services shells)
	     (gnu packages)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages version-control)
	     (gnu packages golang)
	     (gnu packages golang-xyz)
	     (gnu packages rust-apps)
	     (gnu packages fonts)
	     (gnu packages shellutils)
	     (gnu packages tree-sitter)
	     (ab packages k8s)
	     (ab packages fonts)
	     (ab packages emacs)
	     (guix derivations)
	     (guix gexp)
	     (guix packages)
	     (guix store))

(define (tree-sitter-lib-link lang)
  (let* ((package-name (string-append "tree-sitter-" lang))
	 (store (open-connection))
	 (drv (package-derivation store (specification->package package-name)))
         (output-path (derivation->output-path drv))
         (lib-path (string-append output-path "/lib/tree-sitter/libtree-sitter-" lang ".so"))
	 (target-path (string-append ".emacs.d/tree-sitter/libtree-sitter-" lang ".so")))
    (if (file-exists? lib-path)
	`((,target-path ,lib-path))
	'())))

(home-environment
 (packages
  (list emacs-ef-themes
	emacs-expand-region
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
	tree-sitter-go
	tree-sitter-gomod
	ripgrep
	starship
	kubectl
	kind
	helm
	opentofu
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
	       (local-file "files/bash-prompt")))))
   (simple-service 'emacs-daemon-service
		   home-files-service-type
		   `((".config/systemd/user/emacs.service"
		      ,(local-file "files/emacs.service"))))
   (simple-service 'profile-env-vars-service
		   home-environment-variables-service-type
		   `(("VISUAL" . "emacsclient")
		     ("EDITOR" . "emacsclient")))
   (simple-service 'tree-sitter-symlinks
                   home-files-service-type
                   (apply append
			  (map tree-sitter-lib-link '("go" "gomod")))))))
