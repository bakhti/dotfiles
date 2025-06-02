(define-module (ab packages k8s)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression))

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
   (license license:asl2.0)))

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
   (license license:asl2.0)))

(define-public helm
  (package
   (name "helm")
   (version "3.18.1")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://get.helm.sh/helm-v" version "-linux-amd64.tar.gz"))
     (sha256 (base32 "01ac751zxcaizjlmb8jrrn7n4qzwr8z830kjc56g6c7xc7ifiixi"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("helm" "bin/helm"))
      #:phases
      (modify-phases %standard-phases
		     (add-after 'install 'make-executable
				(lambda* (#:key outputs #:allow-other-keys)
				  (let ((out (assoc-ref outputs "out")))
				    (chmod (string-append out "/bin/helm") #o755)
				    #t))))))
   (home-page "https://helm.sh")
   (synopsis "Helm package manager for Kubernetes")
   (description "Helm helps you manage Kubernetes applications - Helm Charts help you define, install, and upgrade even the most complex Kubernetes apps")
   (license license:asl2.0)))

(define license:busl1.1
  (let ((license-type (record-type-descriptor license:expat)))
    ((record-constructor license-type)
     "BUSL-1.1"
     "https://github.com/hashicorp/terraform/blob/main/LICENSE"
     #f)))

(define-public terraform
  (package
   (name "terraform")
   (version "1.12.1")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://releases.hashicorp.com/terraform/"
			 version "/terraform_" version "_linux_amd64.zip"))
     (sha256 (base32 "0z7gjx1zwzqzjvrjwl9p8va1lv5nafx49v39cwd462k606l8pbyw"))))
   (build-system copy-build-system)
   (native-inputs
    `(("unzip" ,unzip)))
   (arguments
    `(#:install-plan
      '(("terraform" "bin/terraform"))
      #:phases
      (modify-phases %standard-phases
		     (add-after 'install 'make-executable
				(lambda* (#:key outputs #:allow-other-keys)
				  (let ((out (assoc-ref outputs "out")))
				    (chmod (string-append out "/bin/terraform") #o755)
				    #t))))))
   (home-page "https://terraform.io")
   (synopsis "Tool for building, changing, and versioning infrastructure safely and efficiently")
   (description "Terraform enables you to safely and predictably create, change, and improve infrastructure")
   (license license:busl1.1)))
