REPO     = {Your_Repo}
IMAGE    = jenkins-sdp
VERSION  = $$(date +%Y%m%d)
#ALT_REG  = quay.io
#REGISTRY = docker.io/library/$(REPO)
#TAG      = $(REGISTRY)/$(IMAGE):$(VERSION)
TAG      = $(REPO)/$(IMAGE):$(VERSION)
#ALT_TAG  = $(ALT_REG)/$(REPO)/$(IMAGE):$(VERSION)

.PHONY: help Makefile 
.ONESHELL: push 


# Put it first so that "make" without argument is like "make help".
help: ## Show target options
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build: ## build container image 
	docker build . -t $(TAG)
#	docker build . -t $(ALT_TAG)

push: ## builds and publishes container image 
#	$(eval user := $(shell read -p "Registry Username: " username; echo $$username))
#	$(eval pass := $(shell read -s -r -p "Registry Token: " token; echo $$token))
#	@echo 
#	@docker login $(REGISTRY) -u $(user) -p $(pass); 
	make build 
	docker tag $(TAG) $(REPO)/$(IMAGE):latest
#	docker tag $(TAG) $(ALT_REG)/$(REPO)/$(IMAGE):latest
	docker push $(TAG)
#	docker push $(ALT_TAG)
	docker push $(REPO)/$(IMAGE):latest
#	docker push $(ALT_REG)/$(REPO)/$(IMAGE):latest

info: 
	@echo "$(TAG) -> $$(dirname $$(git ls-files --full-name Makefile))"

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	echo "Make command $@ not found" 


