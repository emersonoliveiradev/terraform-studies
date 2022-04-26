data "template_file" "environments" {
  template = file("templates/enviroments.tpl")

  vars = {
    APP_ENV    = local.env
    APP_NAME   = local.project
    AWS_REGION = local.region
  }
}

data "template_file" "secrets" {
  count    = length(local.secret_variables)
  template = file("templates/secrets.tpl")

  vars = {
    KEY   = element(keys(local.secret_variables[count.index]), 0)
    VALUE = element(aws_ssm_parameter.this.*.arn, count.index)
  }
}

data "template_file" "this" {
  template = file("templates/container-definitions.json.tpl")

  vars = {
    NAME           = "${local.project}-${local.env}"
    ENVIRONMENT    = join(",", data.template_file.environments.*.rendered)
    SECRET         = join(",", data.template_file.secrets.*.rendered)
    AWS_REGION     = local.region
    AWS_ECR_ARN    = aws_ecr_repository.this.repository_url
    AWS_LOGS_GROUP = aws_cloudwatch_log_group.this.name
  }
}

resource "aws_ecs_task_definition" "this" {
  family                = "${local.project}-${local.env}"
  container_definitions = data.template_file.this.rendered
  network_mode          = "bridge"
  execution_role_arn    = aws_iam_role.ecs_execution_role.arn

  tags = local.tags
  depends_on = [
    data.aws_vpc.default,
    aws_ecr_repository.this,
    aws_cloudwatch_log_group.this
  ]
}
