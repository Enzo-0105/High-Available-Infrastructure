variable "lb-name" {
  type = string
  default = "web-app-lb"
}

variable "internal-lb" {
  type = bool
  default = false
}

variable "subnets" {
  type = list()
  default = []
}

variable "port" {
  type = string
  default = "80"
}
variable "protocol" {
  type = string
  default = "HTTP"
}
variable "sg" {
  type = list(string)
  default = []
}
variable "vpc_id" {
  type = string
  default = ""
}