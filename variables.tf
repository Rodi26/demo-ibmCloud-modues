
variable "name" {
  description = "Name of the Instance"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "subnet name"
  type        = string
}

variable "location" {
  description = "Instance zone"
  type        = string
}

variable "image" {
  description = "Image ID for the instance"
  type        = string
}

variable "profile" {
  description = "Profile type for the Instance"
  type        = string
}

variable "ssh_keys" {
  description = "comma seperated list of ssh key ids"
  type        = string
}

#####################################################
# Optional Parameters
#####################################################

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = null
}


variable "user_data" {
  description = "User Data for the instance"
  type        = string
  default     = null
}

variable "volumes" {
  description = "List of volume ids that are to be attached to the instance"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "List of Tags for the vpc"
  type        = list(string)
  default     = null
}

variable "network_interfaces" {
  description = "List of network_interfaces that are to be attached to the instance"
  type = list(object({
    allow_ip_spoofing    = string
    subnet               = string
    interface_name       = string
    security_groups      = list(string)
    primary_ipv4_address = string
  }))
  default = null
}

variable "boot_volume" {
  description = "List of boot volume that are to be attached to the instance"
  type = list(object({
    name       = string
    snapshot   = string
    encryption = string
  }))
  default = null
}