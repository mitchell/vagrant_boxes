source "vagrant" "rotabull_dev" {
  provider     = "virtualbox"
  source_path  = "debian/buster64"
  communicator = "ssh"
  template     = "./Vagrantfile.in"
}

build {
  name    = "rotabull_dev"
  sources = ["sources.vagrant.rotabull_dev"]

  provisioner "shell" {
    script          = "./root_provision.sh"
    execute_command = "chmod +x {{ .Path }}; sudo {{ .Path }}"
  }

  provisioner "shell" {
    script = "./provision.sh"
  }
}
