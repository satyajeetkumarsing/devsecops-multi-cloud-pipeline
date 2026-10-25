variable "prefix" {
  description = "Resource prefix for naming convention"
  type        = string
  default     = "satyajeet"
}

variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "production"
}

variable "azure_region" {
  description = "Primary Azure deployment region"
  type        = string
  default     = "centralindia"
}

variable "aws_region" {
  description = "Primary AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "gcp_region" {
  description = "Primary GCP deployment region"
  type        = string
  default     = "asia-south1"
}
