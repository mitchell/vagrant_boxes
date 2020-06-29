source "virtualbox-iso" "debian10" {
  iso_url       = "https://cdimage.debian.org/debian-cd/10.4.0/amd64/iso-cd/debian-10.4.0-amd64-netinst.iso"
  iso_checksum  = "file:https://cdimage.debian.org/debian-cd/10.4.0/amd64/iso-cd/SHA512SUMS"
  guest_os_type = "Debian_64"

  communicator            = "ssh"
  ssh_username            = "vagrant"
  ssh_password            = "vagrant"
  guest_additions_path    = "VBoxGuestAdditions_{{.Version}}.iso"
  virtualbox_version_file = ".vbox_version"

  vm_name              = "debian10"
  headless             = false
  cpus                 = 8
  memory               = 8192
  disk_size            = 40000

  http_directory   = "bento/packer_templates/debian/http"
  shutdown_command = "sudo poweroff"
  boot_command     = [
    "<esc><wait>",
    "install <wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian-9/preseed.cfg <wait>",
    "debian-installer=en_US.UTF-8 <wait>",
    "auto <wait>",
    "locale=en_US.UTF-8 <wait>",
    "kbd-chooser/method=us <wait>",
    "keyboard-configuration/xkb-keymap=us <wait>",
    "netcfg/get_hostname={{ .Name }} <wait>",
    "netcfg/get_domain=local <wait>",
    "fb=false <wait>",
    "debconf/frontend=noninteractive <wait>",
    "console-setup/ask_detect=false <wait>",
    "console-keymaps-at/keymap=us <wait>",
    "grub-installer/bootdev=/dev/sda <wait>",
    "<enter><wait>",
  ]
}
