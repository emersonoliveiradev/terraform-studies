data "template_file" "user_data" {
  template = file("templates/user-data.sh.tpl")

  vars = {
    ECS_CLUSTER = aws_ecs_cluster.this.name
  }
}

resource "aws_launch_configuration" "this" {
  name_prefix = "${local.project}-${local.env}"

  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name

  image_id        = local.instance_values[local.env][local.region]
  instance_type   = local.instance_values[local.env].instance_type
  security_groups = [aws_security_group.this.id]
  key_name        = "aws-terraform-studies"
  user_data       = data.template_file.user_data.rendered

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name = "${local.project}-${local.env}"

  launch_configuration      = aws_launch_configuration.this.name
  vpc_zone_identifier       = tolist(data.aws_subnet_ids.default.ids)
  max_size                  = 1
  min_size                  = 0
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    data.aws_subnet_ids.default
  ]
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = 1
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}