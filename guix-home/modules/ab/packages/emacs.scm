(define-module (ab packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-nerd-icons-dired
  (let ((commit "69b5d3176b7bb08ac1f477cf7c5a491b9b0b5b54")
	(revision "0"))
    (package
     (name "emacs-nerd-icons-dired")
     (version (git-version "0.1" revision commit))
     (source
      (origin
       (uri (git-reference
	     (url "https://github.com/rainstormstudio/nerd-icons-dired")
	     (commit commit)))
       (method git-fetch)
       (sha256
	(base32 "1q6zyx2m4h9fnirphrw933w9hrz7s5gk0sqgazgyg57szd99bzc2"))
       (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs (list emacs-nerd-icons))
     (home-page "https://github.com/rainstormstudio/nerd-icons-dired")
     (synopsis "Use nerd-icons for Dired")
     (description "nerd-icons-dired is inspired by all-the-icons-dired")
     (license license:gpl3+))))

(define-public emacs-nerd-icons-completion
  (let ((commit "e15e21a263bad06424982c11e8d68ffe1372a4e7")
	(revision "0"))
    (package
     (name "emacs-nerd-icons-completion")
     (version (git-version "0.1" revision commit))
     (source
      (origin
       (uri (git-reference
	     (url "https://github.com/rainstormstudio/nerd-icons-completion")
	     (commit commit)))
       (method git-fetch)
       (sha256
	(base32 "08ianr8dwxal6dw674ngnaiw6k5kwvsfldmzxhj0fwsqg7ah90l3"))
       (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs (list emacs-nerd-icons emacs-compat))
     (home-page "https://github.com/rainstormstudio/nerd-icons-completion")
     (synopsis "Use nerd-icons for completion")
     (description "nerd-icons-completion is inspired by all-the-icons-completion")
     (license license:gpl3+))))

(define-public emacs-nerd-icons-corfu
  (let ((commit "55b17ee20a5011c6a9be8beed6a9daf644815b5a")
	(revision "0"))
    (package
     (name "emacs-nerd-icons-corfu")
     (version (git-version "0.5.1" revision commit))
     (source
      (origin
       (uri (git-reference
	     (url "https://github.com/LuigiPiucco/nerd-icons-corfu")
	     (commit commit)))
       (method git-fetch)
       (sha256
	(base32 "0h2iphhsag77f14nj95fhkz7yv2ql94acj0c835x2ypkprqrs86w"))
       (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs (list emacs-nerd-icons))
     (home-page "https://github.com/LuigiPiucco/nerd-icons-corfu")
     (synopsis "Icons for Corfu via nerd-icons")
     (description "Nerd-icons-corfu.el is a library for adding icons to completions in Corfu.")
     (license license:gpl3+))))

emacs-nerd-icons-corfu
