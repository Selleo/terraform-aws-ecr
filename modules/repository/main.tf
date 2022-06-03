locals {
  tags = {
    "terraform.module"    = "Selleo/terraform-aws-ecr"
    "terraform.submodule" = "repository"
    "context.namespace"   = var.context.namespace
    "context.stage"       = var.context.stage
    "context.name"        = var.context.name
  }
}

resource "aws_ecr_repository" "this" {
  name                 = "${var.context.namespace}/${var.context.stage}/${var.context.name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    # kms_key = "TODO" if not specified, AWS will use default KMS for ECR
  }

  tags = local.tags

}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = templatefile("${path.module}/policy/lifecycle.json", {
    image_count = var.max_image_count
    day_count   = var.expire_untagged_after
  })
}

# resource "aws_ecr_repository_policy" "this" {
#   repository = aws_ecr_repository.this.name
#   policy     = templatefile("${path.module}/policy/repository.json", {})
# }

