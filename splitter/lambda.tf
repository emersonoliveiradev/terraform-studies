data "archive_file" "zip" {
  type        = "zip"
  source_file = "lambdas/split/handler.py"
  output_path = "lambdas/split/handler.zip"
}

data "template_file" "this" {
  template = file("polices/sqs.json")

  vars = {
    AWS_SQS_ARN = aws_sqs_queue.this.arn
  }
}

resource "aws_iam_role" "this" {
  name               = "${local.project}-${local.env}"
  assume_role_policy = file("roles/lambda.json")
}

resource "aws_lambda_function" "this" {
  function_name = join("-", [local.project, "handler", local.env])
  description   = ""

  filename = data.archive_file.zip.output_path
  role     = aws_iam_role.this.arn
  handler  = "handler.handler"
  runtime  = "python3.8"
  timeout  = 60

  environment {
    variables = {
      region = local.region
      queue  = aws_sqs_queue.this.name
    }
  }

  depends_on = [
    aws_iam_role.this,
    aws_sqs_queue.this,
    data.archive_file.zip
  ]
}

resource "aws_iam_policy" "this" {
  name   = join("-", [local.project, "lambda", "sqs", local.env])
  policy = data.template_file.this.rendered
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn

  depends_on = [
    aws_iam_role.this,
    aws_iam_policy.this
  ]
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${local.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
}
