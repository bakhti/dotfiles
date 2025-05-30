(define-module (ab packages k8s)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (guix licenses)
  #:use-module (gnu packages))

(define-public kubectl
  (package
   (name "kubectl")
   (version "1.32.3")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://dl.k8s.io/release/v" version "/bin/linux/amd64/kubectl"))
     (sha256 (base32 "17ypn8bmijdk0k9ldpq7zjr5nsk199h8ara8l2319dila469s85b"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("kubectl" "bin/kubectl"))
      #:phases
      (modify-phases %standard-phases
		     (add-after 'install 'make-executable
				(lambda* (#:key outputs #:allow-other-keys)
				  (let ((out (assoc-ref outputs "out")))
				    (chmod (string-append out "/bin/kubectl") #o755)
				    #t))))))
   (home-page "https://kubernetes.io")
   (synopsis "CLI tool to manage Kubernetes")
   (description "Command-line tool to interact with Kubernetes clusters")
   (license asl2.0)))

(define-public kind
  (package
   (name "kind")
   (version "0.29.0")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://kind.sigs.k8s.io/dl/v" version "/kind-linux-amd64"))
     (sha256 (base32 "111jzg47g1lp4542j2gk5r00k4ncaz4yfw2zbjs5y1hg8d3dlbn7"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("kind-linux-amd64" "bin/kind"))
      #:phases
      (modify-phases %standard-phases
		     (add-after 'install 'make-executable
				(lambda* (#:key outputs #:allow-other-keys)
				  (let ((out (assoc-ref outputs "out")))
				    (chmod (string-append out "/bin/kind") #o755)
				    #t))))))
   (home-page "https://kind.sigs.k8s.io")
   (synopsis "Kubernetes in Docker")
   (description "kind is a tool for running local Kubernetes clusters using Docker container nodes")
   (license asl2.0)))
