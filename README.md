# ECR Repository

<<<<<<< HEAD
This tiny module allows for terraforming a list of ECR repositories with cross account pull capabilities. You can use the module as such:
=======
This tiny module allows for terraforming an ECR repository with cross account pull capabilities. This works well in a CI pipeline or executed manually.

## Example Usage

``` hcl
module "ecr_repo" {
  source            = "github.com/7factor/terraform-ecr"

  repository_list   = ["repo-a", "repo-b"]
  prod_account_id   = 1234567890
  dev_account_id    = 0987654321
}
```

Instead of defaulting to a single block and forcing users to create as many blocks as they have applications we assume you want to create a list of repositories. This is purely for convenience, and it does reduce the control you have over each individual repo (like lifecycle policies etcetera). We can certainly tackle this later if there is a good reason to support more complex configuration blobs.

This module uses magic to find out the *current* account it's running in which is where all the repositories will be created. We assume that you want to store your artifacts near your CI/CD system and wish to provide cross account access to those. This makes it faster and cheaper because the images don't have far to go.
