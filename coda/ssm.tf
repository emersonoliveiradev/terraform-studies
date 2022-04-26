resource "aws_ssm_parameter" "this" {
  count = length(local.secret_variables)

  name        = "/${local.project}-${local.env}/${element(keys(local.secret_variables[count.index]), 0)}"
  description = ""
  value       = element(values(local.secret_variables[count.index]), 0)
  type        = "SecureString"

  tags = local.tags
}