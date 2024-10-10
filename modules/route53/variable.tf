provider "aws" {
  region = "us-east-1"  # Primary region
}

variable "primary_region" {
  default = "us-east-1"
}

variable "secondary_region" {
  default = "us-west-2"
}

variable "primary_ip" {
  default = "PRIMARY_IP_ADDRESS"
}

variable "secondary_ip" {
  default = "SECONDARY_IP_ADDRESS"
}

variable "domain_name" {
  default = "example.com"
}
