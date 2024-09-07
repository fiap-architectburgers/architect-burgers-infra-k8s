data "archive_file" "arquivar_pedido_artefact" {
  output_path = "files/arquivar_pedido_artefact.zip"
  type = "zip"
  source_file = "${local.lambda_path}/arquivar-pedidos/index.mjs"
}


resource "aws_lambda_function" "arquivar_pedido" {
   function_name = "arquivar_pedido"
   handler = "index.handler"
   //role = "arn:aws:iam::003187940490:role/LabRole"
   role = data.aws_iam_role.awsacademy-role.arn
   runtime = "nodejs20.x"
   
   filename = data.archive_file.arquivar_pedido_artefact.output_path
   source_code_hash = data.archive_file.arquivar_pedido_artefact.output_base64sha256
   timeout = 5
   memory_size = 128
   
   tags = local.common_tags
}