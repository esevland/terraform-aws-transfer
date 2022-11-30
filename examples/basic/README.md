# Basic Example

This folder contains a very simple Terraform module to demonstrate how you can use the terraform-aws-transfer module with defaults.

Check out [test/basic_example_test.go](/test/basic_example_test.go) to see how you can test this module.

## Running this module manually

1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Run `terraform init`.
1. Run `terraform apply`.
1. When you're done, run `terraform destroy`.


## Running automated tests against this module

1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
1. `cd test`.
1. `go test -v -timeout 30m`.
