resource "aws_sqs_queue" "this" {
  name                      = "${local.project}-${local.env}"
  max_message_size          = 262144
  message_retention_seconds = 172800
  receive_wait_time_seconds = 0
  fifo_queue                = false

  tags = local.tags
}
