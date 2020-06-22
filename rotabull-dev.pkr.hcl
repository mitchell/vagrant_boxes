source "vagrant" "rotabull-dev" {
  provider     = "virtualbox"
  source_path  = "debian/buster64"
  communicator = "ssh"
  template     = "./Vagrantfile.in"
}

build {
  name    = "rotabull-dev"
  sources = ["sources.vagrant.rotabull-dev"]

  provisioner "shell" {
    script          = "./rotabull_root_provision.sh"
    execute_command = "chmod +x {{ .Path }}; sudo {{ .Path }}"
  }

  provisioner "shell" {
    script = "./rotabull_provision.sh"
  }
}
