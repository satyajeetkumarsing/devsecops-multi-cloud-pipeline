terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30.0"
    }
  }
}
