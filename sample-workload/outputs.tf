output "azure_storage_account_id" {
  description = "Resource ID of the provisioned Azure Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "aws_s3_bucket_arn" {
  description = "ARN of the provisioned AWS S3 Bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}

output "gcp_storage_bucket_url" {
  description = "Self link URL of the provisioned Google Cloud Storage Bucket"
  value       = google_storage_bucket.gcp_bucket.url
}
