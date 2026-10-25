# Sample Production-Grade Multi-Cloud Workload
# Tested against Checkov, tfsec, and TFLint guardrails

# 1. Azure Secure Storage
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg-prod"
  location = var.azure_region
  tags     = local.common_tags
}

resource "azurerm_storage_account" "storage" {
  name                          = "${var.prefix}safinops01"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  min_tls_version               = "TLS1_2"
  enable_https_traffic_only     = true
  public_network_access_enabled = false

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 30
    }
  }

  tags = local.common_tags
}

# 2. AWS Hardened S3 Bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket        = "${var.prefix}-enterprise-audit-logs"
  force_destroy = false
  tags          = local.common_tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.secure_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3. GCP Secure Storage Bucket
resource "google_storage_bucket" "gcp_bucket" {
  name                        = "${var.prefix}-gcp-enterprise-storage"
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  labels                      = local.common_tags

  versioning {
    enabled = true
  }
}

locals {
  common_tags = {
    Environment        = var.environment
    ManagedBy          = "Terraform"
    Owner              = "Satyajeet"
    DataClassification = "Confidential"
    CostCenter         = "CC-10294"
  }
}
