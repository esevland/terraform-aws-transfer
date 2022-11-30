# -------------------------------------------------------------------------------------------------
# PIN TERRAFORM VERSION TO >= 0.12
# The example has been upgraded to 0.12 syntax
# -------------------------------------------------------------------------------------------------

terraform {
  # This module has been tested with Terraform 0.13.x. However, to make upgrading easier, I am
  # setting 0.12.26 as the minimum version, as that version added support for required_providers
  # with source URLs, making it forwards compatible with 0.13.x and up code.
  required_version = ">= 0.12.26"
}

provider "aws" {
  region = "us-east-1"
}

# -------------------------------------------------------------------------------------------------
# BASIC EXAMPLE
# See test/basic_example_test.go for the automated test for this code.
# -------------------------------------------------------------------------------------------------

module "test" {
  source = "../.."
}
