resource "aws_ecs_service" "this" {
  name                 = "${local.project}-${local.env}"
  cluster              = aws_ecs_cluster.this.id
  task_definition      = aws_ecs_task_definition.this.arn
  desired_count        = 0
  launch_type          = "EC2"
  force_new_deployment = true

  tags       = local.tags
  depends_on = [aws_ecs_cluster.this, aws_ecs_task_definition.this]
}
