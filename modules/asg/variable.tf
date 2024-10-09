variable "min" {
  type = number
  default = 2
}

variable "max" {
  type = number
  default = 4
}

variable "desire" {
  type = number
  default = 4
}

variable "zones" {
  type = list(string)
  default = []
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "image_id" {
  type = string
  default = "ami-0e86e20dae9224db8"
}

variable "target-arn" {
  type = list(string)
  default = ""
}
variable "sg" {
  type = list(string)
  default = []
}
