IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-netbsd:
	bash scripts/deploy-netbsd.sh

deploy-openbsd:
	bash scripts/deploy-openbsd.sh

deploy-freebsd:
	bash scripts/deploy-freebsd.sh

deploy-archlinux:
	bash scripts/deploy-archlinux.sh

deploy-susesles:
	bash scripts/deploy-susesles.sh

deploy-opensuse:
	bash scripts/deploy-opensuse.sh

deploy-fedora:
	bash scripts/deploy-fedora.sh

deploy-centos:
	bash scripts/deploy-centos.sh

deploy-debian:
	bash scripts/deploy-debian.sh

deploy-ubuntu:
	bash scripts/deploy-ubuntu.sh

deploy-libvirt:
	bash scripts/deploy-libvirt.sh

deploy-vagrant:
	bash scripts/deploy-vagrant.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-vagrant deploy-libvirt deploy-boxes push-image
