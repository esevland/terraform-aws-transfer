package test

import (
  "testing"
  "github.com/stretchr/testify/assert"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestBasicExample(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    // Source path of Terraform directory.
    TerraformDir: "../examples/basic",
    Upgrade: true,
  }

  // This will run 'terraform init' and 'terraform apply' and will fail the test if any errors occur
  terraform.InitAndApply(t, terraformOptions)

  // To clean up any resources that have been created, run 'terraform destroy' at the end of the test
  defer terraform.Destroy(t, terraformOptions)

  // To get the value of an output variable, run 'terraform output'
  Id := terraform.Output(t, terraformOptions, "server_id")

  // Verify we're getting back the output we expect
  assert.Contains(t, Id, "s-")
}
