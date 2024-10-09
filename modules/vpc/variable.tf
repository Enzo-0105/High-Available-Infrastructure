variable "vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public" {
  type = map(object({
    az   = string
    cidr = string
  }))
  default = {
    subnet-1 = {
      az   = "us-east-1a"
      cidr = "10.0.4.0/24"
    }
    subnet-2 = {
      cidr = "10.0.1.0/24"
      az   = "us-east-1b"
    }
  }
}

variable "private" {
  type = map(object({
    azs   = string
    cidrs = string
  }))
  default = {
    private-1 = {
      azs   = "us-east-1a"
      cidrs = "10.0.12.0/24"
    }
    private-2 = {
      cidrs = "10.0.8.0/24"
      azs   = "us-east-1b"

    }
  }
}