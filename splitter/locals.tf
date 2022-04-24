locals {
  env    = terraform.workspace
  region = var.region

  project = var.project_values.project
  team    = var.project_values.team
  owner   = var.project_values.owner

  tags = {
    Environment   = local.env
    Team          = local.team
    Owner         = local.owner
    Origin        = "terraform"
    State         = "applications/splitter/terraform.tfstate"
    Repository    = "https://github.com/emersonoliveiradev/terraform-studies/splitter/"
    Documentation = "https://github.com/emersonoliveiradev/terraform-studies/splitter/blob/master/README.md"
  }
}
