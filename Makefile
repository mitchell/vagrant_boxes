.PHONY: all clean test rotabull-dev rws-dev

SHELL := fish

all: rws-dev rotabull-dev

clean:
	for dir in (ls -d output-*); cd $$dir; vagrant destroy -f; cd ..; rm -r $$dir; end

rotabull-dev:
	packer build ./rotabull-dev.pkr.hcl
	cp ./output-rotabull-dev/package.box ./output-rotabull-dev/rotabull-dev.box
	vagrant mutate ./output-rotabull-dev/rotabull-dev.box libvirt

rws-dev:
	packer build ./rws-dev.pkr.hcl
	cp ./output-rws-dev/package.box ./output-rws-dev/rws-dev.box
	vagrant mutate ./output-rws-dev/rws-dev.box libvirt
