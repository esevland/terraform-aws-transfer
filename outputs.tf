output "transfer_server_id" {
  description = "The Server ID of the Transfer Server (e.g., s-12345678)."
  value       = aws_transfer_server.this.id
}

output "transfer_server_endpoint" {
  description = "The endpoint of the Transfer Server (e.g., s-12345678.server.transfer.REGION.amazonaws.com)"
  value       = aws_transfer_server.this.endpoint
}
