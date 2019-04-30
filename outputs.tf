output "ecr_repository_arns" {
  value       = "${aws_ecr_repository.repos.*.arn}"
  description = "A list of arns of the repositories that were created."
}
