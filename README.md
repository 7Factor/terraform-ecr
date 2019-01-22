# ECR Repository

This tiny module allows for terraforming an ECR repository with cross account pull capabilities. This works well in a CI pipeline or executed manually.

## Example Usage

``` hcl
module "ecr_repo" {
  source = "github.com/7factor/terraform-ecr"

  repo_name = "golang-starter"
  prod_account_id = 1234567890
  dev_account_id = 0987654321
}
```

See the variables file for descriptions on what each variable does. Note that you can, in fact, set all accounts to the same account identifier--which is kind of worthless--but if you wanted to use this as a basic ECR terraform you could do so. You'd get some wonky policies out of the deal but it would indeed work.

This module uses magic to find out the *current* account it's running in, so bear that in mind when using it. Read `ecr.tf` for more details.
