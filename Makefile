.PHONY: all clean test rotabull-dev rws-dev %.libvirt %.vbox %.clean

SHELL := fish

all: rws-dev rotabull-dev

clean:
	for dir in (ls -d output-*); cd $$dir; vagrant destroy -f; cd ..; rm -r $$dir; end

rotabull-dev:
	packer build ./rotabull-dev.pkr.hcl

rws-dev:
	packer build ./rws-dev.pkr.hcl

%.libvirt:
	cp ./output-$*/package.box ./output-$*/$*.box
	vagrant mutate ./output-$*/$*.box libvirt
	rm ./output-$*/$*.box

%.vbox:
	vagrant box add ./output-$*/package.box --name $*

%.clean:
	cd ./output-$*; and vagrant destroy -f
	rm -rf ./output-$*/
