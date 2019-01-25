variable "account_list" {
  type        = "list"
  description = "The list of accounts to give access to each repository. All or none."
}

variable "images_to_keep" {
  default     = 10
  description = "Then number of images to keep in the repo."
}

variable "repository_list" {
  type        = "list"
  description = "A list of repositories to create."
}
