module "burrito_droplet" {
  source = "git::git@github.com:jperez3/taccoform-modules.git//vendors/digitalocean/droplet?ref=new-droplet-module"

  env     = "stg"
  service = "burrito"
}
