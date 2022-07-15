output "url" {
  description = "Repository URL"
  value       = aws_ecr_repository.this.repository_url
}

output "url_tagged_latest" {
  description = "Repository URL with `latest` tag."
  value       = "${aws_ecr_repository.this.repository_url}:latest"
}

output "arn" {
  description = "Repository ARN."
  value       = aws_ecr_repository.this.arn
}

output "name" {
  description = "Repository name."
  value       = aws_ecr_repository.this.name
}
