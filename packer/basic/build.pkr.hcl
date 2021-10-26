# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "shell" {
    scripts = [
      "files/init.sh",
    ]
  }

}
