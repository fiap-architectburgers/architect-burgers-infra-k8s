output "lambdas" {
  value = [{
    arn          = aws_lambda_function.arquivar_pedido.arn
    name         = aws_lambda_function.arquivar_pedido.function_name
    description  = aws_lambda_function.arquivar_pedido.description
    version      = aws_lambda_function.arquivar_pedido.version
    last_modified = aws_lambda_function.arquivar_pedido.last_modified
  }]
}