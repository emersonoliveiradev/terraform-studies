terraform {
  backend "s3" {
    encrypt = "true"
    region  = "us-east-1"
    bucket  = "emersonoliveiradev-tfstate-sdx"
    key     = "applications/terraform-studies/splitter/terraform.tfstate"
    # dynamodb_table = "terraform-studies-locks"
  }
}

provider "aws" {
  region = local.region
}
