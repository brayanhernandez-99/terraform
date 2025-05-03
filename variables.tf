# Region
variable "region" {
  description = "La región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

# VPC
variable "vpc_block" {
  description = "Bloque CIDR de la VPC"
  type        = string
  default     = "192.168.0.0/16"
}
