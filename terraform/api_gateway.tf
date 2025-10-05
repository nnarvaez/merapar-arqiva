resource "aws_apigatewayv2_api" "html_api" {
  name          = "DynamicHtmlApi"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.html_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.html_handler.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.html_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.html_api.id
  name        = "$default"
  auto_deploy = true
}
