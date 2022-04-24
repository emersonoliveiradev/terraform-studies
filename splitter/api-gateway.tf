resource "aws_api_gateway_rest_api" "this" {
  name        = "${local.project}-${local.env}"
  description = "Proxy to handle requests to API"
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "split"

  depends_on = [
    aws_api_gateway_rest_api.this
  ]
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "POST"
  authorization = "NONE"

  depends_on = [
    aws_api_gateway_rest_api.this,
    aws_api_gateway_resource.this
  ]
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.this.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn

  depends_on = [
    aws_api_gateway_rest_api.this,
    aws_lambda_function.this,
    aws_api_gateway_resource.this,
    aws_api_gateway_method.this
  ]
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  depends_on = [
    aws_api_gateway_rest_api.this,
    aws_api_gateway_integration.this
  ]
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = "api"

  depends_on = [
    aws_api_gateway_rest_api.this,
    aws_api_gateway_deployment.this
  ]
}
