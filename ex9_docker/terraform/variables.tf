variable "user_name" {
  description = "The OpenStack user name"
  type        = string
}

variable "tenant_name" {
  description = "The OpenStack tenant name"
  type        = string
}

variable "password" {
  description = "The OpenStack password"
  type        = string
  sensitive   = true
}

variable "key_pair" {
  description = "The SSH key pair name"
  type        = string
}