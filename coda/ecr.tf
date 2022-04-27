resource "aws_ecr_repository" "this" {
  name = "${local.project}-${local.env}"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = local.tags
}
