resource "aws_lambda_function" "html_handler" {
  function_name = "DynamicHtmlHandler"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.13"
  filename      = "${path.module}/../lambda/function.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/function.zip")
  environment {
  variables = {
    DYNAMODB_TABLE = aws_dynamodb_table.dynamic_string.name
  }
}



}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.html_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.html_api.execution_arn}/*/*"
}

