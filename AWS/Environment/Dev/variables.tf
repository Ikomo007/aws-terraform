variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability zone for the private subnet"
  type        = string
}
