output "tags" {
  value       = local.tags
  description = "Project tags"
}

output "api-gateway-url" {
  value       = aws_api_gateway_stage.this.invoke_url
  description = "API Gateway url"
}

output "lambda" {
  value = [
    aws_lambda_function.this.arn,
    aws_lambda_function.this.invoke_arn,
    aws_lambda_function.this.function_name
  ]
  description = "Some lambda atributes"
}

output "sqs" {
  value       = aws_sqs_queue.this.url
  description = "SQS url"
}
