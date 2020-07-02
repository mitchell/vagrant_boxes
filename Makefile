.PHONY: all clean test virtualbox libvirt %.all %.libvirt %.vbox %.clean %.test

.ONESHELL:
SHELL := fish

builds := rws-dev rotabull-dev

virtualbox: test clean $(patsubst %,%.vbox,$(builds))
libvirt: test clean $(patsubst %,%.libvirt,$(builds))
all: virtualbox libvirt
test: $(patsubst %,%.test,$(builds))
clean: $(patsubst %,%.clean,$(builds))

%.libvirt:
	packer build -only=qemu.debian10 $*

%.vbox:
	packer build -only=virtualbox-iso.debian10 $*

%.clean:
	rm -f $*.box

%.test:
	packer validate $*
