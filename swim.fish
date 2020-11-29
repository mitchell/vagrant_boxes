##!/usr/bin/env fish
# Uncomment this line and the last 2 lines of this file to enable running it like `./swim.fish`.
#
# This swim.fish script serves as a central place to store frequently run commands for this project.
# Replace Commands section with your own command functions.
# Source: https://github.com/mitchell/swim.fish

# Configuration

set -g images rotabull-dev rws-dev

# Commands

function swim_build -d 'Build subcommands'
    function build_all -a type -d 'Build all boxes using the specified or all types'
        for image in $images
            packer build -only=$image.$type.debian10 ./$image/
        end
    end

    function build_qemu -a image -d 'Build all or 1 box using QEMU'
        if test -n "$image"
            packer build -only=$image.qemu.debian10 ./$image/
        else
            build_all qemu
        end
    end

    function build_vbox -a image -d 'Build all or 1 box using Virtualbox'
        if test -n "$image"
            packer build -only=$image.virtualbox-iso.debian10 ./$image/
        else
            build_all virtualbox-iso
        end
    end

    run_swim_command 'build' $argv
end

function swim_validate -a image -d 'Validate image configurations'
    if test -n "$image"
        packer validate ./$image/
    else
        for i in $images
            packer validate ./$i/
        end
    end
end

function swim_clean -a image -d 'Clean project'
    if test -n "$image"
        rm -rf $image.box
    else
        for i in $images
            rm -rf $i.box
        end
    end
end

#curl -fsS https://raw.githubusercontent.com/mitchell/swim.fish/master/functions/sw.fish | source
#run_swim_command $cmd_func_prefix $argv
