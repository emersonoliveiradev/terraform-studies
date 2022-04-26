locals {
  env    = terraform.workspace
  region = var.region

  project = var.project_values.project
  team    = var.project_values.team
  owner   = var.project_values.owner

  instance_values = var.instance_values

  secret_variables = [
    { "APP_USER" : "sheldon" },
    { "APP_PASSWORD" : "bazinga" }
  ]

  tags = {
    Environment   = local.env
    Team          = local.team
    Owner         = local.owner
    Origin        = "terraform"
    State         = "applications/penny/terraform.tfstate"
    Repository    = "https://github.com/emersonoliveiradev/terraform-studies/penny/"
    Documentation = "https://github.com/emersonoliveiradev/terraform-studies/penny/blob/master/README.md"
  }
}
