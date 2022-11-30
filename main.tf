terraform {
  required_version = ">= 0.12.0"

  required_providers {
    aws = ">= 2.70.1"
  }
}

resource "aws_iam_role" "this" {
  name               = var.logging_role_name
  description        = "IAM Role used by AWS Transfer Server to log to Cloudwatch"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  name   = var.logging_role_name
  role   = aws_iam_role.this.name
  policy = data.aws_iam_policy_document.logging_policy.json
}

resource "random_pet" "this" {
  length    = 2
  separator = "-"
}

locals {
  name = var.transfer_server_name == null ? random_pet.this.id : var.transfer_server_name
}

resource "aws_transfer_server" "this" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.this.arn

  endpoint_type = var.endpoint_type
  dynamic "endpoint_details" {
    for_each = var.endpoint_details

    content {
      address_allocation_ids = endpoint_details.value["address_allocation_ids"]
      security_group_ids     = endpoint_details.value["security_group_ids"]
      subnet_ids             = endpoint_details.value["subnet_ids"]
      vpc_id                 = endpoint_details.value["vpc_id"]
    }
  }

  certificate          = var.certificate
  host_key             = var.host_key
  protocols            = var.protocols
  security_policy_name = var.security_policy_name

  tags = merge({
    Name = local.name
  }, var.tags)
}

resource "aws_route53_record" "this" {
  count   = length(var.record_name) > 0 && length(var.zone_id) > 0 ? 1 : 0
  name    = var.record_name
  zone_id = var.zone_id
  type    = "CNAME"
  ttl     = 300
  records = [
    aws_transfer_server.this.endpoint
  ]
}
