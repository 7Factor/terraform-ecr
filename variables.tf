variable "dev_account_id" {
  description = "Account ID for the development account. Allows cross account pulls."
}

variable "prod_account_id" {
  description = "Account ID for the production account. Allows cross account pulls."
}

variable "images_to_keep" {
  default     = 10
  description = "Then number of images to keep in the repo."
}

variable "repository_list" {
  description = "A list of repositories to create."
}
