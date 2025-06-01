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

(define-public font-nerd-iosevka-term
  (package
   (name "font-nerd-iosevka-term")
   (version "3.4.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://github.com/ryanoasis/nerd-fonts"
		  "/releases/download/v" version "/IosevkaTerm.zip"))
	    (sha256
	     (base32
	      "0hf278p1p26gk7sj6bsnz243flhzcz399i0g2s58jlwj8m3h40fl"))))
   (build-system font-build-system)
   (home-page "https://www.nerdfonts.com")
   (synopsis "Iosevka Term Nerd font")
   (description "Nerd-Fonts is the iconic font aggregator, collection, and patcher. This is only the Iosevka Term font.")
   (license license:expat)))

(define-public font-nerd-monofur
  (package
   (name "font-nerd-monofur")
   (version "3.4.0")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://github.com/ryanoasis/nerd-fonts"
		  "/releases/download/v" version "/Monofur.zip"))
	    (sha256
	     (base32
	      "15cr4kn6sgygic3agnsck6kizkw1y51br61dsk4626l2hlxnl7is"))))
   (build-system font-build-system)
   (home-page "https://www.nerdfonts.com")
   (synopsis "Monofur Nerd font")
   (description "Nerd-Fonts is the iconic font aggregator, collection, and patcher. This is only the Monofur font.")
   (license license:silofl1.1)))
