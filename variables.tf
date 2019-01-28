variable "pull_account_list" {
  type        = "list"
  description = "The list of accounts to give pull access to each repository."
}

variable "push_account_list" {
  type        = "list"
  default     = []
  description = "The list of accounts to give push access to each repository. Defaults to nothing, use this in case you're pushing images from a foreign account into the target account containing the ECR repos."
}

variable "images_to_keep" {
  default     = 10
  description = "Then number of images to keep in the repo."
}

variable "repository_list" {
  type        = "list"
  description = "A list of repositories to create. Ensure that you do not change the order of this list when you add more repos or you will have a bad time."
}
