data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "repos" {
  count = "${length(var.repository_list)}"
  name  = "${var.repository_list[count.index]}"
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count      = "${length(var.repository_list)}"
  repository = "${var.repository_list[count.index]}"

  depends_on = ["aws_ecr_repository.repos"]

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last ${var.images_to_keep} images with `any` tag",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.images_to_keep}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

data "template_file" "allow_pull_from_accounts" {
  template = <<EOF

EOF
}

data "template_file" "allow_push_from_accounts" {
  template = <<EOF
 {
    "Sid": "AllowCrossAccountPush",
    "Effect": "Allow",
    "Principal": {
        ${join(",", formatlist("\"AWS\": \"arn:aws:iam::%s:root\"", var.push_account_list))}
    },
    "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability"
    ]
}
EOF
}

# Black voodoo magic nonsense. I can't believe I figured this out.
resource "aws_ecr_repository_policy" "push_from_accounts_policy" {
  count      = "${length(var.push_account_list) > 0 ? length(var.repository_list) : 0}"
  repository = "${var.repository_list[count.index]}"

  depends_on = ["aws_ecr_repository.repos"]

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowCrossAccountPush",
            "Effect": "Allow",
            "Principal": {
                ${join(",", formatlist("\"AWS\": \"arn:aws:iam::%s:root\"", var.push_account_list))}
            },
            "Action": [
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload"
            ]
        }
    ]
}
EOF
}

resource "aws_ecr_repository_policy" "repository_policy" {
  count      = "${length(var.repository_list)}"
  repository = "${var.repository_list[count.index]}"

  depends_on = ["aws_ecr_repository.repos"]

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowCrossAccountPull",
            "Effect": "Allow",
            "Principal": {
                ${join(",", formatlist("\"AWS\": \"arn:aws:iam::%s:root\"", var.pull_account_list))}
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability"
            ]
        }
    ]
}
EOF
}
