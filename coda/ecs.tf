resource "aws_ecs_cluster" "this" {
  name = "${local.project}-${local.env}"

  tags = local.tags
}
