resource "aws_cloudwatch_log_group" "this" {
  name = "${local.project}-${local.env}"
}
