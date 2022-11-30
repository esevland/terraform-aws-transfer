variable "certificate" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the AWS Certificate Manager (ACM) certificate."
  default     = null
}

variable "endpoint_details" {
  type = map(object({
    address_allocation_ids = list(string)
    security_group_ids     = list(string)
    subnet_ids             = list(string)
    vpc_id                 = string
  }))

  description = <<-EOT
    A block required to setup SFTP server if type is set to `VPC` or `VPC_ENDPOINT`
    ```{
      address_allocation_ids = List of address allocation IDs to attach an Elastic IP address to your SFTP server endpoint.
      security_group_ids     = List of security groups to attach to the SFTP endpoint. Supported only if endpoint is to type VPC.
      subnet_ids             = List of subnets ids within the VPC for hosting SFTP server endpoint. Required if endpoint type is set to VPC.
      vpc_id                 = ID of VPC in which SFTP server endpoint will be hosted. Required if endpoint type is set to VPC.
    }```
  EOT
  default     = {}
}

variable "endpoint_type" {
  type        = string
  description = "The type of endpoint that you want your SFTP server connect to."
  default     = "PUBLIC"
}

variable "host_key" {
  type        = string
  description = "RSA private key (e.g., as generated by the ssh-keygen -N \"\" -m PEM -f my-new-server-key command)."
  default     = null
}

variable "logging_role_name" {
  description = "Name of an IAM role that allows the service to write users' activity to CloudWatch logs."
  type        = string
  default     = "transfer-logging-role"
}

variable "transfer_server_name" {
  description = "Name of the AWS Transfer Server. Ignore it to generate a random name for server."
  type        = string
  default     = null
}

variable "protocols" {
  type        = list(string)
  description = "Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint."
  default     = ["SFTP"]
}

variable "security_policy_name" {
  type        = string
  description = "Specifies the name of the security policy that is attached to the server."
  default     = "TransferSecurityPolicy-2022-03"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  default     = {}
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
  default     = ""
}

variable "record_name" {
  description = "The name of the Transfer Server endpoint as a CNAME record."
  type        = string
  default     = ""
}