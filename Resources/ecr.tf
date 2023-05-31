module "ecr-repo" {
  source = "../ECR"
  ecr_name = var.ECR_NAME
  tags = var.TAGS
  image_mutability = var.IMAGE_MUTABILITY
}