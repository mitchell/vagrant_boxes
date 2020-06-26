.PHONY: all clean test rotabull-dev rws-dev %.libvirt %.vbox %.clean

SHELL := fish

all: rws-dev rotabull-dev

clean:
	rm *.box

rotabull-dev: %.libvirt %.vbox

rws-dev: %.libvirt %.vbox

%.libvirt:
	packer build -only=qemu.debian10 $*

%.vbox:
	packer build -only=virtualbox-iso.debian10 $*

%.clean:
	rm $*.box
