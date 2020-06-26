build {
  name    = "rws-dev"
  sources = [
    "sources.virtualbox-iso.debian10",
    "sources.qemu.debian10",
  ]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | sudo -S env {{ .Vars }} {{ .Path }}"
    script          = "rws-dev/root_provision.sh"
  }

  provisioner "shell" {
    script = "rws-dev/provision.sh"
  }

  provisioner "shell" {
    execute_command   = "echo 'vagrant' | sudo -S env {{ .Vars }} {{ .Path }}"
    expect_disconnect = true
    environment_vars  = ["HOME_DIR=/home/vagrant"]

    scripts = [
        "bento/packer_templates/debian/scripts/update.sh",
        "bento/packer_templates/_common/motd.sh",
        "bento/packer_templates/_common/sshd.sh",
        "bento/packer_templates/debian/scripts/networking.sh",
        "bento/packer_templates/debian/scripts/sudoers.sh",
        "bento/packer_templates/_common/vagrant.sh",
        "bento/packer_templates/debian/scripts/systemd.sh",
        "bento/packer_templates/_common/virtualbox.sh",
        "bento/packer_templates/debian/scripts/cleanup.sh",
        "bento/packer_templates/_common/minimize.sh",
    ]
  }
  
  post-processor "vagrant" {
    output = "rws-dev.box"
  }
}
