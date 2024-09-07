terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.53"
    }
  }
}

provider "aws" {
	region = var.aws_region
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_iam_role" "awsacademy-role" {
  name = "LabRole"
}

resource "aws_scheduler_schedule" "scheduler_arquivar_pedidos" {
  name       = "scheduler_arquivar_pedidos"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(1 days)"

  target {
    arn      = aws_lambda_function.arquivar_pedido.arn
    role_arn = data.aws_iam_role.awsacademy-role.arn
  }
}

