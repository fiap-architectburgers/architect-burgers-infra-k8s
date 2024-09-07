locals {
  lambda_path = "${path.module}/lambdas"
  layers_path = "${path.module}/layers"
  
  common_tags = {
    Project = "Lambda layer"
	CreateAt = formatdate("YYYY-MM-DD", timestamp())
	ManagedBy = "Terraform"
	Owner = "Me"
  }
}