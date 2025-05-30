(define-module (ab packages fonts)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module ((guix licenses) #:prefix license:))

(define-public font-nerd-symbols
  (package
   (name "font-nerd-symbols")
   (version "3.4.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://github.com/ryanoasis/nerd-fonts"
		  "/releases/download/v" version "/NerdFontsSymbolsOnly.zip"))
	    (sha256
	     (base32
	      "0iscas5bvb8bgk5pcls95nfwjl7yi23q05mili43dzl0p427jqcf"))))
   (build-system font-build-system)
   (home-page "https://www.nerdfonts.com")
   (synopsis "The Nerd Symbols Only font")
   (description "Iconic font aggregator, collection, and patcher. This is Symbols Only font.")
   (license license:expat)))
