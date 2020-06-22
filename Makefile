.PHONY: all clean test

.SHELL := fish

rotabull-dev:
	packer build ./rotabull-dev.pkr.hcl
	cp ./output-rotabull-dev/package.box ./output-rotabull-dev/rotabull-dev.box
	vagrant mutate ./output-rotabull-dev/rotabull-dev.box libvirt
