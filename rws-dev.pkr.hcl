source "vagrant" "rws-dev" {
  provider     = "virtualbox"
  source_path  = "debian/buster64"
  communicator = "ssh"
  template     = "./Vagrantfile.in"
}

build {
  name    = "rws-dev"
  sources = ["sources.vagrant.rws-dev"]

  provisioner "shell" {
    script          = "./rws_root_provision.sh"
    execute_command = "chmod +x {{ .Path }}; sudo {{ .Path }}"
  }

  provisioner "shell" {
    script = "./rws_provision.sh"
  }
}
